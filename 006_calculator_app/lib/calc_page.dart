import 'package:flutter/material.dart';

import 'package:calculator_app/buttons.dart';
import 'package:calculator_app/calc_text_field.dart';

class CalcPage extends StatefulWidget {
  const CalcPage({super.key});

  @override
  State<CalcPage> createState() {
    return _CalcPageState();
  }
}

class _CalcPageState extends State<CalcPage> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: '0');
  }

  void handleButtonClick(String input) {
    var currentText = _controller.text;
    print(input);
    if (input == 'ⓘ') {
      return;
    }
    setState(() {
      if (input == 'AC') {
        _controller.text = '0';
        return;
      } else if (currentText == '0') {
        _controller.text = input;
      } else {
        _controller.text = currentText + input;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Calculator',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(220, 0, 0, 0),
                Color.fromARGB(255, 0, 0, 0),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CalcTextField(_controller),
                const SizedBox(height: 36),
                Buttons(handleButtonClick),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
