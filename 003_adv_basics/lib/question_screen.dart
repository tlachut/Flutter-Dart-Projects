import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:adv_basics/answer_button.dart';
import 'package:adv_basics/data/questions.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({required this.onChooseAnswer, super.key});

  final void Function(String answer) onChooseAnswer;

  @override
  State<QuestionScreen> createState() {
    return _QuestionScreenState();
  }
}

class _QuestionScreenState extends State<QuestionScreen> {
  int currentQuestionNO = 0;

  void nextQuestion(String selectedAnswer) {
    widget.onChooseAnswer(selectedAnswer);
    setState(() {
      currentQuestionNO++;
    });
  }

  @override
  Widget build(context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            questions[currentQuestionNO].question,
            style: GoogleFonts.poppins(
              color: const Color.fromARGB(200, 255, 255, 255),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          ...questions[currentQuestionNO].getShuffledList().map((answer) {
            return AnswerButton(
              answerText: answer,
              onTap: () {
                nextQuestion(answer);
              },
            );
          }),
        ],
      ),
    );
  }
}
