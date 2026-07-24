import 'dart:async';
import 'package:flutter/material.dart';
import '../models/order.dart';
import '../data/mock_food_data.dart';
import 'cart_provider.dart';

class OrdersProvider extends ChangeNotifier {
  final List<Order> _orders = [];
  Timer? _statusSimulationTimer;

  List<Order> get orders => List.unmodifiable(_orders);

  List<Order> get activeOrders =>
      _orders.where((o) => o.status != OrderStatus.delivered).toList();

  List<Order> get pastOrders =>
      _orders.where((o) => o.status == OrderStatus.delivered).toList();

  OrdersProvider() {
    _initializeSampleOrders();
    _startStatusSimulation();
  }

  void _initializeSampleOrders() {
    _orders.addAll([
      Order(
        id: 'ord_101',
        orderNumber: 'DD-84920',
        items: [
          OrderItem(
            item: mockFoodItems[0], // DishDash Special Pizza
            quantity: 1,
            selectedAddOns: [mockFoodItems[0].addOns[0]],
          ),
          OrderItem(
            item: mockFoodItems[9], // Mint Fresh Lemonade
            quantity: 2,
          ),
        ],
        subtotal: 25.47,
        deliveryFee: 2.99,
        tax: 2.03,
        discount: 0.0,
        totalAmount: 30.49,
        orderType: 'Delivery',
        status: OrderStatus.preparing,
        placedAt: DateTime.now().subtract(const Duration(minutes: 12)),
        estimatedTime: '20-25 mins',
        deliveryAddress: '742 Evergreen Terrace, Suite 4B',
        paymentMethod: 'Credit Card (**** 4242)',
      ),
      Order(
        id: 'ord_100',
        orderNumber: 'DD-73819',
        items: [
          OrderItem(
            item: mockFoodItems[3], // Classic Angus Beef Burger
            quantity: 2,
          ),
        ],
        subtotal: 17.98,
        deliveryFee: 0.0,
        tax: 1.44,
        discount: 1.80,
        totalAmount: 17.62,
        orderType: 'Pickup',
        status: OrderStatus.delivered,
        placedAt: DateTime.now().subtract(const Duration(days: 2)),
        estimatedTime: 'Completed',
        deliveryAddress: 'Pickup from Downtown Branch',
        paymentMethod: 'Cash on Pickup',
      ),
    ]);
  }

  Order createOrder({
    required List<OrderItem> items,
    required double subtotal,
    required double deliveryFee,
    required double tax,
    required double discount,
    required double totalAmount,
    required String orderType,
    required String address,
    required String paymentMethod,
  }) {
    int randomId = 10000 + (DateTime.now().millisecondsSinceEpoch % 89999);
    String orderNum = 'DD-$randomId';

    Order newOrder = Order(
      id: 'ord_${DateTime.now().millisecondsSinceEpoch}',
      orderNumber: orderNum,
      items: List.from(items),
      subtotal: subtotal,
      deliveryFee: deliveryFee,
      tax: tax,
      discount: discount,
      totalAmount: totalAmount,
      orderType: orderType,
      status: OrderStatus.placed,
      placedAt: DateTime.now(),
      estimatedTime: '25-30 mins',
      deliveryAddress: address,
      paymentMethod: paymentMethod,
    );

    _orders.insert(0, newOrder);
    notifyListeners();
    return newOrder;
  }

  void _startStatusSimulation() {
    _statusSimulationTimer?.cancel();
    // Periodically update active orders to simulate live delivery progress!
    _statusSimulationTimer = Timer.periodic(const Duration(seconds: 15), (timer) {
      bool updated = false;
      for (var order in _orders) {
        if (order.status == OrderStatus.placed) {
          order.status = OrderStatus.preparing;
          updated = true;
        } else if (order.status == OrderStatus.preparing) {
          order.status = OrderStatus.ready;
          updated = true;
        } else if (order.status == OrderStatus.ready) {
          if (order.orderType == 'Delivery') {
            order.status = OrderStatus.onTheWay;
          } else {
            order.status = OrderStatus.delivered;
          }
          updated = true;
        } else if (order.status == OrderStatus.onTheWay) {
          order.status = OrderStatus.delivered;
          updated = true;
        }
      }
      if (updated) {
        notifyListeners();
      }
    });
  }

  void reorder(Order order, CartProvider cartProvider) {
    for (var item in order.items) {
      cartProvider.addItem(
        item: item.item,
        quantity: item.quantity,
        selectedAddOns: item.selectedAddOns,
        selectedOptions: item.selectedOptions,
        specialInstructions: item.specialInstructions,
      );
    }
  }

  @override
  void dispose() {
    _statusSimulationTimer?.cancel();
    super.dispose();
  }
}
