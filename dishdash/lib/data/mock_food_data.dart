import '../models/food_item.dart';

final List<FoodItem> mockFoodItems = [
  // Pizzas
  FoodItem(
    id: 'f1',
    name: 'DishDash Special Pizza',
    category: 'Pizza',
    price: 14.99,
    rating: 4.5,
    description: 'Our signature pizza with premium toppings, olives, and extra mozzarella cheese.',
    imageUrl: 'assets/images/pizza_1.jpg',
  ),
  FoodItem(
    id: 'f2',
    name: 'Spicy Pepperoni',
    category: 'Pizza',
    price: 12.99,
    rating: 4.8,
    description: 'Classic pepperoni with a spicy kick and garlic herb crust.',
    imageUrl: 'assets/images/pizza_2.jpg',
  ),
  FoodItem(
    id: 'f3',
    name: 'Margherita Classic',
    category: 'Pizza',
    price: 10.99,
    rating: 4.2,
    description: 'Simple and delicious with fresh tomatoes, basil, and cheese.',
    imageUrl: 'assets/images/pizza_3.jpg',
  ),

  // Burgers
  FoodItem(
    id: 'f4',
    name: 'Classic Beef Burger',
    category: 'Burgers',
    price: 8.99,
    rating: 4.6,
    description: 'Juicy beef patty with lettuce, tomato, and our secret sauce.',
    imageUrl: 'assets/images/burger_1.jpg',
  ),
  FoodItem(
    id: 'f5',
    name: 'Double Cheese Smash',
    category: 'Burgers',
    price: 11.99,
    rating: 4.9,
    description: 'Two smashed patties loaded with cheddar and caramelized onions.',
    imageUrl: 'assets/images/burger_2.jpg',
  ),
  FoodItem(
    id: 'f6',
    name: 'Crispy Chicken Zinger',
    category: 'Burgers',
    price: 9.49,
    rating: 4.4,
    description: 'Deep-fried crispy chicken breast with spicy mayo.',
    imageUrl: 'assets/images/burger_3.jpg',
  ),

  // Salads
  FoodItem(
    id: 'f7',
    name: 'DishDash Salads',
    category: 'Salads',
    price: 14.99,
    rating: 4.5,
    description: 'Fresh organic greens, cherry tomatoes, and feta cheese with balsamic glaze.',
    imageUrl: 'assets/images/salad_1.jpg',
  ),
  FoodItem(
    id: 'f8',
    name: 'Caesar Salad',
    category: 'Salads',
    price: 7.99,
    rating: 4.3,
    description: 'Crisp romaine lettuce, garlic croutons, parmesan, and Caesar dressing.',
    imageUrl: 'assets/images/salad_2.jpg',
  ),
  FoodItem(
    id: 'f9',
    name: 'Grilled Chicken Salad',
    category: 'Salads',
    price: 10.49,
    rating: 4.7,
    description: 'Healthy mix of greens topped with warm, grilled chicken strips.',
    imageUrl: 'assets/images/salad_3.jpg',
  ),

  // Drinks
  FoodItem(
    id: 'f10',
    name: 'Fresh Lemonade',
    category: 'Drinks',
    price: 3.99,
    rating: 4.1,
    description: 'Chilled, freshly squeezed lemonade with a hint of mint.',
    imageUrl: 'assets/images/drink_1.jpg',
  ),
  FoodItem(
    id: 'f11',
    name: 'Iced Caramel Macchiato',
    category: 'Drinks',
    price: 5.49,
    rating: 4.8,
    description: 'Cold brew coffee with milk and a rich caramel drizzle.',
    imageUrl: 'assets/images/drink_2.jpg',
  ),
  FoodItem(
    id: 'f12',
    name: 'Strawberry Smoothie',
    category: 'Drinks',
    price: 6.99,
    rating: 4.6,
    description: 'Thick and creamy blend of fresh strawberries and yogurt.',
    imageUrl: 'assets/images/drink_3.jpg',
  ),
];