import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:meals_app/models/meal.dart';

class FavouriteStarIcon extends StatefulWidget {
  const FavouriteStarIcon({
    super.key,
    required this.isFavourite,
    required this.onFavouriteMeal,
    required this.meal,
  });

  final void Function(Meal meal) onFavouriteMeal;
  final bool isFavourite;
  final Meal meal;

  @override
  State<FavouriteStarIcon> createState() {
    return _FavouriteStarIconState();
  }
}

class _FavouriteStarIconState extends State<FavouriteStarIcon> {
  late bool _isFavourite;

  @override
  void initState() {
    _isFavourite = widget.isFavourite;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          _isFavourite = !_isFavourite;
          widget.onFavouriteMeal(widget.meal);
        });
      },
      icon: Icon(_isFavourite ? Icons.star : Icons.star_border),
    );
  }
}
