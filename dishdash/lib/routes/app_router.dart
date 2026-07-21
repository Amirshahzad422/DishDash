import 'package:flutter/material.dart';
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

class AppRouter{
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
    }) {
        return MaterialPageRoute(
            builder: (context) => MainLayout(
                currentIndex: currentIndex,
                child: child,
            ),
        );
    }

    static Route<dynamic> generateRoute(RouteSettings settings){
        switch(settings.name){
            case homeRoute:
                return _layoutRoute(currentIndex: 0, child: const HomeScreen());
            case aboutRoute:
                return _layoutRoute(child: const AboutScreen());
            case cartRoute:
                return _layoutRoute(currentIndex: 2, child: const CartScreen());
            case checkoutRoute:
                return MaterialPageRoute(builder: (_) => const CheckoutScreen());
            case contactRoute:
                return _layoutRoute(child: const ContactScreen());
            case foodDetailRoute:
                return MaterialPageRoute(builder: (_) => const FoodDetailScreen());
            case menuRoute:
                return _layoutRoute(currentIndex: 1, child: const MenuScreen());
            case ordersRoute:
                return _layoutRoute(child: const OrderScreen());
            case profileRoute:
                return _layoutRoute(currentIndex: 3, child: const ProfileScreen());
            default:
                return MaterialPageRoute(builder: (_) => const NotFoundScreen());
        }
    }
}