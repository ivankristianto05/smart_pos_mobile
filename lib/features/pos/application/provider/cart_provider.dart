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
    final updated = [...state];
    updated.removeAt(index);
    state = updated;
  }

  /// CLEAR CART
  void clearCart() {
    state = [];
  }

  /// TOTAL PRICE
  double get totalPrice {
    return state.fold(0.0, (sum, item) => sum + item.totalPrice);
  }
  void increaseQty(int index) {
  final updated = [...state];

  final item = updated[index];

  updated[index] = item.copyWith(
    quantity: item.quantity + 1,
  );

  state = updated;
}

void decreaseQty(int index) {
  final updated = [...state];

  final item = updated[index];

  if (item.quantity > 1) {
    updated[index] = item.copyWith(
      quantity: item.quantity - 1,
    );
  } else {
    updated.removeAt(index);
  }

  state = updated;
}
}

/// PROVIDER
final cartProvider =
    StateNotifierProvider<CartController, List<CartItemModel>>(
  (ref) => CartController(),
);