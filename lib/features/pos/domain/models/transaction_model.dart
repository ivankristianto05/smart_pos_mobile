import 'package:smart_pos_mobile/features/pos/domain/models/cart_item_model.dart';
import 'package:smart_pos_mobile/features/pos/domain/models/order_type.dart';

class TransactionData {
  final List<CartItemModel> items;
  final int total;
  final OrderType orderType;
  final int? tableNumber;
  final String customerName;

  TransactionData({
    required this.items,
    required this.total,
    required this.orderType,
    this.tableNumber,
    required this.customerName,
  });
}