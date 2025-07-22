import 'package:flutter/material.dart';
import 'package:basics/main_text.dart';
import 'dart:math';

final randomizer = Random();

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() {
    return _DiceRollerState();
  }
}

class _DiceRollerState extends State<DiceRoller> {
  var currentImageNumber = 1;

  void rollDice() {
    setState(() {
      currentImageNumber = randomizer.nextInt(6) + 1;
    });
  }

  @override
  Widget build(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/dice-$currentImageNumber.png',
          width: 200,
        ),
        TextButton(
          style: TextButton.styleFrom(padding: EdgeInsets.only(top: 20)),
          onPressed: rollDice,
          child: const MainText('Roll Dice'),
        ),
      ],
    );
  }
}
