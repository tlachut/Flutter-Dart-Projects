import 'package:flutter/material.dart';
import 'package:adv_basics/starting_ui.dart';
import 'package:adv_basics/question_screen.dart';
import 'package:adv_basics/data/questions.dart';
import 'package:adv_basics/result_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  Widget? activeScreen;

  final List<String> userAnswers = [];

  @override
  void initState() {
    super.initState();
    activeScreen = StartingUI(switchScreen);
  }

  void switchScreen() {
    setState(() {
      activeScreen = QuestionScreen(onChooseAnswer: chooseAnswer);
    });
  }

  void chooseAnswer(String answer) {
    userAnswers.add(answer);

    if (userAnswers.length == questions.length) {
      setState(() {
        activeScreen = ResultScreen(userAnswers: userAnswers);
      });
    }
  }

  @override
  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Quiz App'),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.deepPurple,
                Colors.purple,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: activeScreen,
          ),
        ),
      ),
    );
  }
}
