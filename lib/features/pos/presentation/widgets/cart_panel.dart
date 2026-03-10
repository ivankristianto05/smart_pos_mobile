import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/provider/cart_provider.dart';
import '../widgets/cart_header.dart';
import '../widgets/order_type_selector.dart';
import '../widgets/cart_list.dart';
import '../widgets/cart_total.dart';

class CartPanel extends ConsumerWidget {
  const CartPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);

    double total = cartItems.fold(
      0.0,
      (sum, item) => sum + item.totalPrice,
    );

    return Column(
      children: [

        /// HEADER
        const CartHeader(),

        /// ORDER TYPE
        const OrderTypeSelector(),

        /// CART LIST
        const Expanded(
          child: CartList(),
        ),

        /// TOTAL
        CartTotal(total: total),
      ],
    );
  }
}