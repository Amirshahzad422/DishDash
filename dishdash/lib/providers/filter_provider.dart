import 'package:flutter/material.dart';
import '../models/food_item.dart';
import '../data/mock_food_data.dart';

enum SortOption {
  popular,
  newest,
  priceLowToHigh,
  priceHighToLow,
}

extension SortOptionExtension on SortOption {
  String get label {
    switch (this) {
      case SortOption.popular:
        return 'Most Popular';
      case SortOption.newest:
        return 'Newest First';
      case SortOption.priceLowToHigh:
        return 'Price: Low to High';
      case SortOption.priceHighToLow:
        return 'Price: High to Low';
    }
  }
}

class FilterProvider extends ChangeNotifier {
  String _searchQuery = '';
  String _selectedCategory = 'All Items';
  double _minPrice = 0.0;
  double _maxPrice = 30.0;
  double _minRating = 0.0;
  bool _isVegOnly = false;
  bool _isSpicyOnly = false;
  SortOption _sortOption = SortOption.popular;
  bool _isGridView = true;

  String get searchQuery => _searchQuery;
  String get selectedCategory => _selectedCategory;
  double get minPrice => _minPrice;
  double get maxPrice => _maxPrice;
  double get minRating => _minRating;
  bool get isVegOnly => _isVegOnly;
  bool get isSpicyOnly => _isSpicyOnly;
  SortOption get sortOption => _sortOption;
  bool get isGridView => _isGridView;

  bool get hasActiveFilters =>
      _searchQuery.isNotEmpty ||
      _selectedCategory != 'All Items' ||
      _minPrice > 0.0 ||
      _maxPrice < 30.0 ||
      _minRating > 0.0 ||
      _isVegOnly ||
      _isSpicyOnly ||
      _sortOption != SortOption.popular;

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setSelectedCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void setPriceRange(double min, double max) {
    _minPrice = min;
    _maxPrice = max;
    notifyListeners();
  }

  void setMinRating(double rating) {
    _minRating = rating;
    notifyListeners();
  }

  void setVegOnly(bool val) {
    _isVegOnly = val;
    notifyListeners();
  }

  void setSpicyOnly(bool val) {
    _isSpicyOnly = val;
    notifyListeners();
  }

  void setSortOption(SortOption option) {
    _sortOption = option;
    notifyListeners();
  }

  void toggleViewMode() {
    _isGridView = !_isGridView;
    notifyListeners();
  }

  void resetFilters() {
    _searchQuery = '';
    _selectedCategory = 'All Items';
    _minPrice = 0.0;
    _maxPrice = 30.0;
    _minRating = 0.0;
    _isVegOnly = false;
    _isSpicyOnly = false;
    _sortOption = SortOption.popular;
    notifyListeners();
  }

  List<FoodItem> get filteredItems {
    List<FoodItem> items = mockFoodItems.where((item) {
      // Category filter
      if (_selectedCategory != 'All Items' &&
          item.category.toLowerCase() != _selectedCategory.toLowerCase()) {
        return false;
      }
      // Keyword search
      if (_searchQuery.isNotEmpty) {
        String q = _searchQuery.toLowerCase();
        bool matchesName = item.name.toLowerCase().contains(q);
        bool matchesDesc = item.description.toLowerCase().contains(q);
        bool matchesCat = item.category.toLowerCase().contains(q);
        if (!matchesName && !matchesDesc && !matchesCat) return false;
      }
      // Price range
      if (item.price < _minPrice || item.price > _maxPrice) {
        return false;
      }
      // Rating filter
      if (item.rating < _minRating) {
        return false;
      }
      // Dietary filter
      if (_isVegOnly && !item.isVeg) {
        return false;
      }
      if (_isSpicyOnly && !item.isSpicy) {
        return false;
      }
      return true;
    }).toList();

    // Sort items
    switch (_sortOption) {
      case SortOption.popular:
        items.sort((a, b) => b.reviewCount.compareTo(a.reviewCount));
        break;
      case SortOption.newest:
        items.sort((a, b) => b.id.compareTo(a.id));
        break;
      case SortOption.priceLowToHigh:
        items.sort((a, b) => a.price.compareTo(b.price));
        break;
      case SortOption.priceHighToLow:
        items.sort((a, b) => b.price.compareTo(a.price));
        break;
    }

    return items;
  }
}
