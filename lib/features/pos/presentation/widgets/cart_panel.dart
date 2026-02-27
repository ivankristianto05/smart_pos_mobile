import 'package:flutter/material.dart';

class CartPanel extends StatelessWidget {
  const CartPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            "Current Order",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const Expanded(
            child: Center(
              child: Text("Cart Empty"),
            ),
          ),

          Container(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {},
              child: const Text("PAY"),
            ),
          )
        ],
      ),
    );
  }
}