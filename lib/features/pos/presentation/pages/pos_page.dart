import 'package:flutter/material.dart';
import '../widgets/pos_sidebar.dart';
import '../widgets/product_grid.dart';
import '../widgets/cart_panel.dart';

class PosPage extends StatelessWidget {
  const PosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: const [

          /// SIDEBAR
          SizedBox(
            width: 80,
            child: PosSidebar(),
          ),

          /// PRODUCT AREA
          Expanded(
            flex: 5,
            child: ProductGrid(),
          ),

          /// CART AREA
          SizedBox(
            width: 350,
            child: CartPanel(),
          ),
        ],
      ),
    );
  }
}