import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/mock_categories.dart';
import '../../providers/filter_provider.dart';
import '../../styles/app_colors.dart';

class FilterPanel extends StatelessWidget {
  const FilterPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<FilterProvider>(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.tune, color: AppColors.primary),
                    SizedBox(width: 8),
                    Text(
                      'Filter Menu',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: filterProvider.resetFilters,
                  child: const Text('Reset All', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const Divider(height: 24),

            // Categories
            const Text('Categories', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: mockCategories.map((cat) {
                bool isSelected = filterProvider.selectedCategory == cat.name;
                return ChoiceChip(
                  showCheckmark: false,
                  label: Text(cat.name),
                  selected: isSelected,
                  selectedColor: AppColors.primary,
                  backgroundColor: AppColors.surfaceSubtle,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : AppColors.textPrimary,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                  onSelected: (selected) {
                    if (selected) {
                      filterProvider.setSelectedCategory(cat.name);
                    }
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // Price Range
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Price Range', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                Text(
                  '\$${filterProvider.minPrice.toInt()} - \$${filterProvider.maxPrice.toInt()}',
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.primary),
                ),
              ],
            ),
            RangeSlider(
              values: RangeValues(filterProvider.minPrice, filterProvider.maxPrice),
              min: 0,
              max: 30,
              divisions: 30,
              activeColor: AppColors.primary,
              inactiveColor: AppColors.border,
              labels: RangeLabels(
                '\$${filterProvider.minPrice.toInt()}',
                '\$${filterProvider.maxPrice.toInt()}',
              ),
              onChanged: (values) {
                filterProvider.setPriceRange(values.start, values.end);
              },
            ),
            const SizedBox(height: 16),

            // Minimum Rating
            const Text('Minimum Rating', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [0.0, 4.0, 4.5, 4.8].map((rating) {
                bool isSelected = filterProvider.minRating == rating;
                return ChoiceChip(
                  showCheckmark: false,
                  avatar: rating > 0 ? const Icon(Icons.star, size: 16, color: AppColors.starYellow) : null,
                  label: Text(rating == 0.0 ? 'Any' : '$rating+'),
                  selected: isSelected,
                  selectedColor: AppColors.secondary,
                  backgroundColor: AppColors.surfaceSubtle,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : AppColors.textPrimary,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                  onSelected: (selected) {
                    if (selected) filterProvider.setMinRating(rating);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // Dietary Preferences
            const Text('Dietary Preferences', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
            CheckboxListTile(
              title: const Text('Vegetarian Only', style: TextStyle(fontSize: 14)),
              secondary: const Icon(Icons.eco, color: AppColors.success),
              value: filterProvider.isVegOnly,
              activeColor: AppColors.primary,
              contentPadding: EdgeInsets.zero,
              onChanged: (val) => filterProvider.setVegOnly(val ?? false),
            ),
            CheckboxListTile(
              title: const Text('Spicy Dishes Only', style: TextStyle(fontSize: 14)),
              secondary: const Icon(Icons.local_fire_department, color: AppColors.error),
              value: filterProvider.isSpicyOnly,
              activeColor: AppColors.primary,
              contentPadding: EdgeInsets.zero,
              onChanged: (val) => filterProvider.setSpicyOnly(val ?? false),
            ),
            const SizedBox(height: 16),

            // Sort Option
            const Text('Sort By', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<SortOption>(
                  value: filterProvider.sortOption,
                  isExpanded: true,
                  items: SortOption.values.map((opt) {
                    return DropdownMenuItem(
                      value: opt,
                      child: Text(opt.label),
                    );
                  }).toList(),
                  onChanged: (opt) {
                    if (opt != null) filterProvider.setSortOption(opt);
                  },
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Apply Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('APPLY FILTERS', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
