import 'package:flutter/material.dart';
import '../../data/mock_categories.dart';
import '../../components/category_card/category_card.dart';

class HomeScreen extends StatelessWidget {
    const HomeScreen({super.key});

    @override
    Widget build(BuildContext context){
        return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    const Text(
                        'Categories',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                        ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                        children: [
                            for (var category in mockCategories)
                            Expanded(
                                child: CategoryCart(
                                    name: category.name,
                                    image: category.iconAssetPath,
                                    onTap: () {
                                        // Navigator.pushNamed(context, AppRouter.menuRoute, arguments: category.name);
                                    },
                                ),
                            )
                        ]
                    )
                ],
            ),
        );
    }
}