import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/provider/cart_provider.dart';
import 'cart_item_card.dart';

class CartList extends ConsumerWidget {
  const CartList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);

    if (cartItems.isEmpty) {
      return const Center(
        child: Text(
          "Cart masih kosong",
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        return CartItemCard(
          item: cartItems[index],
          index: index,
        );
      },
    );
  }
}