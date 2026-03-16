import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_pos_mobile/features/pos/application/provider/customer_name_provider.dart';
import 'package:smart_pos_mobile/features/pos/application/provider/table_number_provider.dart';
import 'package:smart_pos_mobile/features/pos/presentation/widgets/dialogs/table_selector_dialog.dart';
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

  int tableNumber = 1;

  @override
  Widget build(BuildContext context) {

  final selectedType = ref.watch(orderTypeProvider);
  final customerName = ref.watch(customerNameProvider);
  if(customerController.text != customerName){
    customerController.text = customerName;
  }
  final isDineIn = selectedType == OrderType.dineIn;

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
  onTap: isDineIn
      ? () async {

          final result = await showDialog<int>(
            context: context,
            builder: (context) {
              return TableSelectorDialog(
                selectedTable: tableNumber,
                totalTables: 50,
              );
            },
          );

          if (result != null) {
            setState(() {
              tableNumber = result;
            });
            ref.read(tableNumberProvider.notifier).state = result;
          }
        }
      : null,

  child: Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 14,
      vertical: 10,
    ),

    decoration: BoxDecoration(
      color: isDineIn
          ? Colors.grey.shade100
          : Colors.grey.shade200,

      borderRadius: BorderRadius.circular(10),

      border: Border.all(
        color: isDineIn
            ? Colors.grey.shade300
            : Colors.grey.shade300,
      ),
    ),

    child: Text(
      "Table $tableNumber",
      style: TextStyle(
        fontWeight: FontWeight.w600,
        color: isDineIn
            ? Colors.black
            : Colors.grey,
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
                onChanged: (value) {
                  ref.read(customerNameProvider.notifier).state = value;
                },
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