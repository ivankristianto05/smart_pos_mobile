import 'package:flutter/material.dart';
import 'package:smart_pos_mobile/core/theme/app_colors.dart';
import 'package:smart_pos_mobile/core/utils/currency_formatter.dart';

class PaymentInfoPanel extends StatefulWidget {

  final int total;
  final int change;
  final TextEditingController cashController;
  final VoidCallback onConfirm;

  const PaymentInfoPanel({
    super.key,
    required this.total,
    required this.change,
    required this.cashController,
    required this.onConfirm,
  });

  @override
  State<PaymentInfoPanel> createState() => _PaymentInfoPanelState();
}

class _PaymentInfoPanelState extends State<PaymentInfoPanel> {

  String? selectedMethod;

  bool get isNonCash =>
      selectedMethod != null &&
      selectedMethod != "Cash";

  bool get canConfirm =>
      widget.change >= 0 || isNonCash;

  void selectMethod(String method) {
    setState(() {
      selectedMethod = method;
    });
  }

  Widget paymentButton(String label, IconData icon) {

    final bool selected = selectedMethod == label;

    return ElevatedButton.icon(

      onPressed: () => selectMethod(label),

      icon: Icon(icon, size: 18),

      label: Text(label),

      style: ElevatedButton.styleFrom(
        backgroundColor:
            selected ? AppColors.primary : Colors.grey.shade200,
        foregroundColor:
            selected ? Colors.white : Colors.black,
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 12,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(30),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// TOTAL PAYMENT
          const Text(
            "Total Payment",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            "Rp ${CurrencyFormatter.rupiah(widget.total)}",
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 30),

          /// CASH INPUT
          const Text(
            "Input Cash",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextField(
            controller: widget.cashController,
            readOnly: true,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
            decoration: const InputDecoration(
              prefixText: "Rp ",
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 2,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 2,
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),

          /// OTHER PAYMENT METHOD
          const Text(
            "Other Payment Method",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [

              paymentButton("QRIS", Icons.qr_code),
              paymentButton("Transfer", Icons.account_balance),

              paymentButton("ShopeeFood", Icons.shopping_bag),
              paymentButton("GoFood", Icons.delivery_dining),
              paymentButton("GrabFood", Icons.delivery_dining),

            ],
          ),

          const Spacer(),

          /// CHANGE
          Text(
            widget.change >= 0
                ? "Change : Rp ${CurrencyFormatter.rupiah(widget.change)}"
                : "Cash kurang",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: widget.change >= 0
                  ? Colors.green
                  : Colors.red,
            ),
          ),

          const SizedBox(height: 20),

          /// CONFIRM BUTTON
          SizedBox(
            width: double.infinity,
            height: 60,

            child: ElevatedButton(

              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
              ),

              onPressed: canConfirm
                  ? widget.onConfirm
                  : null,

              child: const Text(
                "CONFIRM PAYMENT",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )

        ],
      ),
    );
  }
}