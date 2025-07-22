import 'package:flutter/material.dart';
import 'package:adv_basics/answer_button.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() {
    return _QuestionScreenState();
  }
}

class _QuestionScreenState extends State<QuestionScreen> {
  @override
  Widget build(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Question",
          style: TextStyle(color: Colors.white),
        ),
        AnswerButton(
          answerText: "Answer 1",
          onTap: () {},
        ),
        AnswerButton(
          answerText: "Answer 2",
          onTap: () {},
        ),
        AnswerButton(
          answerText: "Answer 3",
          onTap: () {},
        ),
        AnswerButton(
          answerText: "Answer 4",
          onTap: () {},
        ),
      ],
    );
  }
}
