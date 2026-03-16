import 'cart_item_model.dart';
import 'order_type.dart';

class SavedOrderModel {
  final String id;

  /// ORDER HEADER
  final OrderType orderType;
  final int? tableNumber;
  final String customerName;

  /// ORDER DATA
  final DateTime createdAt;
  final List<CartItemModel> items;

  SavedOrderModel({
    required this.id,
    required this.orderType,
    this.tableNumber,
    required this.customerName,
    required this.createdAt,
    required this.items,
  });
}