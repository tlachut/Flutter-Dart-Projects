import 'package:flutter/material.dart';

class SummaryView extends StatelessWidget {
  const SummaryView({required this.summaryData, super.key});

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: summaryData.map(
          (data) {
            return Row(
              children: [
                Text(((data["question_index"] as int) + 1).toString()),
                Expanded(
                  child: Column(
                    children: [
                      Text(data["question"] as String),
                      Text(data["correct_answer"] as String),
                      Text(data["user_answer"] as String),
                    ],
                  ),
                ),
              ],
            );
          },
        ).toList(),
      ),
    );
  }
}
