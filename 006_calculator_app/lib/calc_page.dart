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
  late final TextEditingController _historyController;
  String _selectedSeparator = 'Comma';

  String get _separatorChar {
    return _selectedSeparator == 'Comma' ? ',' : '.';
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: '0');
    _historyController = TextEditingController(text: '');
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
        return StatefulBuilder(
          builder: (context, setStateInDialog) {
            return AlertDialog(
              backgroundColor: const Color.fromARGB(255, 35, 35, 35),
              titleTextStyle: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              contentTextStyle: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
              title: const Text('About the app'),
              content: Theme(
                data: Theme.of(context).copyWith(
                  splashFactory: NoSplash.splashFactory,
                  highlightColor: Colors.transparent,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Author: Tomasz Łachut'),
                    const SizedBox(height: 4),
                    const Text('GitHub: tlachut'),
                    const SizedBox(height: 12),
                    const Text(
                      'This is a simple calculator app created in Flutter',
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Settings',
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 4),
                    const Text('Select a separator:'),
                    RadioListTile<String>(
                      title: const Text(
                        'Comma (,)',
                        style: TextStyle(color: Colors.white70),
                      ),
                      activeColor: Colors.orange,
                      value: 'Comma',
                      groupValue: _selectedSeparator,
                      onChanged: (value) {
                        setStateInDialog(() {
                          _selectedSeparator = value!;
                        });
                      },
                    ),
                    RadioListTile<String>(
                      title: const Text(
                        'Period (.)',
                        style: TextStyle(color: Colors.white70),
                      ),
                      value: 'Period',
                      activeColor: Colors.orange,
                      groupValue: _selectedSeparator,
                      onChanged: (value) {
                        setStateInDialog(() {
                          _selectedSeparator = value!;
                        });
                      },
                    ),
                  ],
                ),
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
                    setState(() {});
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
      },
    );
  }

  bool validateOperation() {
    if (RegExp(
      r'[÷×+,.-]',
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
    if (_controller.text.contains('÷0')) {
      Fluttertoast.showToast(
        msg: 'Error! You can\'t divide by 0.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 18,
        webPosition: 'center',
      );
      _controller.text = '0';
      return false;
    }
    return true;
  }

  num performCalculations() {
    final currentText = _controller.text;
    String expression = currentText
        .replaceAll('÷', '/')
        .replaceAll('×', '*')
        .replaceAll(',', '.')
        .replaceAll(RegExp(r'%+(?!\d)'), '*0.01');

    ExpressionParser p = GrammarParser();
    Expression exp = p.parse(expression);
    ContextModel cm = ContextModel();
    var evaluator = RealEvaluator(cm);
    num eval = evaluator.evaluate(exp);
    return eval;
  }

  void showResult(eval) {
    _historyController.text = '${_controller.text}=';
    if (eval == eval.toInt()) {
      _controller.text = eval.toInt().toString().replaceAll(
        '.',
        _separatorChar,
      );
    } else {
      _controller.text = eval.toString().replaceAll('.', _separatorChar);
    }
  }

  void checkSeparator() {
    final RegExp operatorRegex = RegExp(r'[\+\-\×\÷]');
    final List<String> numbers = _controller.text.split(operatorRegex);

    final String lastNumber = numbers.last;

    if (lastNumber.contains(_separatorChar)) {
      return;
    }

    if (RegExp(
      r'[÷×+,.-]',
    ).hasMatch(
      _controller.text.substring(_controller.text.length - 1),
    )) {
      return;
    }

    _controller.text += _separatorChar;
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
        _historyController.text = '';
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
        checkSeparator();
      }
      // Function responsible for handling text with zero
      else if (_controller.text == '0') {
        if (RegExp(r'[0-9-]').hasMatch(input)) {
          _controller.text = input;
        } else {
          _controller.text += input;
        }
      }
      // Preventing the addition of several special characters in a row.
      else if (RegExp(
            r'[÷×+,.-]',
          ).hasMatch(
            _controller.text.substring(_controller.text.length - 1),
          ) &&
          RegExp(
            r'[÷×+,.-]',
          ).hasMatch(input)) {
        _controller.text =
            _controller.text.substring(
              0,
              _controller.text.length - 1,
            ) +
            input;
      } else if (RegExp(
            r'[÷×+,.-]',
          ).hasMatch(
            _controller.text.substring(_controller.text.length - 1),
          ) &&
          input == '%') {
        return;
      }
      // Basic text input mechanics
      else {
        _controller.text += input;
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
                TextField(
                  enabled: false,
                  textAlign: TextAlign.end,
                  decoration: const InputDecoration(
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 0.0,
                      ),
                    ),
                  ),
                  controller: _historyController,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 24,
                  ),
                ),
                CalcTextField(_controller),
                const SizedBox(height: 36),
                Buttons(handleButtonClick, _separatorChar),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
