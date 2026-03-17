import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_pos_mobile/core/theme/app_colors.dart';
import 'package:smart_pos_mobile/features/pos/application/provider/cart_provider.dart';
import 'package:smart_pos_mobile/core/utils/currency_formatter.dart';
import 'package:smart_pos_mobile/features/pos/application/provider/customer_name_provider.dart';
import 'package:smart_pos_mobile/features/pos/application/provider/table_number_provider.dart';
import '../../widgets/payment/order_summary_panel.dart';
import '../../widgets/payment/payment_info_panel.dart';
import '../../widgets/payment/pos_numpad_panel.dart';
import 'package:smart_pos_mobile/features/pos/domain/models/transaction_model.dart';
import 'package:smart_pos_mobile/features/pos/domain/models/order_type.dart';
class PaymentScreen extends ConsumerStatefulWidget {
  final TransactionData transaction;
  const PaymentScreen({super.key,required this.transaction,});

  @override
  ConsumerState<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends ConsumerState<PaymentScreen> {

  final TextEditingController cashController = TextEditingController();

  int paidAmount = 0;

  void updateCash(int amount){
    setState(() {
      paidAmount = amount;
      cashController.text = CurrencyFormatter.rupiah(amount);
    });
  }

  void appendDigit(String digit){

    String current = paidAmount.toString();
    String newValue = current == "0" ? digit : current + digit;

    int amount = int.tryParse(newValue) ?? 0;

    updateCash(amount);
  }

  void backspace(){

    String current = paidAmount.toString();

    if(current.length <= 1){
      updateCash(0);
      return;
    }

    String newValue = current.substring(0,current.length - 1);

    updateCash(int.parse(newValue));
  }

  @override
  Widget build(BuildContext context) {

    final cartItems = widget.transaction.items;

    int total = widget.transaction.total;

    int change = paidAmount - total;

    return Scaffold(

      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),

        title: const Text(
          "Payment",
          style: TextStyle(color: Colors.black),
        ),

        actions: [

          Padding(
            padding: const EdgeInsets.only(right:20),

            child: Center(
              child: Text(
                "Total: Rp ${CurrencyFormatter.rupiah(total)}",
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          )

        ],
      ),

body: Row(
  children: [

    Expanded(
      flex: 2,
      child: OrderSummaryPanel(
        cartItems: cartItems,
        total: total,
        orderType: widget.transaction.orderType.label,
        tableNumber: widget.transaction.tableNumber,
        customerName: widget.transaction.customerName,
      ),
    ),

    Expanded(
      flex: 4,
      child: PaymentInfoPanel(
        total: total,
        change: change,
        cashController: cashController,
        onConfirm: () {

  /// clear cart
  ref.read(cartProvider.notifier).clearCart();

  /// reset input
  ref.read(customerNameProvider.notifier).state = "";
  ref.read(tableNumberProvider.notifier).state = null;

  Navigator.pop(context);

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text("Payment Success")),
  );
},
      ),
    ),

    Expanded(
      flex: 2,
      child: PosNumpadPanel(
        onDigit: appendDigit,
        onBackspace: backspace,
        onExact: () => updateCash(total),
      ),
    )

  ],
)

    );
  }

  Widget numpadButton(String number){

    return ElevatedButton(
      onPressed: ()=> appendDigit(number),

      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey.shade200
      ),

      child: Text(
        number,
        style: const TextStyle(
          fontSize:22,
          color: Colors.black,
          fontWeight: FontWeight.bold
        ),
      ),
    );

  }

}