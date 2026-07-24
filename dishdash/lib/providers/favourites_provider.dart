import 'package:flutter/material.dart';
import '../models/food_item.dart';
import '../data/mock_food_data.dart';

class FavouritesProvider extends ChangeNotifier {
  final Set<String> _favouriteIds = {'f1', 'f5'};

  Set<String> get favouriteIds => Set.unmodifiable(_favouriteIds);

  List<FoodItem> get favouriteItems {
    return mockFoodItems.where((item) => _favouriteIds.contains(item.id)).toList();
  }

  bool isFavourite(String foodId) {
    return _favouriteIds.contains(foodId);
  }

  void toggleFavourite(String foodId) {
    if (_favouriteIds.contains(foodId)) {
      _favouriteIds.remove(foodId);
    } else {
      _favouriteIds.add(foodId);
    }
    notifyListeners();
  }
}
