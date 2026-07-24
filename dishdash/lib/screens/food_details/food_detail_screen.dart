import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/food_card/food_card.dart';
import '../../components/footer/custom_footer.dart';
import '../../data/mock_food_data.dart';
import '../../data/mock_reviews.dart';
import '../../models/food_item.dart';
import '../../providers/cart_provider.dart';
import '../../providers/favourites_provider.dart';
import '../../routes/app_router.dart';
import '../../styles/app_colors.dart';
import '../../utils/formatters.dart';
import '../../utils/responsive.dart';

class FoodDetailScreen extends StatefulWidget {
  final FoodItem? item;

  const FoodDetailScreen({super.key, this.item});

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  late FoodItem _foodItem;
  late String _selectedImage;
  int _quantity = 1;
  final Set<AddOn> _selectedAddOns = {};
  final Map<String, String> _selectedOptions = {};
  final TextEditingController _notesController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final routeArgs = ModalRoute.of(context)?.settings.arguments;
    if (routeArgs is FoodItem) {
      _foodItem = routeArgs;
    } else {
      _foodItem = widget.item ?? mockFoodItems[0];
    }
    _selectedImage = _foodItem.imageUrl;

    for (var opt in _foodItem.options) {
      _selectedOptions[opt.name] = opt.defaultChoice;
    }
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  double get _calculatedUnitPrice {
    double addOnSum = _selectedAddOns.fold(0.0, (sum, a) => sum + a.price);
    return _foodItem.price + addOnSum;
  }

  double get _calculatedTotalPrice => _calculatedUnitPrice * _quantity;

