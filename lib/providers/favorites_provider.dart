// This provider will store the list of all the favorite meals.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super([]);

  bool toggleMealFavoriteStatus(Meal meal) {
    final mealIsFavorite = state.contains(meal);

    if (mealIsFavorite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

// StateNotifierProvider is a provider that provides a value that can be modified.
// It is optimized for data changes and is used when we need to modify the value.
// favoriteMealsProvider is a StateNotifierProvider that provides a list of favorite meals.
// StateNotifierProvider<FavoriteMealsNotifier, List<Meal>> is a provider that
// provides a value of type List<Meal> and uses FavoriteMealsNotifier to modify the value.
final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
  return FavoriteMealsNotifier();
});
