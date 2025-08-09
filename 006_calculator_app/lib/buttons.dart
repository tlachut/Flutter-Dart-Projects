import 'package:calculator_app/data/buttons_data.dart';
import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  const Buttons(this.handleButtonClick, this.separatorChar, {super.key});

  final Function(String) handleButtonClick;
  final String separatorChar;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          runSpacing: 10.0,
          spacing: 10.0,
          children: [
            ...buttons.map((button) {
              final bool isOriginalSeparatorButton = button.text == ',';
              final String buttonText = isOriginalSeparatorButton
                  ? separatorChar
                  : button.text;

              return OutlinedButton(
                onPressed: () => handleButtonClick(buttonText),
                style: OutlinedButton.styleFrom(
                  backgroundColor: button.type == 'number'
                      ? Colors.grey[800] // If it's a number...
                      : (button.type == 'operator'
                            ? Colors
                                  .orange // Else if it's an operator...
                            : Colors.blueGrey), // Else (it must be an action)
                  foregroundColor: Colors.white,
                  shape: const CircleBorder(),
                  fixedSize: const Size(80, 80),
                  side: const BorderSide(color: Colors.transparent),
                ),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    buttonText,
                    style: const TextStyle(fontSize: 32),
                    softWrap: false,
                  ),
                ),
              );
            }),
          ],
        ),
      ],
    );
  }
}
