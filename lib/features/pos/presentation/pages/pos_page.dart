import 'package:flutter/material.dart';

import '../widgets/product_grid.dart';
import '../widgets/cart_panel.dart';
import '../widgets/payment_bar.dart';
import '../../../../core/theme/app_colors.dart';
class PosPage extends StatelessWidget {
  const PosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Smart POS"),
      ),

      body: Row(
        children: [

          /// ========================
          /// LEFT SIDE - PRODUCT GRID
          /// ========================
          const Expanded(
            flex: 3,
            child: ProductGrid(),
          ),

          /// ========================
          /// RIGHT SIDE - CART + PAYMENT
          /// ========================
Expanded(
  flex: 2,
  child: Container(
    margin: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 12,
          offset: const Offset(0, 4),
        )
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Column(
        children: const [
          Expanded(child: CartPanel()),
          PaymentBar(),
        ],
      ),
    ),
  ),
),
        ],
      ),
    );
  }
}