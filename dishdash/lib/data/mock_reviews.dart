import '../models/review.dart';

final List<Review> mockReviews = [
  const Review(
    id: 'r1',
    userName: 'Sarah Jenkins',
    userAvatar: 'SJ',
    rating: 5.0,
    comment: 'The DishDash Special Pizza is out of this world! The crust is so light and crispy, and the ingredients are super fresh. Delivered in 20 minutes!',
    date: '2 days ago',
  ),
  const Review(
    id: 'r2',
    userName: 'Michael Chen',
    userAvatar: 'MC',
    rating: 4.8,
    comment: 'Best smash burger in town! The caramelized onions and double cheese combination is perfect. Will definitely order again.',
    date: '1 week ago',
  ),
  const Review(
    id: 'r3',
    userName: 'Emily Rodriguez',
    userAvatar: 'ER',
    rating: 4.9,
    comment: 'Love the app interface—so clean and easy to customize add-ons. The live status order tracking kept me updated every step of the way!',
    date: '2 weeks ago',
  ),
  const Review(
    id: 'r4',
    userName: 'David Smith',
    userAvatar: 'DS',
    rating: 4.7,
    comment: 'Fresh ingredients, fast delivery, and fantastic customer service. The mint lemonade was super refreshing!',
    date: '3 weeks ago',
  ),
];
