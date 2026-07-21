import 'package:flutter/material.dart';
import '../../routes/app_router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
    const CustomAppBar({super.key});
    @override
    Widget build(BuildContext context){
        return AppBar(
            backgroundColor: Colors.white,
            title: Text('Dish Dash'),
            actions: [
                IconButton(
                    tooltip: 'Cart',
                    icon: Icon(Icons.shopping_cart_outlined),
                    onPressed: () {
                        Navigator.pushNamed(context, AppRouter.cartRoute);
                    },
                )
            ]
        );
    }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}