import 'package:flutter/material.dart';
import '../../domain/models/cart_item_model.dart';

class CartController extends ChangeNotifier {

  final List<CartItemModel> _items = [];

  List<CartItemModel> get items => _items;

  /// TOTAL PRICE
  double get totalPrice =>
      _items.fold(0, (sum, item) => sum + item.totalPrice);

  /// ADD ITEM
  void addItem(CartItemModel item) {
    _items.add(item);
    notifyListeners();
  }

  /// REMOVE ITEM
  void removeItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  /// CLEAR CART
  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}