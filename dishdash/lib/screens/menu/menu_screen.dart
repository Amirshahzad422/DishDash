import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/filters/filter_panel.dart';
import '../../components/food_card/food_card.dart';
import '../../components/footer/custom_footer.dart';
import '../../components/loader/skeleton_loader.dart';
import '../../components/search_bar/search_bar.dart';
import '../../data/mock_categories.dart';
import '../../providers/filter_provider.dart';
import '../../styles/app_colors.dart';
import '../../utils/responsive.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  bool _isLoading = false;

  void _triggerSimulatedLoading() {
    setState(() => _isLoading = true);
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) setState(() => _isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<FilterProvider>(context);
    final filteredItems = filterProvider.filteredItems;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header & Search
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          filterProvider.selectedCategory,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          'Showing ${filteredItems.length} items',
                          style: const TextStyle(fontSize: 13, color: AppColors.textLight),
                        ),
                      ],
                    ),

                    // Grid / List Toggle
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.grid_view,
                            color: filterProvider.isGridView ? AppColors.primary : AppColors.textLight,
                          ),
                          onPressed: () {
                            if (!filterProvider.isGridView) {
                              filterProvider.toggleViewMode();
                            }
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.view_list,
                            color: !filterProvider.isGridView ? AppColors.primary : AppColors.textLight,
                          ),
                          onPressed: () {
                            if (filterProvider.isGridView) {
                              filterProvider.toggleViewMode();
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                CustomSearchBar(
                  initialValue: filterProvider.searchQuery,
                  onChanged: (val) {
                    filterProvider.setSearchQuery(val);
                    _triggerSimulatedLoading();
                  },
                  onFilterPressed: () => _openFilterModal(context),
                ),

                // Active Category Filter Bar
                const SizedBox(height: 16),
                SizedBox(
                  height: 38,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: mockCategories.length,
                    itemBuilder: (context, index) {
                      final cat = mockCategories[index];
                      bool isSelected = filterProvider.selectedCategory == cat.name;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          showCheckmark: false,
                          avatar: Icon(
                            cat.icon,
                            size: 16,
                            color: isSelected ? Colors.white : AppColors.secondary,
                          ),
                          label: Text(cat.name),
                          selected: isSelected,
                          selectedColor: AppColors.primary,
                          backgroundColor: AppColors.surfaceSubtle,
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.white : AppColors.textPrimary,
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                          onSelected: (selected) {
                            filterProvider.setSelectedCategory(cat.name);
                            _triggerSimulatedLoading();
                          },
                        ),
                      );
                    },
                  ),
                ),

                // Applied Active Filters Chips
                if (filterProvider.hasActiveFilters) ...[
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Text('Filters: ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textLight)),
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              if (filterProvider.searchQuery.isNotEmpty)
                                _activeChip('Query: "${filterProvider.searchQuery}"', () => filterProvider.setSearchQuery('')),
                              if (filterProvider.isVegOnly)
                                _activeChip('Veg Only', () => filterProvider.setVegOnly(false)),
                              if (filterProvider.isSpicyOnly)
                                _activeChip('Spicy Only', () => filterProvider.setSpicyOnly(false)),
                              if (filterProvider.minRating > 0)
                                _activeChip('Rating ${filterProvider.minRating}+', () => filterProvider.setMinRating(0.0)),
                              Chip(
                                label: const Text('Reset All', style: TextStyle(fontSize: 11, color: AppColors.primary)),
                                deleteIcon: const Icon(Icons.refresh, size: 14, color: AppColors.primary),
                                onDeleted: filterProvider.resetFilters,
                                backgroundColor: AppColors.primaryLight,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Main Menu Items Listing
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _isLoading
                ? _buildSkeletonGrid(context, filterProvider.isGridView)
                : filteredItems.isEmpty
                    ? _buildEmptyState(context, filterProvider)
                    : filterProvider.isGridView
                        ? GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: Responsive.getGridCrossAxisCount(context),
                              childAspectRatio: Responsive.getGridAspectRatio(context),
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                            ),
                            itemCount: filteredItems.length,
                            itemBuilder: (context, index) {
                              return FoodCard(item: filteredItems[index]);
                            },
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: filteredItems.length,
                            itemBuilder: (context, index) {
                              return FoodCard(item: filteredItems[index], isListView: true);
                            },
                          ),
          ),
          const SizedBox(height: 40),

          // Footer
          const CustomFooter(),
        ],
      ),
    );
  }

  Widget _activeChip(String label, VoidCallback onRemove) {
    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: Chip(
        label: Text(label, style: const TextStyle(fontSize: 11, color: Colors.white)),
        deleteIcon: const Icon(Icons.close, size: 14, color: Colors.white),
        onDeleted: onRemove,
        backgroundColor: AppColors.secondary,
      ),
    );
  }

  Widget _buildSkeletonGrid(BuildContext context, bool isGrid) {
    if (!isGrid) {
      return Column(
        children: List.generate(4, (_) => const Padding(
          padding: EdgeInsets.only(bottom: 12),
          child: SkeletonLoader(width: double.infinity, height: 100),
        )),
      );
    }
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: Responsive.getGridCrossAxisCount(context),
        childAspectRatio: Responsive.getGridAspectRatio(context),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: 6,
      itemBuilder: (context, index) => const FoodCardSkeleton(),
    );
  }

  Widget _buildEmptyState(BuildContext context, FilterProvider filterProvider) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: AppColors.primaryLight,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.search_off, size: 56, color: AppColors.primary),
          ),
          const SizedBox(height: 16),
          const Text(
            'No Dishes Found',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'We couldn\'t find any menu items matching your search or filters. Try adjusting your preferences.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: filterProvider.resetFilters,
            icon: const Icon(Icons.refresh),
            label: const Text('Reset All Filters'),
          ),
        ],
      ),
    );
  }

  void _openFilterModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const FilterPanel(),
    );
  }
}