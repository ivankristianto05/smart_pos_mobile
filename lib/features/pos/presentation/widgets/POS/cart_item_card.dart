import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../application/provider/cart_provider.dart';
import '../../../domain/models/cart_item_model.dart';
import '../dialogs/product_dialog.dart';

class CartItemCard extends ConsumerWidget {
  final CartItemModel item;
  final int index;

  const CartItemCard({
    super.key,
    required this.item,
    required this.index,
  });

  /// ================= DELETE CONFIRMATION
  Future<void> confirmDelete(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Hapus Item"),
          content: const Text(
            "Apakah Anda yakin ingin menghapus item ini?",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text("Hapus"),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      ref.read(cartProvider.notifier).removeItem(index);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    /// VARIANT TEXT
    final variantText =
        item.selectedVariants.entries.map((e) => e.value).join(", ");

    /// TOPPING TEXT
    final toppingText = item.selectedToppings.join(", ");

    return Dismissible(
      key: ValueKey(index),
      direction: DismissDirection.endToStart,

      /// SWIPE DELETE
      confirmDismiss: (_) async {
        await confirmDelete(context, ref);
        return false;
      },

      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 28,
        ),
      ),

      child: InkWell(
        borderRadius: BorderRadius.circular(10),

        /// TAP UNTUK EDIT
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
          margin: const EdgeInsets.only(bottom: 10),

          child: Padding(
            padding: const EdgeInsets.all(10),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// PRODUCT NAME + DELETE
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// PRODUCT NAME
                    Expanded(
                      child: Text(
                        item.product.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    /// DELETE BUTTON
                    IconButton(
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                        size: 20,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () {
                        confirmDelete(context, ref);
                      },
                    ),
                  ],
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
                      fontStyle: FontStyle.italic,
                    ),
                  ),

                const SizedBox(height: 6),

                /// QTY + PRICE
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [

                    /// QTY CONTROL
                    Row(
                      children: [

                        /// MINUS
                        GestureDetector(
                          onTap: () {
                            if (item.quantity > 1) {
                              ref
                                  .read(cartProvider.notifier)
                                  .decreaseQty(index);
                            }
                          },
                          child: Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.grey),
                              borderRadius:
                                  BorderRadius.circular(6),
                              color: item.quantity > 1
                                  ? Colors.white
                                  : Colors.grey.shade200,
                            ),
                            child: Icon(
                              Icons.remove,
                              size: 16,
                              color: item.quantity > 1
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                          ),
                        ),

                        const SizedBox(width: 8),

                        /// QTY
                        Text(
                          item.quantity.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),

                        const SizedBox(width: 8),

                        /// PLUS
                        InkWell(
                          onTap: () {
                            ref
                                .read(cartProvider.notifier)
                                .increaseQty(index);
                          },
                          child: Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.grey),
                              borderRadius:
                                  BorderRadius.circular(6),
                            ),
                            child: const Icon(
                              Icons.add,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),

                    /// PRICE
                    Text(
                      "Rp ${item.totalPrice.toStringAsFixed(0)}",
                      style: const TextStyle(
                        color: AppColors.primaryDark,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}