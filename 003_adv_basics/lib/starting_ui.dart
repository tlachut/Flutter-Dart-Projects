import 'package:flutter/material.dart';

class StartingUI extends StatelessWidget {
  const StartingUI({super.key});

  void onPressed() {
    //TODO: later
  }

  @override
  Widget build(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/quiz-logo.png',
          width: 300,
        ),
        const Padding(
          padding: EdgeInsets.only(top: 70),
          child: Text(
            'Learn Flutter the fun way!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            onPressed: onPressed,
            icon: const Icon(Icons.arrow_circle_right_outlined),
            label: const Text('Start Quiz'),
          ),
        ),
      ],
    );
  }
}
