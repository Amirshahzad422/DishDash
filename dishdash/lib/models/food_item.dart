class AddOn {
  final String id;
  final String name;
  final double price;

  const AddOn({
    required this.id,
    required this.name,
    required this.price,
  });
}

class CustomizationOption {
  final String name;
  final List<String> choices;
  final String defaultChoice;

  const CustomizationOption({
    required this.name,
    required this.choices,
    required this.defaultChoice,
  });
}

class FoodItem {
  final String id;
  final String name;
  final String category;
  final double price;
  final double rating;
  final int reviewCount;
  final String description;
  final String imageUrl;
  final List<String> galleryImages;
  final bool isVeg;
  final bool isSpicy;
  final int calories;
  final String prepTime;
  final List<AddOn> addOns;
  final List<CustomizationOption> options;
  final List<String> ingredients;
  final bool isFeatured;

  FoodItem({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.rating,
    this.reviewCount = 42,
    required this.description,
    required this.imageUrl,
    List<String>? galleryImages,
    this.isVeg = false,
    this.isSpicy = false,
    this.calories = 350,
    this.prepTime = '20-25 min',
    this.addOns = const [],
    this.options = const [],
    this.ingredients = const [],
    this.isFeatured = false,
  }) : galleryImages = galleryImages ?? [imageUrl];
}