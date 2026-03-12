import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../application/provider/cart_provider.dart';

class CartHeader extends ConsumerWidget {
  const CartHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);

    /// jumlah item di cart
    final itemCount = cartItems.length;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
      ),
      child: Row(
        children: [

          /// ICON CART
          const Icon(
            Icons.shopping_cart_outlined,
            color: AppColors.primary,
          ),

          const SizedBox(width: 8),

          /// TITLE + ITEM COUNT
          Text(
            "Cart ($itemCount)",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),

          const Spacer(),

          /// MENU 3 DOT
          PopupMenuButton<String>(
            tooltip: "Cart Options",
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              // nanti kita isi logicnya
            },
            itemBuilder: (context) => [

              const PopupMenuItem(
                value: "print",
                child: Row(
                  children: [
                    Icon(Icons.receipt_long, size: 18),
                    SizedBox(width: 10),
                    Text("Cetak Struk"),
                  ],
                ),
              ),

              const PopupMenuItem(
                value: "clear",
                child: Row(
                  children: [
                    Icon(Icons.delete_sweep, size: 18),
                    SizedBox(width: 10),
                    Text("Hapus Keranjang"),
                  ],
                ),
              ),

              const PopupMenuItem(
                value: "hold",
                child: Row(
                  children: [
                    Icon(Icons.pause_circle_outline, size: 18),
                    SizedBox(width: 10),
                    Text("Hold Order"),
                  ],
                ),
              ),

              const PopupMenuItem(
                value: "detail",
                child: Row(
                  children: [
                    Icon(Icons.info_outline, size: 18),
                    SizedBox(width: 10),
                    Text("Detail Order"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}