import 'food_item.dart';

enum OrderStatus {
  placed,
  preparing,
  ready,
  onTheWay,
  delivered,
}

extension OrderStatusExtension on OrderStatus {
  String get displayName {
    switch (this) {
      case OrderStatus.placed:
        return 'Order Placed';
      case OrderStatus.preparing:
        return 'Preparing Food';
      case OrderStatus.ready:
        return 'Ready for Pickup';
      case OrderStatus.onTheWay:
        return 'Out for Delivery';
      case OrderStatus.delivered:
        return 'Delivered';
    }
  }

  int get stepIndex {
    switch (this) {
      case OrderStatus.placed:
        return 0;
      case OrderStatus.preparing:
        return 1;
      case OrderStatus.ready:
        return 2;
      case OrderStatus.onTheWay:
        return 3;
      case OrderStatus.delivered:
        return 4;
    }
  }
}

class OrderItem {
  final FoodItem item;
  final int quantity;
  final List<AddOn> selectedAddOns;
  final Map<String, String> selectedOptions;
  final String? specialInstructions;

  OrderItem({
    required this.item,
    required this.quantity,
    this.selectedAddOns = const [],
    this.selectedOptions = const {},
    this.specialInstructions,
  });

  double get unitPrice {
    double addOnTotal = selectedAddOns.fold(0, (sum, a) => sum + a.price);
    return item.price + addOnTotal;
  }

  double get totalPrice => unitPrice * quantity;
}

class Order {
  final String id;
  final String orderNumber;
  final List<OrderItem> items;
  final double subtotal;
  final double deliveryFee;
  final double tax;
  final double discount;
  final double totalAmount;
  final String orderType; // 'Delivery', 'Pickup', 'Dine-in'
  OrderStatus status;
  final DateTime placedAt;
  final String estimatedTime;
  final String deliveryAddress;
  final String paymentMethod;

  Order({
    required this.id,
    required this.orderNumber,
    required this.items,
    required this.subtotal,
    required this.deliveryFee,
    required this.tax,
    required this.discount,
    required this.totalAmount,
    required this.orderType,
    required this.status,
    required this.placedAt,
    required this.estimatedTime,
    required this.deliveryAddress,
    required this.paymentMethod,
  });
}
