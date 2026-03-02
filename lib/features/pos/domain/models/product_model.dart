class ProductModel {
  final String id;
  final String name;
  final double price;
  final String? category;
  final String? imageUrl;

  const ProductModel({
    required this.id,
    required this.name,
    required this.price,
    this.category,
    this.imageUrl,
  });
}