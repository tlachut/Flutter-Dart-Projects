import 'package:flutter/material.dart';
import 'package:adv_basics/gradient_container.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Quiz App'),
        ),
        body: StartingUIScreen(),
      ),
    ),
  );
}
