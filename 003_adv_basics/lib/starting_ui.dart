import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartingUI extends StatelessWidget {
  const StartingUI(this.quizStart, {super.key});

  final Function() quizStart;

  @override
  Widget build(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/quiz-logo.png',
          color: const Color.fromARGB(150, 255, 255, 255),
          width: 300,
        ),
         Padding(
          padding: const EdgeInsets.only(top: 70),
          child: Text(
            'Learn Flutter the fun way!',
            style: GoogleFonts.poppins(
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
            onPressed: quizStart,
            icon: const Icon(Icons.arrow_circle_right_outlined),
            label: const Text('Start Quiz'),
          ),
        ),
      ],
    );
  }
}
