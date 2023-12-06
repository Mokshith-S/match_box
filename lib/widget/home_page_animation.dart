import 'dart:async';

import 'package:flutter/material.dart';

class HomeAnimation extends StatefulWidget {
  const HomeAnimation({super.key});

  @override
  State<HomeAnimation> createState() => _HomeAnimationState();
}

class _HomeAnimationState extends State<HomeAnimation>
    with TickerProviderStateMixin {
  late AnimationController _firstStar;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _firstStar = AnimationController(
      animationBehavior: AnimationBehavior.normal,
      vsync: this,
      duration: const Duration(seconds: 1),
      reverseDuration: const Duration(seconds: 1),
    );
    _firstStar.forward();
    _timer = Timer.periodic(const Duration(seconds: 6), (timer) {
      _firstStar.forward();
    });

    _firstStar.addStatusListener((status) {
      if (AnimationStatus.completed == status) {
        _firstStar.reverse();
      }
    });
  }

  @override
  void dispose() {
    _firstStar.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          padding: const EdgeInsets.all(20),
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              const Positioned(
                top: 45,
                right: 80,
                child: Icon(
                  Icons.dark_mode_sharp,
                  size: 55,
                  color: Colors.white,
                ),
              ),
              Positioned(
                bottom: 20,
                child: FadeTransition(
                  opacity: Tween(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(parent: _firstStar, curve: Curves.linear),
                  ),
                  child: const Icon(
                    Icons.star,
                    size: 25,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                left: 40,
                top: 150,
                child: FadeTransition(
                  opacity: Tween(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(parent: _firstStar, curve: Curves.linear),
                  ),
                  child: const Icon(
                    Icons.star,
                    size: 36,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                right: 40,
                bottom: 100,
                child: FadeTransition(
                  opacity: Tween(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(parent: _firstStar, curve: Curves.linear),
                  ),
                  child: const Icon(
                    Icons.star,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                bottom: 30,
                left: 180,
                child: FadeTransition(
                  opacity: Tween(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(parent: _firstStar, curve: Curves.linear),
                  ),
                  child: const Icon(
                    Icons.star,
                    size: 37,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                top: 170,
                right: 150,
                child: FadeTransition(
                  opacity: Tween(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(parent: _firstStar, curve: Curves.linear),
                  ),
                  child: const Icon(
                    Icons.star,
                    size: 28,
                    color: Colors.white,
                  ),
                ),
              ),
              const Positioned(
                top: 200,
                right: 220,
                child: Icon(
                  Icons.star,
                  size: 33,
                  color: Colors.white,
                ),
              ),
              const Positioned(
                top: 280,
                right: 250,
                child: Icon(
                  Icons.star,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              const Positioned(
                top: 250,
                right: 100,
                child: Icon(
                  Icons.star,
                  size: 21,
                  color: Colors.white,
                ),
              ),
              const Positioned(
                bottom: 70,
                left: 95,
                child: Icon(
                  Icons.star,
                  size: 21,
                  color: Colors.white,
                ),
              ),
              const Positioned(
                top: 80,
                left: 35,
                child: Icon(
                  Icons.star,
                  size: 26,
                  color: Colors.white,
                ),
              ),
              const Positioned(
                top: 105,
                right: 10,
                child: Icon(
                  Icons.star,
                  size: 28,
                  color: Colors.white,
                ),
              ),
              const Positioned(
                top: 255,
                left: 10,
                child: Icon(
                  Icons.star,
                  size: 28,
                  color: Colors.white,
                ),
              ),
              const Positioned(
                bottom: 20,
                right: 26,
                child: Icon(
                  Icons.star,
                  size: 22,
                  color: Colors.white,
                ),
              ),
            ],
          )),
    );
  }
}
