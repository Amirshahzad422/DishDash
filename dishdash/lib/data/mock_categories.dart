import 'package:flutter/material.dart';
import '../models/category.dart';

final List<Category> mockCategories = [
  const Category(id: 'cat_all', name: 'All Items', icon: Icons.restaurant_menu, itemCount: 12),
  const Category(id: 'cat_pizza', name: 'Pizza', icon: Icons.local_pizza, itemCount: 3),
  const Category(id: 'cat_burgers', name: 'Burgers', icon: Icons.lunch_dining, itemCount: 3),
  const Category(id: 'cat_salads', name: 'Salads', icon: Icons.ramen_dining, itemCount: 3),
  const Category(id: 'cat_drinks', name: 'Drinks', icon: Icons.local_bar, itemCount: 3),
];