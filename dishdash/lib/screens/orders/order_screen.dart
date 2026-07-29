import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/food_card/food_card.dart';
import '../../components/footer/custom_footer.dart';
import '../../models/order.dart';
import '../../providers/cart_provider.dart';
import '../../providers/favourites_provider.dart';
import '../../providers/orders_provider.dart';
import '../../routes/app_router.dart';
import '../../styles/app_colors.dart';
import '../../utils/formatters.dart';

class OrderScreen extends StatefulWidget {
  final int initialTabIndex;

  const OrderScreen({
    super.key,
    this.initialTabIndex = 0,
  });

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: widget.initialTabIndex,
    );
    _tabController.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrdersProvider>(context);
    final favProvider = Provider.of<FavouritesProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Track & My Orders',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                TabBar(
                  controller: _tabController,
                  labelColor: AppColors.primary,
                  unselectedLabelColor: AppColors.textLight,
                  indicatorColor: AppColors.primary,
                  indicatorWeight: 3,
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  tabs: const [
                    Tab(text: 'Active Orders'),
                    Tab(text: 'Order History'),
                    Tab(text: 'Favourites'),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 520,
            child: TabBarView(
              controller: _tabController,
              physics: const ClampingScrollPhysics(),
              children: [
                // Tab 1: Active Orders
                _buildActiveOrdersTab(context, ordersProvider, cartProvider),

                // Tab 2: Order History
                _buildOrderHistoryTab(context, ordersProvider, cartProvider),

                // Tab 3: Favourites
                _buildFavouritesTab(context, favProvider),
              ],
            ),
          ),
          if (_tabController.index != 2) const CustomFooter(),
        ],
      ),
    );
  }

  Widget _buildActiveOrdersTab(
    BuildContext context,
    OrdersProvider ordersProvider,
    CartProvider cartProvider,
  ) {
    final activeOrders = ordersProvider.activeOrders;

    if (activeOrders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.delivery_dining, size: 64, color: AppColors.textLight),
            const SizedBox(height: 12),
            const Text('No Active Orders', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            const Text('Your live food orders will appear here.', style: TextStyle(color: AppColors.textLight)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, AppRouter.menuRoute),
              child: const Text('ORDER NOW'),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: activeOrders.length,
      itemBuilder: (context, index) {
        final order = activeOrders[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      order.orderNumber,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        order.status.displayName,
                        style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text('Est. Delivery: ${order.estimatedTime}', style: const TextStyle(color: AppColors.textLight, fontSize: 12)),
                const Divider(height: 24),

                // Live Status Timeline Stepper
                const Text('Live Order Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 12),
                _buildStatusTimeline(order.status),
                const Divider(height: 24),

                // Items summary
                ...order.items.map((i) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${i.quantity}x ${i.item.name}', style: const TextStyle(fontSize: 13)),
                          Text(Formatters.currency(i.totalPrice), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                        ],
                      ),
                    )),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total Paid', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    Text(Formatters.currency(order.totalAmount), style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18, color: AppColors.primary)),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatusTimeline(OrderStatus currentStatus) {
    List<OrderStatus> steps = [
      OrderStatus.placed,
      OrderStatus.preparing,
      OrderStatus.ready,
      OrderStatus.onTheWay,
      OrderStatus.delivered,
    ];

    int currentStep = currentStatus.stepIndex;

    return Row(
      children: List.generate(steps.length, (index) {
        bool isDone = index <= currentStep;

        return Expanded(
          child: Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: isDone ? AppColors.primary : AppColors.border,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isDone ? Icons.check : Icons.circle,
                  size: 14,
                  color: Colors.white,
                ),
              ),
              if (index < steps.length - 1)
                Expanded(
                  child: Container(
                    height: 4,
                    color: index < currentStep ? AppColors.primary : AppColors.border,
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildOrderHistoryTab(
    BuildContext context,
    OrdersProvider ordersProvider,
    CartProvider cartProvider,
  ) {
    final pastOrders = ordersProvider.pastOrders;

    if (pastOrders.isEmpty) {
      return const Center(
        child: Text('No order history yet.'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: pastOrders.length,
      itemBuilder: (context, index) {
        final order = pastOrders[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(order.orderNumber, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    Text(Formatters.formatDate(order.placedAt), style: const TextStyle(color: AppColors.textLight, fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 8),
                Text('${order.items.length} items • ${Formatters.currency(order.totalAmount)}', style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () {
                    ordersProvider.reorder(order, cartProvider);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Items added back to your cart!')),
                    );
                    Navigator.pushNamed(context, AppRouter.cartRoute);
                  },
                  icon: const Icon(Icons.replay, size: 16),
                  label: const Text('REORDER'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFavouritesTab(BuildContext context, FavouritesProvider favProvider) {
    final favItems = favProvider.favouriteItems;

    if (favItems.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.favorite_border, size: 64, color: AppColors.textLight),
            const SizedBox(height: 12),
            const Text('No Favourite Dishes Saved', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            const Text('Tap the heart icon on any food card to save your favourites here!', textAlign: TextAlign.center, style: TextStyle(color: AppColors.textLight)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: favItems.length,
      itemBuilder: (context, index) {
        return FoodCard(item: favItems[index], isListView: true);
      },
    );
  }
}