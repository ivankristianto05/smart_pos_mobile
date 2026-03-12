import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../application/provider/order_type_provider.dart';
import '../../../domain/models/order_type.dart';

class OrderTypeSelector extends ConsumerStatefulWidget {
  const OrderTypeSelector({super.key});

  @override
  ConsumerState<OrderTypeSelector> createState() => _OrderTypeSelectorState();
}

class _OrderTypeSelectorState extends ConsumerState<OrderTypeSelector> {

  final TextEditingController customerController = TextEditingController();

  int tableNumber = 12;

  @override
  Widget build(BuildContext context) {

    final selectedType = ref.watch(orderTypeProvider);

    return Padding(
      padding: const EdgeInsets.all(12),

      child: Row(
        children: [

          /// ORDER TYPE
          Container(
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

                items: OrderType.values.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type.label),
                  );
                }).toList(),

                onChanged: (value) {
                  ref.read(orderTypeProvider.notifier).state = value!;
                },
              ),
            ),
          ),

          const SizedBox(width: 10),

          /// TABLE SELECTOR
          InkWell(
            onTap: () async {

              final result = await showDialog<int>(
                context: context,
                builder: (context) {

                  final controller = TextEditingController(
                    text: tableNumber.toString(),
                  );

                  return AlertDialog(

                    title: const Text("Table Number"),

                    content: TextField(
                      controller: controller,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: "Enter table number",
                      ),
                    ),

                    actions: [

                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      ),

                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(
                            context,
                            int.tryParse(controller.text),
                          );
                        },
                        child: const Text("OK"),
                      ),

                    ],
                  );
                },
              );

              if (result != null) {
                setState(() {
                  tableNumber = result;
                });
              }
            },

            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 10,
              ),

              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey.shade300,
                ),
              ),

              child: Text(
                "Table $tableNumber",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          const SizedBox(width: 10),

          /// CUSTOMER NAME
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),

              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey.shade300,
                ),
              ),

              child: TextField(
                controller: customerController,
                decoration: const InputDecoration(
                  hintText: "Customer name",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}