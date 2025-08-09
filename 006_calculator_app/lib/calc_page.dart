import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:calculator_app/buttons.dart';
import 'package:calculator_app/calc_text_field.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

  _launchURL() async {
    final Uri url = Uri.parse(
      'https://github.com/tlachut/Flutter-Dart-Projects',
    );
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  void showAboutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.black87,
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
          contentTextStyle: const TextStyle(
            color: Colors.white70,
            fontSize: 16,
          ),
          title: const Text('About the app'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Author: Tomasz Łachut'),
              SizedBox(height: 8),
              Text(
                'This is a simple calculator app created in Flutter',
              ),
            ],
          ),
          actions: [
            TextButton.icon(
              onPressed: _launchURL,
              icon: Image.asset(
                'assets/icons/github.png',
                width: 20,
                color: Colors.orange,
              ),
              label: const Text(
                'Show on GitHub',
                style: TextStyle(color: Colors.orange),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.orange,
              ),
              child: const Text(
                'Close',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  bool validateOperation() {
    if (RegExp(
      r'[÷×+,-]',
    ).hasMatch(
      _controller.text.substring(_controller.text.length - 1),
    )) {
      Fluttertoast.showToast(
        msg: 'Error! Special characters were left at the end of the operation.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 18,
        webPosition: 'center',
      );
      return false;
    }
    return true;
  }

  num performCalculations() {
    final currentText = _controller.text;
    final formattedText = currentText.replaceAll('÷', '/');
    final formattedText2 = formattedText.replaceAll('×', '*');
    final formattedText3 = formattedText2.replaceAll(',', '.');
    final formattedText4 = formattedText3.replaceAll('%', '*0.01');
    ExpressionParser p = GrammarParser();
    Expression exp = p.parse(formattedText4);
    ContextModel cm = ContextModel();
    var evaluator = RealEvaluator(cm);
    num eval = evaluator.evaluate(exp);
    return eval;
  }

  void showResult(eval) {
    if (eval == eval.toInt()) {
      _controller.text = eval.toInt().toString();
    } else {
      _controller.text = eval.toString();
    }
  }

  void checkSeparator(String separator) {
    final RegExp operatorRegex = RegExp(r'[\+\-\×\÷]');
    final List<String> numbers = _controller.text.split(operatorRegex);

    final String lastNumber = numbers.last;

    if (lastNumber.contains(separator)) {
      return;
    }

    _controller.text += separator;
  }

  void handleButtonClick(String input) {
    // Handling of clicking the “ⓘ” button
    if (input == 'ⓘ') {
      showAboutDialog();
      return;
    }

    setState(() {
      // Handling of clicking the “AC” button
      if (input == 'AC') {
        _controller.text = '0';
        return;
      }
      // Handling of clicking the “=” button
      else if (input == '=') {
        if (validateOperation() == true) {
          showResult(performCalculations());
        }
        return;
      }
      // Handling of clicking the “,” and "." button
      else if (input == ',' || input == '.') {
        checkSeparator(input);
      }
      // Function responsible for handling text with zero
      else if (_controller.text == '0') {
        if (RegExp(r'[0-9-]').hasMatch(input)) {
          _controller.text = input;
        } else {
          _controller.text = _controller.text + input;
        }
      }
      // Preventing the addition of several special characters in a row.
      else if (RegExp(
            r'[÷×+,-]',
          ).hasMatch(
            _controller.text.substring(_controller.text.length - 1),
          ) &&
          RegExp(
            r'[÷×+,-]',
          ).hasMatch(input)) {
        _controller.text =
            _controller.text.substring(
              0,
              _controller.text.length - 1,
            ) +
            input;
      } else if (RegExp(
            r'[÷×+,-]',
          ).hasMatch(
            _controller.text.substring(_controller.text.length - 1),
          ) &&
          input == '%') {
        _controller.text = _controller.text;
      }
      // Basic text input mechanics
      else {
        _controller.text = _controller.text + input;
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
