import 'package:flutter/material.dart';

class TaskTimer extends StatelessWidget {
  const TaskTimer(
      {super.key, required this.hr, required this.min, required this.sec});
  final String hr;
  final String min;
  final String sec;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 80,
          width: 80,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                hr.length == 1 ? '0$hr' : hr,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context)
                      .colorScheme
                      .onTertiaryContainer
                      .withOpacity(0.9),
                ),
              ),
              const SizedBox(
                width: 2,
              ),
              Text(
                'H',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  height: 2.5,
                  color: Theme.of(context)
                      .colorScheme
                      .onTertiaryContainer
                      .withOpacity(0.9),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Container(
          height: 80,
          width: 80,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                min.length == 1 ? '0$min' : min,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context)
                      .colorScheme
                      .onTertiaryContainer
                      .withOpacity(0.9),
                ),
              ),
              const SizedBox(
                width: 2,
              ),
              Text(
                'M',
                style: TextStyle(
                  height: 2.5,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context)
                      .colorScheme
                      .onTertiaryContainer
                      .withOpacity(0.9),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Container(
          height: 80,
          width: 80,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                sec.length == 1 ? '0$sec' : sec,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context)
                      .colorScheme
                      .onTertiaryContainer
                      .withOpacity(0.9),
                ),
              ),
              const SizedBox(
                width: 2,
              ),
              Text(
                'S',
                style: TextStyle(
                  fontSize: 20,
                  height: 2.5,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context)
                      .colorScheme
                      .onTertiaryContainer
                      .withOpacity(0.9),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
