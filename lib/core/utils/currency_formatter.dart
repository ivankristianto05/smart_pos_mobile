import 'package:intl/intl.dart';

class CurrencyFormatter {

  static final NumberFormat _formatter =
      NumberFormat("#,###", "id_ID");

  static String rupiah(int amount) {
    return _formatter.format(amount);
  }
}