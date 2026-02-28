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
          Container(
            width: 350,
            color: AppColors.surface,

            child: Column(
              children: [

                /// CART LIST
                const Expanded(
                  child: CartPanel(),
                ),

                /// PAYMENT AREA
                const PaymentBar(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}