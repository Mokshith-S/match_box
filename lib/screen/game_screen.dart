import 'dart:async';

import 'package:flutter/material.dart';
import 'package:match_box/logic/matrix.dart';
import 'package:match_box/main.dart';
import 'package:match_box/provider/icon_status.dart';
import 'package:match_box/widget/icon_holder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:match_box/widget/timer_logic.dart';
import 'package:shared_preferences/shared_preferences.dart';

final clock = Stopwatch();

class MatchScreen extends ConsumerStatefulWidget {
  const MatchScreen({super.key, required this.gameMode});
  final String gameMode;

  @override
  ConsumerState<MatchScreen> createState() => _MatchScreenState();
}

class _MatchScreenState extends ConsumerState<MatchScreen> {
  bool globalTimerStart = false;
  final List<List<IconData>> iconBox = calculate();
  Duration currentTime = const Duration(hours: 0, minutes: 0, seconds: 0);
  Timer? measureTime;
  late AnimationController _globalController;
  late bool matched;

  bool changeInteractionState() {
    if (!globalTimerStart) {
      clock.start();
      measureTime = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (mounted) {
          setState(() {
            currentTime = clock.elapsed;
          });
        }
      });
      globalTimerStart = !globalTimerStart;
      return true;
    }
    return false;
  }

  void setGlobalController(AnimationController controller, prevMatched) {
    _globalController = controller;
    matched = prevMatched;
  }

  bool prevControllerStatus(IconData iconData, int id) {
    if (_globalController.isDismissed) {
      if (matched) {
        ref.read(iconStatusProvider.notifier).firstIcon = null;
        ref.read(iconStatusProvider.notifier).firstId = null;
      } else {
        ref.read(iconStatusProvider.notifier).firstIcon = iconData;
        ref.read(iconStatusProvider.notifier).firstId = id;
      }
      return false;
    }

    return true;
  }

  bool compareDuration(String prevRecord) {
    List<String> timer = prevRecord.split(':');
    List<String> timerEndValue = timer[2].split('.');
    final prevTimer = Duration(
        hours: int.parse(timer[0]),
        minutes: int.parse(timer[1]),
        seconds: int.parse(timerEndValue[0]),
        microseconds: int.parse(timerEndValue[1]));
    return prevTimer.compareTo(currentTime) > 0;
  }

  void updateClock() async {
    final pref = await SharedPreferences.getInstance();

    if (pref.getString(widget.gameMode) == null ||
        compareDuration(pref.getString(widget.gameMode)!)) {
      pref.setString(widget.gameMode, currentTime.toString());
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => const AlertDialog(
              title: Text(
                'New Record',
                style: TextStyle(color: Colors.black),
              ),
              content: Text('Congratulations, You have a new record')),
        );
      }
    }
    // pref.setString(widget.gameMode, currentTime.toString());
    clock.reset();
  }

  @override
  Widget build(BuildContext context) {
    if (ref.read(iconStatusProvider.notifier).timerStoptrigger()) {
      clock.stop();
      measureTime!.cancel();
      updateClock();
    }

    ref.watch(iconStatusProvider);
    int counter = 1;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (ctx) => const MatchBoxEntryPage(),
                  ),
                );
              },
              icon: const Icon(Icons.exit_to_app))
        ],
        centerTitle: true,
        title: Text(widget.gameMode),
      ),
      // backgroundColor: Colors.cyanAccent.withOpacity(0.7),
      body: Center(
        child: Container(
          color: Colors.white,
          margin: const EdgeInsets.all(20),
          child: Column(children: [
            TaskTimer(
              hr: (currentTime.inHours % 60).toString(),
              min: (currentTime.inMinutes % 60).toString(),
              sec: (currentTime.inSeconds % 60).toString(),
            ),
            Expanded(
              child: Align(
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                  crossAxisCount: 5,
                  children: [
                    for (int outer = 0; outer < iconBox.length; outer++)
                      for (int inner = 0;
                          inner < iconBox[outer].length;
                          inner++)
                        MatchBoxIcon(
                          iconData: iconBox[outer][inner],
                          id: counter++,
                          firstInteraction: changeInteractionState,
                          setGlobalController: setGlobalController,
                          prevControllerStatus: prevControllerStatus,
                        ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
