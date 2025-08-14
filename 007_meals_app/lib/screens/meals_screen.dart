import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meal_details_screen.dart';
import 'package:meals_app/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
    required this.onFavouriteMeal,
    required this.isFavourite,
  });

  final String? title;
  final List<Meal> meals;
  final void Function(Meal meal) onFavouriteMeal;
  final bool Function(Meal meal) isFavourite;

  void _selectMeal(BuildContext ctx, Meal meal) {
    Navigator.push(
      ctx,
      MaterialPageRoute(
        builder: (context) => MealDetailsScreen(
          meal: meal,
          onFavouriteMeal: onFavouriteMeal,
          isFavourite: isFavourite(meal),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var content = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Oh no... Nothing here!',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Try selecting a different category',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );

    if (meals.isNotEmpty) {
      content = Center(
        child: ListView.builder(
          itemCount: meals.length,
          itemBuilder: (context, index) => MealItem(
            meal: meals[index],
            onSelectMeal: () {
              _selectMeal(context, meals[index]);
            },
          ),
        ),
      );
    }

    if (title == null) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
