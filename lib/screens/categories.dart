import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/category_grid_item.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({
    super.key,
    required this.availableMeals,
  });

  // final void Function(Meal meal) onToggleFavorite;
  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  // late keyword is used to declare a non-nullable variable that will be initialized later.
  // It tells dart this in the end is a variable, which will have a value as soon as
  // it is being used the first time, but not yet when the class is created.
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      // vsync is set to this to use the SingleTickerProviderStateMixin
      // vsync parameter is responsible for making sure that this animation executes
      // for every frame.
      vsync: this,
      duration: const Duration(seconds: 1),
      lowerBound:
          0, // lower bound is used to set the starting value of the animation
      upperBound:
          1, // upper bound is used to set the ending value of the animation
    );

    _animationController.forward(); // starts the animation
  }

  // used to dispose of the animation controller when the widget is removed from the widget tree
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
          // onToggleFavorite: onToggleFavorite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        children: [
          // availableCategories.map((category) => CategoryGridItem(category: category)).toList(),
          for (final category in availableCategories)
            CategoryGridItem(
              category: category,
              onSelectCategory: () {
                _selectCategory(context, category);
              },
            )
        ],
      ),
      // SlideTransition is a widget that animates the position of a widget
      // based on the value of the position property
      builder: (context, child) => SlideTransition(
        position: _animationController.drive(
          // Tween is a widget that animates the value of a property
          // from a start value to an end value
          // Tween class and these objects are all about animating or describing
          // the transition between two values.
          Tween(
            begin: const Offset(0, 1),
            end: const Offset(0, 0),
          ).chain(
            CurveTween(
              curve: Curves.easeInOut,
            ),
          ),
        ),
        child: child,
      ),
    );
  }
}
