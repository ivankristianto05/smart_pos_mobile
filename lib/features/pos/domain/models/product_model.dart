class ProductModel {
  final String id;
  final String name;
  final double basePrice;
  final String? category;
  final String? imageUrl;
  final Map<String, Map<String, double>> variants;
  final Map<String, double> toppings;

  const ProductModel({
    required this.id,
    required this.name,
    required this.basePrice,
    this.category,
    this.imageUrl,
    this.variants = const {},
    this.toppings = const {},

  });
}