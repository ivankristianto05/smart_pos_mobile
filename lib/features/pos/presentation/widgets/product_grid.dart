import 'package:flutter/material.dart';
import 'package:smart_pos_mobile/features/pos/domain/models/product_model.dart';
import 'product_card.dart';
import '../widgets/product_dialog.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1,
      ),
      itemCount: 20,
      itemBuilder: (context, index) {

        final product = ProductModel(
          id: index.toString(),
          name: "Product $index",
          price: 10000,
        );

        return ProductCard(
          name: product.name,
          price: product.price,
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => ProductDialog(product: product),
            );
          },
        );
      },
    );
  }
}