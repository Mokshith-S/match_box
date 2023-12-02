import 'package:flutter/material.dart';

class HomeAnimation extends StatefulWidget {
  const HomeAnimation({super.key});

  @override
  State<HomeAnimation> createState() => _HomeAnimationState();
}

class _HomeAnimationState extends State<HomeAnimation>
    with TickerProviderStateMixin {
  late AnimationController _firstStar;
  late AnimationController _secondStar;
  late AnimationController _thirdStar;

  @override
  void initState() {
    super.initState();
    _firstStar = AnimationController(
      animationBehavior: AnimationBehavior.normal,
      vsync: this,
      duration: const Duration(seconds: 3),
      reverseDuration: const Duration(seconds: 3),
    );
    _secondStar = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _thirdStar = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _firstStar.forward();

    _firstStar.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _secondStar.forward();
        _firstStar.reverse();
      }
    });

    _secondStar.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _thirdStar.forward();
        _secondStar.reverse();
      }
    });

    _thirdStar.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _firstStar.forward();
        _thirdStar.reverse();
      }
    });
  }

  @override
  void dispose() {
    _firstStar.dispose();
    _secondStar.dispose();
    _thirdStar.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: double.infinity,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            AlignTransition(
              alignment: Tween(
                begin: Alignment.bottomCenter,
                end: Alignment.center,
              ).animate(
                CurvedAnimation(parent: _firstStar, curve: Curves.easeInOut),
              ),
              child: const Icon(
                Icons.star,
                size: 35,
                color: Colors.blueGrey,
              ),
            ),
            AlignTransition(
              alignment: Tween(
                begin: Alignment.bottomCenter,
                end: Alignment.center,
              ).animate(
                CurvedAnimation(parent: _secondStar, curve: Curves.easeInOut),
              ),
              child: const Icon(
                Icons.flag,
                size: 35,
                color: Colors.lightGreen,
              ),
            ),
            AlignTransition(
              alignment: Tween(
                begin: Alignment.bottomCenter,
                end: Alignment.center,
              ).animate(
                CurvedAnimation(parent: _thirdStar, curve: Curves.easeInOut),
              ),
              child: const Icon(
                Icons.ac_unit,
                size: 35,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
