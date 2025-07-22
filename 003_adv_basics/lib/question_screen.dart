import 'package:flutter/material.dart';

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
        const Text("Question"),
        ElevatedButton(
          onPressed: () {},
          child: const Text("Answer1"),
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text("Answer2"),
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text("Answer3"),
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text("Answer4"),
        ),
      ],
    );
  }
}
