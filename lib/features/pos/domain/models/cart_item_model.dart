import 'product_model.dart';

class CartItemModel {
  final ProductModel product;

  /// variant yang dipilih
  final Map<String, String> selectedVariants;

  /// topping yang dipilih
  final List<String> selectedToppings;

  final int quantity;

  final String note;

  /// harga final setelah variant + topping
  final double unitPrice;

  const CartItemModel({
    required this.product,
    required this.selectedVariants,
    required this.selectedToppings,
    required this.quantity,
    required this.note,
    required this.unitPrice,
  });

  double get totalPrice => unitPrice * quantity;
}