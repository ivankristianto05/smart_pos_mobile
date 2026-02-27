import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final int price;

  const ProductCard({
    super.key,
    required this.name,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.fastfood, size: 40),
              Text(name),
              Text("Rp $price"),
            ],
          ),
        ),
      ),
    );
  }
}