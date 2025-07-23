import 'package:flutter/material.dart';

class SummaryView extends StatelessWidget {
  const SummaryView({required this.summaryData, super.key});

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: summaryData.map(
              (data) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(50, 255, 255, 255),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        margin: const EdgeInsets.only(right: 20),
                        decoration: BoxDecoration(
                          color: data["correct_answer"] == data["user_answer"]
                              ? const Color.fromARGB(255, 76, 175, 80)
                              : const Color.fromARGB(255, 244, 67, 54),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            ((data["question_index"] as int) + 1).toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data["question"] as String,
                              style: const TextStyle(
                                color: Color.fromARGB(230, 255, 255, 255),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              data["correct_answer"] as String,
                              style: const TextStyle(
                                color: Color.fromARGB(139, 255, 255, 255),
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  data["correct_answer"] == data["user_answer"]
                                      ? Icons.check
                                      : Icons.close,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: Text(
                                    data["user_answer"] as String,
                                    style: TextStyle(
                                      color:
                                          data["correct_answer"] ==
                                              data["user_answer"]
                                          ? const Color.fromARGB(
                                              255,
                                              29,
                                              68,
                                              30,
                                            )
                                          : const Color.fromARGB(255, 82, 0, 0),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ).toList(),
          ),
        ),
      ),
    );
  }
}
