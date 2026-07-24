import 'package:flutter/material.dart';
import '../../components/footer/custom_footer.dart';
import '../../styles/app_colors.dart';
import '../../utils/responsive.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Hero Banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            color: AppColors.secondary,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.restaurant, size: 36, color: Colors.white),
                ),
                const SizedBox(height: 16),
                const Text(
                  'About DishDash',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Redefining digital dining for modern food lovers.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70, fontSize: 15),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Our Story
                const Text('Our Mission & Vision', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                const SizedBox(height: 10),
                const Text(
                  'Founded with a simple vision—to eliminate cold food, slow orders, and error-prone phone calls—DishDash empowers restaurants to serve high-quality, handcrafted food directly to your doorstep with total speed and transparency.',
                  style: TextStyle(fontSize: 14, color: AppColors.textSecondary, height: 1.6),
                ),
                const SizedBox(height: 24),

                // Key Metrics Stats
                Row(
                  children: [
                    _metricCard('15k+', 'Happy Diners'),
                    const SizedBox(width: 12),
                    _metricCard('50+', 'Master Chefs'),
                    const SizedBox(width: 12),
                    _metricCard('18 Min', 'Avg Delivery'),
                  ],
                ),
                const SizedBox(height: 32),

                // Master Chefs Section
                const Text('Meet Our Master Culinary Team', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                const SizedBox(height: 16),
                LayoutBuilder(
                  builder: (context, constraints) {
                    bool isMobile = Responsive.isMobile(context);
                    if (isMobile) {
                      return Column(
                        children: [
                          _chefCard('Chef Marco Rossi', 'Head Italian Pizzaiolo', '15+ years crafting artisanal sourdough pizzas in Naples.'),
                          const SizedBox(height: 12),
                          _chefCard('Chef Akira Tanaka', 'Executive Burger Artist', 'Pioneer of flame-grilled smash burgers and umami glazes.'),
                          const SizedBox(height: 12),
                          _chefCard('Chef Elena Gomez', 'Pastry & Beverage Director', 'Master mixologist behind our fresh botanical drinks.'),
                        ],
                      );
                    }
                    return Row(
                      children: [
                        Expanded(child: _chefCard('Chef Marco Rossi', 'Head Italian Pizzaiolo', '15+ years crafting artisanal sourdough pizzas in Naples.')),
                        const SizedBox(width: 12),
                        Expanded(child: _chefCard('Chef Akira Tanaka', 'Executive Burger Artist', 'Pioneer of flame-grilled smash burgers.')),
                        const SizedBox(width: 12),
                        Expanded(child: _chefCard('Chef Elena Gomez', 'Beverage Director', 'Master mixologist behind botanical drinks.')),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 32),

                // Hygiene & Quality
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceSubtle,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.border, width: 0.5),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.verified_user, color: AppColors.success, size: 40),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('100% Certified Safety & Hygiene', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            SizedBox(height: 4),
                            Text('Every meal is prepared in grade-A kitchens with contactless thermal packaging.', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const CustomFooter(),
        ],
      ),
    );
  }

  Widget _metricCard(String val, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border, width: 0.5),
          boxShadow: const [AppColors.cardShadow],
        ),
        child: Column(
          children: [
            Text(val, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 20, color: AppColors.primary)),
            const SizedBox(height: 4),
            Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
          ],
        ),
      ),
    );
  }

  Widget _chefCard(String name, String role, String bio) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: AppColors.primaryLight,
                child: Icon(Icons.person, color: AppColors.primary),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    Text(role, style: const TextStyle(color: AppColors.primary, fontSize: 11, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(bio, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, height: 1.4)),
        ],
      ),
    );
  }
}