  @override
  Widget build(BuildContext context) {
    final favProvider = Provider.of<FavouritesProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final isFav = favProvider.isFavourite(_foodItem.id);
    final similarItems = mockFoodItems
        .where((i) => i.category == _foodItem.category && i.id != _foodItem.id)
        .toList();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Image Gallery & Badges
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: Responsive.isDesktop(context) ? 420 : 280,
                  padding: const EdgeInsets.all(16),
                  color: AppColors.surfaceSubtle,
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        _selectedImage,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: AppColors.primaryLight,
                          child: const Icon(Icons.fastfood, size: 80, color: AppColors.primary),
                        ),
                      ),
                    ),
                  ),
                ),

                // Back Button & Favourite Toggle
                Positioned(
                  top: 16,
                  left: 16,
                  child: CircleAvatar(
                    backgroundColor: Colors.white.withValues(alpha: 0.9),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: CircleAvatar(
                    backgroundColor: Colors.white.withValues(alpha: 0.9),
                    child: IconButton(
                      icon: Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        color: isFav ? AppColors.error : AppColors.textLight,
                      ),
                      onPressed: () => favProvider.toggleFavourite(_foodItem.id),
                    ),
                  ),
                ),

                // Gallery Thumbnail Selector Bar
                if (_foodItem.galleryImages.length > 1)
                  Positioned(
                    bottom: 12,
                    left: 20,
                    right: 20,
                    child: SizedBox(
                      height: 54,
                      child: Center(
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: _foodItem.galleryImages.length,
                          itemBuilder: (context, index) {
                            String img = _foodItem.galleryImages[index];
                            bool isSelected = img == _selectedImage;
                            return GestureDetector(
                              onTap: () => setState(() => _selectedImage = img),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                margin: const EdgeInsets.symmetric(horizontal: 4),
                                width: 54,
                                height: 54,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: isSelected ? AppColors.primary : Colors.white,
                                    width: 2.5,
                                  ),
                                  boxShadow: const [AppColors.cardShadow],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(img, fit: BoxFit.cover),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            // Content Section
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category, Badges, & Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.secondary,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              _foodItem.category.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (_foodItem.isVeg) ...[
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.success,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text('VEG', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                            ),
                          ],
                          if (_foodItem.isSpicy) ...[
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.error,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text('SPICY', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: AppColors.starYellow, size: 18),
                          const SizedBox(width: 4),
                          Text(
                            Formatters.rating(_foodItem.rating),
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          Text(
                            ' (${_foodItem.reviewCount} reviews)',
                            style: const TextStyle(color: AppColors.textLight, fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Item Name & Base Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          _foodItem.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      Text(
                        Formatters.currency(_calculatedUnitPrice),
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Quick Stats: Prep time & Calories
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 16, color: AppColors.textLight),
                      const SizedBox(width: 4),
                      Text(_foodItem.prepTime, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                      const SizedBox(width: 16),
                      const Icon(Icons.local_fire_department, size: 16, color: AppColors.primary),
                      const SizedBox(width: 4),
                      Text('${_foodItem.calories} kcal', style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                    ],
                  ),
                  const Divider(height: 32),

                  // Description
                  const Text('Description', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Text(
                    _foodItem.description,
                    style: const TextStyle(color: AppColors.textSecondary, fontSize: 14, height: 1.5),
                  ),

                  // Ingredients
                  if (_foodItem.ingredients.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    const Text('Ingredients', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: _foodItem.ingredients.map((ing) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceSubtle,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.border, width: 0.5),
                          ),
                          child: Text(ing, style: const TextStyle(fontSize: 12, color: AppColors.textPrimary)),
                        );
                      }).toList(),
                    ),
                  ],
                  const Divider(height: 32),

                  // Customization Options (Sizes, Crust, etc.)
                  if (_foodItem.options.isNotEmpty) ...[
                    ..._foodItem.options.map((opt) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Select ${opt.name}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            children: opt.choices.map((choice) {
                              bool isSelected = _selectedOptions[opt.name] == choice;
                              return ChoiceChip(
                                label: Text(choice),
                                selected: isSelected,
                                selectedColor: AppColors.primary,
                                backgroundColor: AppColors.surfaceSubtle,
                                labelStyle: TextStyle(
                                  color: isSelected ? Colors.white : AppColors.textPrimary,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                ),
                                onSelected: (sel) {
                                  if (sel) setState(() => _selectedOptions[opt.name] = choice);
                                },
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 16),
                        ],
                      );
                    }),
                    const Divider(height: 24),
                  ],

                  // Add-Ons Selection Checklist
                  if (_foodItem.addOns.isNotEmpty) ...[
                    const Text('Customize Add-Ons', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Column(
                      children: _foodItem.addOns.map((addOn) {
                        bool isChecked = _selectedAddOns.contains(addOn);
                        return CheckboxListTile(
                          title: Text(addOn.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                          subtitle: Text('+ ${Formatters.currency(addOn.price)}', style: const TextStyle(color: AppColors.primary, fontSize: 12)),
                          value: isChecked,
                          activeColor: AppColors.primary,
                          contentPadding: EdgeInsets.zero,
                          onChanged: (val) {
                            setState(() {
                              if (val == true) {
                                _selectedAddOns.add(addOn);
                              } else {
                                _selectedAddOns.remove(addOn);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                    const Divider(height: 32),
                  ],

                  // Quantity Selector
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Quantity', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.border),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove, size: 18),
                              onPressed: () {
                                if (_quantity > 1) setState(() => _quantity--);
                              },
                            ),
                            Text('$_quantity', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            IconButton(
                              icon: const Icon(Icons.add, size: 18),
                              onPressed: () => setState(() => _quantity++),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),

                  // Similar Items Section
                  if (similarItems.isNotEmpty) ...[
                    const Text('You Might Also Like', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 290,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: similarItems.length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            width: 210,
                            child: FoodCard(item: similarItems[index]),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 28),
                  ],

                  // Customer Reviews Section
                  const Text('Reviews & Ratings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  ...mockReviews.take(2).map((rev) => Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.border, width: 0.5),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(rev.userName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                Row(
                                  children: [
                                    const Icon(Icons.star, size: 14, color: AppColors.starYellow),
                                    const SizedBox(width: 2),
                                    Text(rev.rating.toStringAsFixed(1), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(rev.comment, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                          ],
                        ),
                      )),
                ],
              ),
            ),

            // Footer
            const CustomFooter(),
          ],
        ),
      ),

      // Sticky Bottom Add-to-Cart Bar
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 16,
              offset: const Offset(0, -4),
            )
          ],
        ),
        child: Center(
          heightFactor: 1.0,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Row(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Total Price', style: TextStyle(fontSize: 11, color: AppColors.textLight)),
                    Text(
                      Formatters.currency(_calculatedTotalPrice),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      cartProvider.addItem(
                        item: _foodItem,
                        quantity: _quantity,
                        selectedAddOns: _selectedAddOns.toList(),
                        selectedOptions: _selectedOptions,
                        specialInstructions: _notesController.text.isNotEmpty ? _notesController.text : null,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Added $_quantity x ${_foodItem.name} to cart!'),
                          duration: const Duration(seconds: 2),
                          backgroundColor: AppColors.secondary,
                          behavior: SnackBarBehavior.floating,
                          action: SnackBarAction(
                            label: 'VIEW CART',
                            textColor: AppColors.primaryLight,
                            onPressed: () {
                              Navigator.pushNamed(context, AppRouter.cartRoute);
                            },
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.shopping_bag_outlined),
                    label: const Text('ADD TO CART', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}