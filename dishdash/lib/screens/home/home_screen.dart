import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/category_card/category_card.dart';
import '../../components/custom_banner/custom_banner.dart';
import '../../components/food_card/food_card.dart';
import '../../components/footer/custom_footer.dart';
import '../../components/search_bar/search_bar.dart';
import '../../components/testimonials/testimonial_card.dart';
import '../../data/mock_categories.dart';
import '../../data/mock_food_data.dart';
import '../../data/mock_reviews.dart';
import '../../providers/filter_provider.dart';
import '../../routes/app_router.dart';
import '../../styles/app_colors.dart';
import '../../utils/responsive.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<FilterProvider>(context);
    final featuredItems = mockFoodItems.where((i) => i.isFeatured).toList();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Banner & Search Section
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const CustomBanner(),
                const SizedBox(height: 20),
                CustomSearchBar(
                  initialValue: filterProvider.searchQuery,
                  onChanged: (val) {
                    filterProvider.setSearchQuery(val);
                    if (val.isNotEmpty) {
                      Navigator.pushNamed(context, AppRouter.menuRoute);
                    }
                  },
                ),
              ],
            ),
          ),

          // Categories Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Explore Categories',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRouter.menuRoute);
                      },
                      child: const Text('View All', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 88,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: mockCategories.length,
                    itemBuilder: (context, index) {
                      final cat = mockCategories[index];
                      return CategoryCard(
                        category: cat,
                        isSelected: filterProvider.selectedCategory == cat.name,
                        onTap: () {
                          filterProvider.setSelectedCategory(cat.name);
                          Navigator.pushNamed(context, AppRouter.menuRoute);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),

          // Featured Items Grid
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: const [
                          Icon(Icons.local_fire_department, color: AppColors.primary),
                          SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              'Chef\'s Specials',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, AppRouter.menuRoute),
                      child: const Text('Full Menu →', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: Responsive.getGridCrossAxisCount(context),
                    childAspectRatio: Responsive.getGridAspectRatio(context),
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: featuredItems.length,
                  itemBuilder: (context, index) {
                    return FoodCard(item: featuredItems[index]);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 36),

          // Why Choose Us Section
          Container(
            width: double.infinity,
            color: AppColors.surfaceSubtle,
            padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 20),
            child: Column(
              children: [
                const Text(
                  'WHY CHOOSE DISHDASH',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Freshness & Speed Delivered',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 24),
                LayoutBuilder(
                  builder: (context, constraints) {
                    bool isMobile = Responsive.isMobile(context);
                    if (isMobile) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _featureItem(Icons.flash_on, 'Ultra-Fast Delivery', 'Delivered to your door in under 30 minutes.'),
                          const SizedBox(height: 12),
                          _featureItem(Icons.restaurant, 'Master Chefs', 'Handcrafted meals by top industry culinary chefs.'),
                          const SizedBox(height: 12),
                          _featureItem(Icons.verified, '100% Fresh Ingredients', 'Sourced daily from certified local farms.'),
                          const SizedBox(height: 12),
                          _featureItem(Icons.route, 'Live Order Tracking', 'Follow your delivery on map in real time.'),
                        ],
                      );
                    }
                    return IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(child: _featureItem(Icons.flash_on, 'Ultra-Fast Delivery', 'Delivered in under 30 mins.')),
                          const SizedBox(width: 12),
                          Expanded(child: _featureItem(Icons.restaurant, 'Master Chefs', 'Handcrafted by top chefs.')),
                          const SizedBox(width: 12),
                          Expanded(child: _featureItem(Icons.verified, '100% Fresh', 'Sourced daily from local farms.')),
                          const SizedBox(width: 12),
                          Expanded(child: _featureItem(Icons.route, 'Live Tracking', 'Follow your delivery on map.')),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 36),

          // Testimonials Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Customer Love',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 160,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: mockReviews.length,
                    itemBuilder: (context, index) {
                      return TestimonialCard(review: mockReviews[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),

          // Footer
          const CustomFooter(),
        ],
      ),
    );
  }

  Widget _featureItem(IconData icon, String title, String desc) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 0.5),
        boxShadow: const [AppColors.cardShadow],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: AppColors.primaryLight,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.primary, size: 28),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 6),
          Text(
            desc,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}