import 'package:flutter/material.dart';
import 'package:meals_app/data/category_data.dart';
import 'package:meals_app/data/meals_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key, required this.onFavouriteMeal});

  final void Function(Meal meal) onFavouriteMeal;

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = availableMeals
        .where(
          (meal) => meal.categories.contains(category.id),
        )
        .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MealsScreen(
          meals: filteredMeals,
          title: category.title,
          onFavouriteMeal: onFavouriteMeal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 1,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        for (final cat in availableCategories)
          CategoryGridItem(
            category: cat,
            onSelectCategory: () {
              _selectCategory(context, cat);
            },
          ),
      ],
    );
  }
}
