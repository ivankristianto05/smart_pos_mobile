import 'cart_item_model.dart';

class SavedOrderModel {
  final String id;
  final String name;
  final DateTime createdAt;
  final List<CartItemModel> items;

  SavedOrderModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.items,
  });
}