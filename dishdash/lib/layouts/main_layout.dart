import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/app_bar/custom_app_bar.dart';
import '../components/bottom_nav/bottom_nav_bar.dart';
import '../routes/app_router.dart';
import '../styles/app_colors.dart';
import '../utils/responsive.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  final int currentIndex;

  const MainLayout({
    super.key,
    required this.child,
    this.currentIndex = 0,
  });

  static const _routes = [
    AppRouter.homeRoute,
    AppRouter.menuRoute,
    AppRouter.cartRoute,
    AppRouter.ordersRoute,
    AppRouter.profileRoute,
  ];

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    bool isTablet = Responsive.isTablet(context);

    return Scaffold(
      appBar: const CustomAppBar(),
      // Sidebar drawer on medium/tablet screens ONLY
      drawer: isTablet ? _buildDrawer(context) : null,
      body: SizedBox.expand(
        child: child,
      ),
      // Bottom navigation bar on mobile screens ONLY
      bottomNavigationBar: isMobile
          ? CustomBottomNavBar(
              currentIndex: currentIndex,
              onTap: (index) {
                if (index < _routes.length) {
                  Navigator.pushNamed(context, _routes[index]);
                }
              },
            )
          : null,
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: AppColors.secondary,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const Icon(Icons.restaurant, color: AppColors.primary, size: 28),
                    const SizedBox(width: 10),
                    Text(
                      'DishDash',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  'Branded Restaurant App',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
          _drawerItem(context, Icons.home, 'Home', AppRouter.homeRoute),
          _drawerItem(context, Icons.restaurant_menu, 'Menu', AppRouter.menuRoute),
          _drawerItem(context, Icons.shopping_bag, 'Shopping Cart', AppRouter.cartRoute),
          _drawerItem(context, Icons.receipt_long, 'My Orders', AppRouter.ordersRoute),
          _drawerItem(context, Icons.person, 'Profile', AppRouter.profileRoute),
          const Divider(),
          _drawerItem(context, Icons.info_outline, 'About Us', AppRouter.aboutRoute),
          _drawerItem(context, Icons.contact_support_outlined, 'Contact & FAQ', AppRouter.contactRoute),
        ],
      ),
    );
  }

  Widget _drawerItem(BuildContext context, IconData icon, String title, String route) {
    return ListTile(
      leading: Icon(icon, color: AppColors.secondary),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, route);
      },
    );
  }
}
