import 'package:flutter/material.dart';
import 'package:meals_app/screens/category_screen.dart';
import 'package:meals_app/screens/meals_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int activeScreenIndex = 0;

  void _changeScreen(int index) {
    setState(() {
      activeScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activeWidget = const CategoryScreen();
    String activeTitle = 'Categories';

    if (activeScreenIndex == 1) {
      activeWidget = const MealsScreen(meals: []);
      activeTitle = 'Your Favourites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activeTitle),
      ),
      body: activeWidget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _changeScreen,
        currentIndex: activeScreenIndex,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favourites',
          ),
        ],
      ),
    );
  }
}
