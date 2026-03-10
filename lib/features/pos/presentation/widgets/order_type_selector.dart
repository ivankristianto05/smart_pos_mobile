import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../application/provider/order_type_provider.dart';
import '../../domain/models/order_type.dart';

class OrderTypeSelector extends ConsumerWidget {
  const OrderTypeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedType = ref.watch(orderTypeProvider);

    return Padding(
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
    );
  }
}