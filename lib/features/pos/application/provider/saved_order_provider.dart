import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/saved_order_model.dart';
import '../../domain/models/cart_item_model.dart';
import '../../domain/models/order_type.dart';
import 'dart:math';

class SavedOrderController extends StateNotifier<List<SavedOrderModel>> {
  SavedOrderController() : super([]);

  /// SAVE ORDER
  void saveOrder({
    required OrderType orderType,
    int? tableNumber,
    required String customerName,
    required List<CartItemModel> items,
  }) {

    final order = SavedOrderModel(
      id: Random().nextInt(999999).toString(),
      orderType: orderType,
      tableNumber: tableNumber,
      customerName: customerName,
      createdAt: DateTime.now(),
      items: List.from(items),
    );

    state = [...state, order];
  }

  /// DELETE ORDER
  void deleteOrder(String id) {
    state = state.where((o) => o.id != id).toList();
  }

  /// UPDATE ORDER
  void updateOrder(String id, List<CartItemModel> items) {

    state = [
      for (final order in state)
        if (order.id == id)
          SavedOrderModel(
            id: order.id,
            orderType: order.orderType,
            tableNumber: order.tableNumber,
            customerName: order.customerName,
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