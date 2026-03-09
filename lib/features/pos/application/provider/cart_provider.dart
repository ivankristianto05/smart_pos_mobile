import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/cart_item_model.dart';

class CartController extends StateNotifier<List<CartItemModel>> {
  CartController() : super([]);

  /// ADD ITEM
  void addItem(CartItemModel item) {
    state = [...state, item];
  }
  void updateItem(int index, CartItemModel newItem) {

  final updated = [...state];

  updated[index] = newItem;

  state = updated;
}
  /// REMOVE ITEM
  void removeItem(int index) {
    final newList = [...state];
    newList.removeAt(index);
    state = newList;
  }

  /// CLEAR CART
  void clearCart() {
    state = [];
  }

  /// TOTAL PRICE
  double get totalPrice {
    return state.fold(0.0, (sum, item) => sum + item.totalPrice);
  }
}

/// PROVIDER
final cartProvider =
    StateNotifierProvider<CartController, List<CartItemModel>>(
  (ref) => CartController(),
);