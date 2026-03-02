import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/order_type.dart';

final orderTypeProvider =
    StateProvider<OrderType>((ref) {
  return OrderType.dineIn;
});