import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/data/dummy_data.dart';

// Provider is a simple way to provide a value to the widget tree.
// mealsProvider is a Provider that provides a list of meals.
// The value provided is dummyMeals.
final mealsProvider = Provider((ref) {
  return dummyMeals;
});
