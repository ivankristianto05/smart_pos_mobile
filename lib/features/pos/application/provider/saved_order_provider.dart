import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/saved_order_model.dart';
import '../../domain/models/cart_item_model.dart';
import 'dart:math';

class SavedOrderController extends StateNotifier<List<SavedOrderModel>> {
  SavedOrderController() : super([]);

  /// SAVE ORDER
  void saveOrder(String name, List<CartItemModel> items) {
    final order = SavedOrderModel(
      id: Random().nextInt(999999).toString(),
      name: name,
      createdAt: DateTime.now(),
      items: List.from(items),
    );

    state = [...state, order];
  }

  /// DELETE ORDER
  void deleteOrder(String id) {
    state = state.where((o) => o.id != id).toList();
  }
  void updateOrder(String id, List<CartItemModel> items) {
  state = [
    for (final order in state)
      if (order.id == id)
        SavedOrderModel(
          id: order.id,
          name: order.name,
          createdAt: order.createdAt,
          items: List.from(items),
        )
      else
        order
  ];
}
}

final savedOrderProvider =
    StateNotifierProvider<SavedOrderController, List<SavedOrderModel>>(
  (ref) => SavedOrderController(),
);