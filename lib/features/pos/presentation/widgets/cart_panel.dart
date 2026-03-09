import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_pos_mobile/features/pos/application/provider/cart_provider.dart';
import 'package:smart_pos_mobile/features/pos/domain/models/order_type.dart';
import '../../../../core/theme/app_colors.dart';
import '../../application/provider/order_type_provider.dart';
import '../widgets/product_dialog.dart';

class CartPanel extends ConsumerWidget {
  const CartPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedType = ref.watch(orderTypeProvider);
    final cartItems = ref.watch(cartProvider);

    /// TOTAL CART
    double total = cartItems.fold(
      0.0,
      (sum, item) => sum + item.totalPrice,
    );

    return Column(
      children: [

        /// ================= HEADER
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          color: AppColors.primary.withOpacity(0.08),
          child: const Row(
            children: [
              Icon(
                Icons.shopping_cart_outlined,
                color: AppColors.primary,
              ),
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

        /// ================= ORDER TYPE
        Padding(
          padding: const EdgeInsets.all(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
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
          child: cartItems.isEmpty
              ? const Center(
                  child: Text(
                    "Cart masih kosong",
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {

                    final item = cartItems[index];

                    /// VARIANT TEXT
                    final variantText = item.selectedVariants.entries
                        .map((e) => e.value)
                        .join(", ");

                    /// TOPPING TEXT
                    final toppingText =
                        item.selectedToppings.join(", ");

                    return InkWell(
                      borderRadius: BorderRadius.circular(10),

                      /// TAP UNTUK EDIT ITEM
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => ProductDialog(
                            product: item.product,
                            existingItem: item,
                            cartIndex: index,
                          ),
                        );
                      },

                      child: Card(
                        elevation: 1,
                        margin:
                            const EdgeInsets.only(bottom: 10),

                        child: Padding(
                          padding: const EdgeInsets.all(10),

                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [

                              /// PRODUCT NAME
                              Text(
                                item.product.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              /// VARIANTS
                              if (variantText.isNotEmpty)
                                Text(
                                  variantText,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),

                              /// TOPPINGS
                              if (toppingText.isNotEmpty)
                                Text(
                                  "+ $toppingText",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),

                              /// NOTE
                              if (item.note.isNotEmpty)
                                Text(
                                  "Note: ${item.note}",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontStyle:
                                        FontStyle.italic,
                                  ),
                                ),

                              const SizedBox(height: 6),

                              /// QTY + PRICE
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                children: [

                                  Text(
                                    "${item.quantity} x Rp ${item.unitPrice.toStringAsFixed(0)}",
                                    style: const TextStyle(
                                        fontSize: 13),
                                  ),

                                  Text(
                                    "Rp ${item.totalPrice.toStringAsFixed(0)}",
                                    style: const TextStyle(
                                      color:
                                          AppColors.primaryDark,
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),

        /// ================= TOTAL
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.grey.shade200,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
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