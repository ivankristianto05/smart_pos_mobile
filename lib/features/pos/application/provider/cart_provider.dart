import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/product_model.dart';

final cartProvider =
    StateProvider<List<ProductModel>>((ref) => []);