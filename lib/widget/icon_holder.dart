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
      required this.firstInteraction,
      required this.setGlobalController,
      required this.prevControllerStatus});
  final IconData iconData;
  final int id;
  final bool Function() firstInteraction;
  final void Function(AnimationController controller, bool matchValue)
      setGlobalController;
  final bool Function(IconData iconData, int id) prevControllerStatus;

  @override
  ConsumerState<MatchBoxIcon> createState() => _MatchBoxIconState();
}

class _MatchBoxIconState extends ConsumerState<MatchBoxIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  bool interact = true;
  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
      reverseDuration: const Duration(milliseconds: 200),
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
        if (interact) {
          bool matchValue = false;
          interact = false;
          final skipFirstClick = widget.firstInteraction();
          _fadeController.forward();

          if (skipFirstClick ||
              widget.prevControllerStatus(widget.iconData, widget.id)) {
            matchValue = ref
                .read(iconStatusProvider.notifier)
                .iconMatchStatus(widget.iconData, widget.id);
          }
          widget.setGlobalController(_fadeController, matchValue);
          Future.delayed(const Duration(milliseconds: 1000), () {
            _fadeController.reverse();

            interact = true;
          });
        }
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
