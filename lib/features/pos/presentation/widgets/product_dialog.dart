import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_pos_mobile/features/pos/domain/models/cart_item_model.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/models/product_model.dart';
import '../../application/provider/cart_provider.dart';

class ProductDialog extends ConsumerStatefulWidget {

  final ProductModel product;
    final CartItemModel? existingItem;
  final int? cartIndex;

  const ProductDialog({
    super.key,
    required this.product,
    this.existingItem,
    this.cartIndex,
  });

  @override
  ConsumerState<ProductDialog> createState() => _ProductDialogState();
}

class _ProductDialogState extends ConsumerState<ProductDialog> {

  int qty = 1;

  Map<String, String> selectedVariants = {};
  List<String> selectedToppings = [];

  final TextEditingController noteController = TextEditingController();

  @override
  void initState() {
  super.initState();

  if (widget.existingItem != null) {

    qty = widget.existingItem!.quantity;

    selectedVariants =
        Map<String, String>.from(widget.existingItem!.selectedVariants);

    selectedToppings =
        List<String>.from(widget.existingItem!.selectedToppings);

    noteController.text = widget.existingItem!.note;

  } else {

    widget.product.variants.forEach((key, value) {
      selectedVariants[key] = value.keys.first;
    });

  }
}

  double get totalPrice {

    double price = widget.product.basePrice;

    /// variant price
    selectedVariants.forEach((group, option) {
      price += widget.product.variants[group]![option]!;
    });

    /// topping price
    for (var topping in selectedToppings) {
      price += widget.product.toppings[topping]!;
    }

    return price * qty;
  }

  @override
  Widget build(BuildContext context) {

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),

      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.4,

        child: Padding(
          padding: const EdgeInsets.all(24),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              /// TITLE
              Text(
                widget.product.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              /// VARIANTS
              ...widget.product.variants.entries.map((entry) {

                final group = entry.key;
                final options = entry.value;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      group,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Wrap(
                      spacing: 10,
                      children: options.keys.map((option) {

                        final selected =
                            selectedVariants[group] == option;

                        return ChoiceChip(
                          label: Text(option),
                          selected: selected,

                          selectedColor: AppColors.primary,

                          labelStyle: TextStyle(
                            color: selected
                                ? Colors.white
                                : Colors.black,
                          ),

                          onSelected: (_) {
                            setState(() {
                              selectedVariants[group] = option;
                            });
                          },
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 16),
                  ],
                );
              }),

              /// TOPPINGS
              if (widget.product.toppings.isNotEmpty) ...[

                const Text(
                  "Toppings",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Wrap(
                  spacing: 10,
                  children: widget.product.toppings.keys.map((topping) {

                    final selected =
                        selectedToppings.contains(topping);

                    return FilterChip(
                      label: Text(topping),
                      selected: selected,

                      selectedColor: AppColors.primary,

                      labelStyle: TextStyle(
                        color: selected
                            ? Colors.white
                            : Colors.black,
                      ),

                      onSelected: (value) {

                        setState(() {

                          if (value) {
                            selectedToppings.add(topping);
                          } else {
                            selectedToppings.remove(topping);
                          }

                        });

                      },
                    );

                  }).toList(),
                ),

                const SizedBox(height: 16),
              ],

              /// QUANTITY
              Row(
                children: [

                  const Text(
                    "Quantity",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const Spacer(),

                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      if (qty > 1) {
                        setState(() {
                          qty--;
                        });
                      }
                    },
                  ),

                  Text(
                    qty.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        qty++;
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 12),

              /// NOTES
              TextField(
                controller: noteController,
                maxLines: 2,

                decoration: const InputDecoration(
                  labelText: "Notes",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              /// TOTAL PRICE
              Text(
                "Total : Rp ${totalPrice.toStringAsFixed(0)}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              /// ADD TO CART
              SizedBox(
                width: double.infinity,

                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),

                 onPressed: () {

  final unitPrice = totalPrice / qty;

  final newItem = CartItemModel(
    product: widget.product,
    selectedVariants: selectedVariants,
    selectedToppings: selectedToppings,
    quantity: qty,
    note: noteController.text,
    unitPrice: unitPrice,
  );

  /// EDIT CART
  if (widget.cartIndex != null) {

    ref
        .read(cartProvider.notifier)
        .updateItem(widget.cartIndex!, newItem);

  } else {

    /// ADD CART
    ref
        .read(cartProvider.notifier)
        .addItem(newItem);

  }

  Navigator.pop(context);
},

                  child: const Text(
                    "ADD TO CART",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}