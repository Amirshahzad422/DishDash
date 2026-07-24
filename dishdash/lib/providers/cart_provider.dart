import 'package:flutter/material.dart';
import '../models/food_item.dart';
import '../models/order.dart';

class CartProvider extends ChangeNotifier {
  final List<OrderItem> _items = [];
  String _orderType = 'Delivery'; // 'Delivery', 'Pickup', 'Dine-in'
  String? _appliedPromoCode;
  double _discountPercent = 0.0;
  bool _freeShipping = false;

  List<OrderItem> get items => List.unmodifiable(_items);
  int get itemCount => _items.fold(0, (sum, i) => sum + i.quantity);
  String get orderType => _orderType;
  String? get appliedPromoCode => _appliedPromoCode;

  double get subtotal => _items.fold(0.0, (sum, i) => sum + i.totalPrice);

  double get deliveryFee {
    if (_orderType != 'Delivery' || _freeShipping || _items.isEmpty) {
      return 0.0;
    }
    return 2.99;
  }

  double get tax => subtotal * 0.08;

  double get discountAmount => subtotal * _discountPercent;

  double get totalAmount {
    if (_items.isEmpty) return 0.0;
    double total = subtotal + deliveryFee + tax - discountAmount;
    return total < 0 ? 0.0 : total;
  }

  void addItem({
    required FoodItem item,
    int quantity = 1,
    List<AddOn> selectedAddOns = const [],
    Map<String, String> selectedOptions = const {},
    String? specialInstructions,
  }) {
    // Check if matching item with same add-ons exists
    int existingIndex = _items.indexWhere((i) =>
        i.item.id == item.id &&
        _areAddOnsEqual(i.selectedAddOns, selectedAddOns) &&
        _areOptionsEqual(i.selectedOptions, selectedOptions));

    if (existingIndex >= 0) {
      var existing = _items[existingIndex];
      _items[existingIndex] = OrderItem(
        item: existing.item,
        quantity: existing.quantity + quantity,
        selectedAddOns: existing.selectedAddOns,
        selectedOptions: existing.selectedOptions,
        specialInstructions: specialInstructions ?? existing.specialInstructions,
      );
    } else {
      _items.add(OrderItem(
        item: item,
        quantity: quantity,
        selectedAddOns: selectedAddOns,
        selectedOptions: selectedOptions,
        specialInstructions: specialInstructions,
      ));
    }
    notifyListeners();
  }

  void updateQuantity(int index, int newQuantity) {
    if (index >= 0 && index < _items.length) {
      if (newQuantity <= 0) {
        _items.removeAt(index);
      } else {
        var existing = _items[index];
        _items[index] = OrderItem(
          item: existing.item,
          quantity: newQuantity,
          selectedAddOns: existing.selectedAddOns,
          selectedOptions: existing.selectedOptions,
          specialInstructions: existing.specialInstructions,
        );
      }
      notifyListeners();
    }
  }

  void removeItem(int index) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
      notifyListeners();
    }
  }

  void setOrderType(String type) {
    _orderType = type;
    notifyListeners();
  }

  bool applyPromoCode(String code) {
    String cleanCode = code.trim().toUpperCase();
    if (cleanCode == 'DISHDASH10') {
      _appliedPromoCode = 'DISHDASH10 (10% OFF)';
      _discountPercent = 0.10;
      _freeShipping = false;
      notifyListeners();
      return true;
    } else if (cleanCode == 'FREESHIP') {
      _appliedPromoCode = 'FREESHIP (Free Delivery)';
      _discountPercent = 0.0;
      _freeShipping = true;
      notifyListeners();
      return true;
    }
    return false;
  }

  void removePromoCode() {
    _appliedPromoCode = null;
    _discountPercent = 0.0;
    _freeShipping = false;
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    _appliedPromoCode = null;
    _discountPercent = 0.0;
    _freeShipping = false;
    notifyListeners();
  }

  bool _areAddOnsEqual(List<AddOn> a, List<AddOn> b) {
    if (a.length != b.length) return false;
    var setA = a.map((x) => x.id).toSet();
    var setB = b.map((x) => x.id).toSet();
    return setA.containsAll(setB);
  }

  bool _areOptionsEqual(Map<String, String> a, Map<String, String> b) {
    if (a.length != b.length) return false;
    for (var key in a.keys) {
      if (b[key] != a[key]) return false;
    }
    return true;
  }
}
