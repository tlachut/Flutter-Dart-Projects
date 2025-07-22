import 'package:flutter/material.dart';
import 'package:adv_basics/starting_ui.dart';

class StartingUIScreen extends StatelessWidget {
  const StartingUIScreen({super.key});

  @override
  Widget build(context) {
    return Container(
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
      child: const Center(
        child: StartingUI(),
      ),
    );
  }
}
