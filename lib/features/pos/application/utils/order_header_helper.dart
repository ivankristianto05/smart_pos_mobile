import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/order_type_provider.dart';
import '../provider/table_number_provider.dart';
import '../provider/customer_name_provider.dart';

void loadOrderHeader(WidgetRef ref, order) {
  ref.read(orderTypeProvider.notifier).state = order.orderType;
  ref.read(tableNumberProvider.notifier).state = order.tableNumber;
  ref.read(customerNameProvider.notifier).state = order.customerName;
}