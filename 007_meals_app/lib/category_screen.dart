import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select your category'),
      ),
      body: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 1,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          const Text('1', style: TextStyle(color: Colors.white)),
          const Text('2', style: TextStyle(color: Colors.white)),
          const Text('3', style: TextStyle(color: Colors.white)),
          const Text('4', style: TextStyle(color: Colors.white)),
          const Text('5', style: TextStyle(color: Colors.white)),
          const Text('6', style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
