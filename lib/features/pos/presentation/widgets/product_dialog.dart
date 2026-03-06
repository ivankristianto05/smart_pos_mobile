import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/models/product_model.dart';

class ProductDialog extends StatefulWidget {
  final ProductModel product;

  const ProductDialog({
    super.key,
    required this.product,
  });

  @override
  State<ProductDialog> createState() => _ProductDialogState();
}

class _ProductDialogState extends State<ProductDialog> {

  int quantity = 1;

  final TextEditingController noteController = TextEditingController();

  /// MULTI VARIANT
  final Map<String, List<String>> variantGroups = {
    "Size": ["Regular", "Large", "Extra"],
    "Sugar": ["Normal", "Less Sugar", "No Sugar"],
  };

  Map<String, String> selectedVariants = {};

  @override
  void initState() {
    super.initState();

    variantGroups.forEach((key, value) {
      selectedVariants[key] = value.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),

      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.35,

        child: Padding(
          padding: const EdgeInsets.all(24),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              /// PRODUCT NAME
              Text(
                widget.product.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              /// VARIANTS
              ...variantGroups.entries.map((entry) {

                String groupName = entry.key;
                List<String> options = entry.value;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),

                  child: DropdownButtonFormField<String>(
                    value: selectedVariants[groupName],

                    decoration: InputDecoration(
                      labelText: groupName,
                      border: const OutlineInputBorder(),
                    ),

                    items: options.map((option) {
                      return DropdownMenuItem(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),

                    onChanged: (value) {
                      setState(() {
                        selectedVariants[groupName] = value!;
                      });
                    },
                  ),
                );
              }),

              const SizedBox(height: 10),

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
                      if (quantity > 1) {
                        setState(() {
                          quantity--;
                        });
                      }
                    },
                  ),

                  Text(
                    quantity.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        quantity++;
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 16),

              /// NOTE
              TextField(
                controller: noteController,
                maxLines: 2,

                decoration: const InputDecoration(
                  labelText: "Notes",
                  hintText: "Contoh: tanpa gula, extra es",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              /// ADD BUTTON
              SizedBox(
                width: double.infinity,

                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),

                  onPressed: () {

                    debugPrint("Product: ${widget.product.name}");
                    debugPrint("Variants: $selectedVariants");
                    debugPrint("Qty: $quantity");
                    debugPrint("Note: ${noteController.text}");

                    Navigator.pop(context);
                  },

                  child: const Text(
                    "Add To Cart",
                    style: TextStyle(
                      fontSize: 16,
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