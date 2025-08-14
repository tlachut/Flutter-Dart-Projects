import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
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

  final List<Meal> _favouriteMeals = [];

  void _toggleFavouriteMealStatus(Meal meal) {
    print(meal);
    final isExisting = _favouriteMeals.contains(meal);
    print(isExisting);
    print(_favouriteMeals);

    if (isExisting) {
      setState(() {
        _favouriteMeals.remove(meal);
      });
      print(_favouriteMeals);
    } else {
      setState(() {
        _favouriteMeals.add(meal);
      });
      print(_favouriteMeals);
    }
  }

  bool _isFavourite(Meal meal) {
    return _favouriteMeals.contains(meal);
  }

  @override
  Widget build(BuildContext context) {
    Widget activeWidget = CategoryScreen(
      onFavouriteMeal: _toggleFavouriteMealStatus,
      isFavourite: _isFavourite,
    );
    String activeTitle = 'Categories';

    if (activeScreenIndex == 1) {
      activeWidget = MealsScreen(
        meals: _favouriteMeals,
        onFavouriteMeal: _toggleFavouriteMealStatus,
        isFavourite: _isFavourite,
      );
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
