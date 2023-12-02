import 'dart:async';

import 'package:flutter/material.dart';
import 'package:match_box/logic/matrix.dart';
import 'package:match_box/main.dart';
import 'package:match_box/provider/icon_status.dart';
import 'package:match_box/widget/icon_holder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:match_box/widget/timer_logic.dart';

final clock = Stopwatch();

class MatchScreen extends ConsumerStatefulWidget {
  const MatchScreen({super.key, required this.gameMode});
  final String gameMode;

  @override
  ConsumerState<MatchScreen> createState() => _MatchScreenState();
}

class _MatchScreenState extends ConsumerState<MatchScreen> {
  bool startTimer = false;
  final List<List<IconData>> iconBox = calculate();
  Duration currentTime = const Duration(hours: 0, minutes: 0, seconds: 0);
  Timer? measureTime;

  void changeInteractionState() {
    setState(() {
      startTimer = true;
    });
    clock.start();
    measureTime = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          currentTime = clock.elapsed;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (ref.read(iconStatusProvider.notifier).timerStoptrigger()) {
      clock.stop();
      measureTime!.cancel();
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
                            firstInteraction: changeInteractionState),
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
