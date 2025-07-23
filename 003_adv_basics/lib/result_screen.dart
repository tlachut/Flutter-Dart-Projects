import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:adv_basics/data/questions.dart';
import 'package:adv_basics/summary_view.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    required this.userAnswers,
    required this.restartQuiz,
    super.key,
  });

  final Function() restartQuiz;
  final List<String> userAnswers;

  // Old for loop for getting number of user correct answer written by me
  // int countCorrectAnswers() {
  //   int correctAnswerNO = 0;
  //   for (var i = 0; i < questions.length; i++) {
  //     if (userAnswers[i] == questions[i].answers[0]) {
  //       correctAnswerNO++;
  //     }
  //   }
  //   return correctAnswerNO;
  // }

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < questions.length; i++) {
      summary.add({
        "question_index": i,
        "question": questions[i].question,
        "correct_answer": questions[i].answers[0],
        "user_answer": userAnswers[i],
      });
    }

    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final summaryData = getSummaryData();
    final totalQuestionsNumber = questions.length;
    final userCorrectAnswersNumber = summaryData.where((data) {
      return data["correct_answer"] == data["user_answer"];
    }).length;

    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'You answered $userCorrectAnswersNumber out of $totalQuestionsNumber questions correctly',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SummaryView(summaryData: getSummaryData()),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromARGB(30, 255, 255, 255),
              ),
              onPressed: restartQuiz,
              icon: const Icon(Icons.refresh),
              label: const Text('Restart Quiz!'),
            ),
          ),
        ],
      ),
    );
  }
}
