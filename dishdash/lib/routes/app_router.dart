import 'package:flutter/material.dart';
import '../screens/splash/splash_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/about/about_screen.dart';
import '../screens/cart/cart_screen.dart';
import '../screens/checkout/checkout_screen.dart';
import '../screens/contact/contact_screen.dart';
import '../screens/food_details/food_detail_screen.dart';
import '../screens/menu/menu_screen.dart';
import '../screens/not_found/not_found_screen.dart';
import '../screens/orders/order_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../layouts/main_layout.dart';
import '../models/food_item.dart';

class AppRouter {
  static const String splashRoute = '/splash';
  static const String homeRoute = '/';
  static const String aboutRoute = '/about';
  static const String cartRoute = '/cart';
  static const String checkoutRoute = '/checkout';
  static const String contactRoute = '/contact';
  static const String foodDetailRoute = '/food-detail';
  static const String menuRoute = '/menu';
  static const String notFoundRoute = '/not-found';
  static const String ordersRoute = '/order';
  static const String profileRoute = '/profile';

  static Route<dynamic> _layoutRoute({
    required Widget child,
    int currentIndex = 0,
    required RouteSettings settings,
  }) {
    return MaterialPageRoute(
      builder: (context) => MainLayout(
        currentIndex: currentIndex,
        child: child,
      ),
      settings: settings,
    );
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen(), settings: settings);
      case homeRoute:
        return _layoutRoute(currentIndex: 0, child: const HomeScreen(), settings: settings);
      case aboutRoute:
        return _layoutRoute(currentIndex: 0, child: const AboutScreen(), settings: settings);
      case cartRoute:
        return _layoutRoute(currentIndex: 2, child: const CartScreen(), settings: settings);
      case checkoutRoute:
        return MaterialPageRoute(builder: (_) => const CheckoutScreen(), settings: settings);
      case contactRoute:
        return _layoutRoute(currentIndex: 0, child: const ContactScreen(), settings: settings);
      case foodDetailRoute:
        final args = settings.arguments;
        if (args is! FoodItem) {
          return _layoutRoute(currentIndex: 0, child: const HomeScreen(), settings: settings);
        }
        return MaterialPageRoute(
          builder: (_) => FoodDetailScreen(item: args),
          settings: settings,
        );
      case menuRoute:
        return _layoutRoute(currentIndex: 1, child: const MenuScreen(), settings: settings);
      case ordersRoute:
        final initialTab = settings.arguments is int ? (settings.arguments as int) : 0;
        return _layoutRoute(
          currentIndex: 3,
          child: OrderScreen(initialTabIndex: initialTab),
          settings: settings,
        );
      case profileRoute:
        return _layoutRoute(currentIndex: 4, child: const ProfileScreen(), settings: settings);
      default:
        return MaterialPageRoute(builder: (_) => const NotFoundScreen(), settings: settings);
    }
  }
}