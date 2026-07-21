import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
    final int currentIndex;
    final ValueChanged<int> onTap;
    const CustomBottomNavBar({super.key, required this.currentIndex, required this.onTap});
    @override
    Widget build(BuildContext context){
        return BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: onTap,
            type: BottomNavigationBarType.fixed,
            items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.restaurant_menu), label: 'Menu'),
                BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
                BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            ],

        );
    }
}