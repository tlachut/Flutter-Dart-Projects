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
        Padding(
          padding: const EdgeInsets.only(top: 70),
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
          child: OutlinedButton(
            onPressed: onPressed,
            child: Text(
              'Start Quiz',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
