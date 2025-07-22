import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:adv_basics/data/questions.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({required this.userAnswers, super.key});
  final List<String> userAnswers;

  int countCorrectAnswers() {
    int correctAnswerNO = 0;
    for (var i = 0; i < questions.length - 1; i++) {
      if (userAnswers[i] == questions[i].answers[0]) {
        correctAnswerNO++;
      }
    }
    return correctAnswerNO;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'You answered ${countCorrectAnswers()} out of ${userAnswers.length} questions correctly',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'List of answers and questions:',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: const Color.fromARGB(220, 255, 255, 255),
              fontSize: 22,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              onPressed: () {},
              icon: const Icon(Icons.refresh),
              label: const Text('Restart Quiz!'),
            ),
          ),
        ],
      ),
    );
  }
}
