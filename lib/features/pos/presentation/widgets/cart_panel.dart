import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_pos_mobile/features/pos/application/provider/cart_provider.dart';
import 'package:smart_pos_mobile/features/pos/domain/models/order_type.dart';
import '../../../../core/theme/app_colors.dart';
import '../../application/provider/order_type_provider.dart';

class CartPanel extends ConsumerWidget {
  const CartPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final selectedType = ref.watch(orderTypeProvider);
    final cartItems = ref.watch(cartProvider);

double total = cartItems.fold(
  0,
  (sum, item) => sum + item.price,
);
    return Column(
      children: [

        /// ================= HEADER
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 16, vertical: 14),
          color: AppColors.primary.withOpacity(0.08),
          child: const Row(
            children: [
              Icon(Icons.shopping_cart_outlined,
                  color: AppColors.primary),
              SizedBox(width: 8),
              Text(
                "Cart",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),

        /// ================= ORDER TYPE DROPDOWN
        Padding(
          padding: const EdgeInsets.all(12),
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColors.primary.withOpacity(0.3),
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<OrderType>(
                value: selectedType,
                isExpanded: true,
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.primary,
                ),

                items: OrderType.values.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type.label),
                  );
                }).toList(),

                onChanged: (value) {
                  ref
                      .read(orderTypeProvider.notifier)
                      .state = value!;
                },
              ),
            ),
          ),
        ),

        /// ================= CART ITEMS
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: 3,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text("Item $index"),
                trailing: const Text(
                  "Rp 10.000",
                  style: TextStyle(
                    color: AppColors.primaryDark,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
        ),
        Container(
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    border: Border(
      top: BorderSide(color: Colors.grey.shade200),
    ),
  ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Text(
        "TOTAL",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      Text(
        "Rp ${total.toStringAsFixed(0)}",
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    ],
  ),
),
      ],
    );
  }
}