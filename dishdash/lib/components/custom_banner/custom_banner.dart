import 'package:flutter/material.dart';
import '../../components/search_bar/search_bar.dart';

class CustomBanner extends StatelessWidget {
  final String imageUrl;
  final ValueChanged<String>? onSearchChanged;

  const CustomBanner({
    super.key,
    this.imageUrl = 'assets/images/banner_food.jpg',
    this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
        widthFactor: 0.9,
        child: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            image: DecorationImage(
              image: AssetImage(imageUrl),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withValues(alpha: 0.7),
                BlendMode.darken,
              ),
            ),
          ),
          child: Column(
            children: [
              const Text(
                'Order the Best',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Text(
                'Food',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Pacifico',
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Craving something delicious? We deliver it fast.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: const Color(0xFFD8B8A2),
                ),
              ),
              const SizedBox(height: 20),
              CustomSearchBar(
                hintText: 'Search for restaurants or dishes...',
                onChanged: onSearchChanged,
              )
            ],
          ),
        )
    );
  }
}