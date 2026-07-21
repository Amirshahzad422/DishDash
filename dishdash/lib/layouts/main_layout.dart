import 'package:flutter/material.dart';
import '../components/app_bar/custom_app_bar.dart';
import '../components/bottom_nav/bottom_nav_bar.dart';
import '../routes/app_router.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  final int currentIndex;
  const MainLayout({super.key, required this.child, this.currentIndex = 0});

  static const _routes = [
    AppRouter.homeRoute,
    AppRouter.menuRoute,
    AppRouter.ordersRoute,
    AppRouter.profileRoute,
  ];
    @override
    Widget build(BuildContext context){
        return Scaffold(
            appBar: CustomAppBar(),
            body: child,
            bottomNavigationBar: CustomBottomNavBar(
                currentIndex: currentIndex,
                onTap: (index) {
                    Navigator.pushNamed(context, _routes[index]);
                },
            ),
        );
    }
}
