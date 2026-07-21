import 'package:flutter/material.dart';
import '../routes/app_router.dart';

void main() {
  runApp(const DishDashApp());
}

class DishDashApp extends StatelessWidget {
  const DishDashApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'DishDash',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppRouter.homeRoute,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}