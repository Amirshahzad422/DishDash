import 'package:flutter/material.dart';

class CategoryCart extends StatelessWidget {
    final String name;
    final String image;
    final VoidCallback onTap;
    const CategoryCart({super.key, required this.name, required this.image, required this.onTap});
    
    Icon _getIcon() {
        switch (name) {
            case 'Pizza':
                return Icon(Icons.local_pizza, size: 28);
            case 'Burger':
                return Icon(Icons.lunch_dining, size: 28);
            case 'Salads':
                return Icon(Icons.eco, size: 28);
            case 'Drinks':
                return Icon(Icons.local_drink, size: 28);
            case 'Desserts':
                return Icon(Icons.icecream, size: 28);
            case 'Soups':
                return Icon(Icons.soup_kitchen, size: 28);
            case 'Extras':
                return Icon(Icons.extension_outlined, size: 28);
            default:
                return Icon(Icons.fastfood, size: 28);
        }
    }
    @override
    Widget build(BuildContext context){
        return InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(10),
            child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.1),
                            spreadRadius: 1,
                            blurRadius: 1,
                        )
                    ]
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                        _getIcon(),
                        const SizedBox(height: 8),
                        Text(name),
                    ],
                ),
            )
        );
    }
}
