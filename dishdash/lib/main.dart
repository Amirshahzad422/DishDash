import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';
import 'providers/favourites_provider.dart';
import 'providers/filter_provider.dart';
import 'providers/orders_provider.dart';
import 'routes/app_router.dart';
import 'styles/app_theme.dart';

void main() {
  runApp(const DishDashApp());
}

class DishDashApp extends StatelessWidget {
  const DishDashApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => OrdersProvider()),
        ChangeNotifierProvider(create: (_) => FavouritesProvider()),
        ChangeNotifierProvider(create: (_) => FilterProvider()),
      ],
      child: MaterialApp(
        title: 'DishDash Restaurant Ordering App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        scrollBehavior: const ScrollBehavior().copyWith(scrollbars: false),
        initialRoute: AppRouter.homeRoute,
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}