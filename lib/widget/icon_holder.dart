import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:match_box/provider/icon_status.dart';

final generator = Random();

class MatchBoxIcon extends ConsumerStatefulWidget {
  const MatchBoxIcon(
      {super.key,
      required this.iconData,
      required this.id,
      required this.firstInteraction});
  final IconData iconData;
  final int id;
  final void Function() firstInteraction;

  @override
  ConsumerState<MatchBoxIcon> createState() => _MatchBoxIconState();
}

class _MatchBoxIconState extends ConsumerState<MatchBoxIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  // final colorBox = [
  //   Colors.amber,
  //   const Color.fromARGB(255, 255, 69, 0),
  //   const Color.fromARGB(255, 255, 0, 255),
  //   const Color.fromARGB(255, 0, 128, 128),
  //   Colors.cyan,
  //   Colors.green,
  //   Colors.lime,
  //   Colors.red,
  //   const Color.fromARGB(255, 227, 34, 39),
  // ];

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
      reverseDuration: const Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _fadeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.firstInteraction();
        _fadeController.forward();
        ref
            .read(iconStatusProvider.notifier)
            .iconMatchStatus(widget.iconData, widget.id);
        Future.delayed(const Duration(milliseconds: 1000), () {
          _fadeController.reverse();
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
          ),
        ),
        child: !ref
                .watch(iconStatusProvider.notifier)
                .iconCurrentStatus(widget.iconData)
            ? FadeTransition(
                opacity: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                    parent: _fadeController, curve: Curves.easeInOut)),
                child: Container(
                  alignment: Alignment.center,
                  child: Icon(
                    widget.iconData,
                    size: 36,
                  ),
                ),
              )
            : Container(
                alignment: Alignment.center,
                child: Icon(
                  widget.iconData,
                  size: 36,
                ),
              ),
      ),
    );
  }
}
