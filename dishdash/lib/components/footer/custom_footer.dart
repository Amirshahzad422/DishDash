import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../routes/app_router.dart';
import '../../styles/app_colors.dart';
import '../../utils/responsive.dart';

class CustomFooter extends StatelessWidget {
  const CustomFooter({super.key});

  @override
  Widget build(BuildContext context) {
    // Apps do not have footers on mobile screens
    if (Responsive.isMobile(context)) {
      return const SizedBox.shrink();
    }

    return Container(
      color: AppColors.secondary,
      padding: const EdgeInsets.symmetric(
        horizontal: 64,
        vertical: 40,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 3, child: _brandColumn(context)),
              const SizedBox(width: 32),
              Expanded(flex: 2, child: _quickLinksColumn(context)),
              const SizedBox(width: 32),
              Expanded(flex: 3, child: _contactColumn()),
            ],
          ),
          const Divider(color: Colors.white24, height: 40),
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            runSpacing: 12,
            children: [
              const Text(
                '© 2026 DishDash Inc. All rights reserved.',
                style: TextStyle(color: Colors.white60, fontSize: 12),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _socialIcon(Icons.camera_alt),
                  _socialIcon(Icons.facebook),
                  _socialIcon(Icons.alternate_email),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _brandColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.restaurant, color: AppColors.primary, size: 26),
            const SizedBox(width: 8),
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
          'Premium restaurant ordering app designed for fast, effortless dining experiences. Fresh food delivered hot to your doorstep.',
          style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.5),
        ),
      ],
    );
  }

  Widget _quickLinksColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'QUICK LINKS',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 12),
        _footerLink(context, 'Home', AppRouter.homeRoute),
        _footerLink(context, 'Full Menu', AppRouter.menuRoute),
        _footerLink(context, 'My Orders', AppRouter.ordersRoute),
        _footerLink(context, 'About Us', AppRouter.aboutRoute),
        _footerLink(context, 'Contact & FAQ', AppRouter.contactRoute),
      ],
    );
  }

  Widget _footerLink(BuildContext context, String text, String route) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, route),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white70, fontSize: 13),
        ),
      ),
    );
  }

  Widget _contactColumn() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CONTACT & HOURS',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
            letterSpacing: 1,
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Icon(Icons.location_on, color: AppColors.primary, size: 16),
            SizedBox(width: 8),
            Expanded(child: Text('123 Gourmet Ave, Food City', style: TextStyle(color: Colors.white70, fontSize: 13))),
          ],
        ),
        SizedBox(height: 6),
        Row(
          children: [
            Icon(Icons.phone, color: AppColors.primary, size: 16),
            SizedBox(width: 8),
            Expanded(child: Text('+1 (800) 555-DISH', style: TextStyle(color: Colors.white70, fontSize: 13))),
          ],
        ),
        SizedBox(height: 6),
        Row(
          children: [
            Icon(Icons.access_time, color: AppColors.primary, size: 16),
            SizedBox(width: 8),
            Expanded(child: Text('Mon - Sun: 10:00 AM - 11:00 PM', style: TextStyle(color: Colors.white70, fontSize: 13))),
          ],
        ),
      ],
    );
  }

  Widget _socialIcon(IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: IconButton(
        icon: Icon(icon, color: Colors.white70, size: 18),
        onPressed: () {},
      ),
    );
  }
}
