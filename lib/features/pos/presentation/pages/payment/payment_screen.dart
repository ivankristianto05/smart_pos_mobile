import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_pos_mobile/core/theme/app_colors.dart';
import 'package:smart_pos_mobile/features/pos/application/provider/cart_provider.dart';

class PaymentScreen extends ConsumerStatefulWidget {
  const PaymentScreen({super.key});

  @override
  ConsumerState<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends ConsumerState<PaymentScreen> {

  final TextEditingController cashController = TextEditingController();

  int paidAmount = 0;

  void setCash(int amount) {
    setState(() {
      paidAmount = amount;
      cashController.text = amount.toString();
    });
  }

  @override
  Widget build(BuildContext context) {

    final cartItems = ref.watch(cartProvider);

    int total = cartItems.fold(
        0, (sum, item) => sum + item.totalPrice.toInt());

    int change = paidAmount - total;

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Payment",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Center(
              child: Text(
                "Total: Rp $total",
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

          /// =========================
          /// ORDER SUMMARY
          /// =========================
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(20),

              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(color: Color(0xFFE5E5E5)),
                ),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text(
                    "Order Summary",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Expanded(
                    child: ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {

                        final item = cartItems[index];

                        return ListTile(
                          title: Text(item.product.name),
                          subtitle: Text("x${item.quantity}"),
                          trailing: Text("Rp ${item.totalPrice}"),
                        );
                      },
                    ),
                  ),

                  const Divider(),

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [

                      const Text(
                        "TOTAL",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                        "Rp $total",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          /// =========================
/// PAYMENT PANEL
/// =========================
Expanded(
  flex: 3,
  child: Padding(
    padding: const EdgeInsets.all(30),

    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// =========================
        /// TOTAL PAYMENT
        /// =========================
        const Text(
          "Total Payment",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),

        const SizedBox(height: 6),

        Text(
          "Rp $total",
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 30),

        /// =========================
        /// INPUT CASH
        /// =========================
        const Text(
          "Input Cash",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 10),

        TextField(
          controller: cashController,
          keyboardType: TextInputType.number,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),

          decoration: const InputDecoration(
            prefixText: "Rp ",
            prefixStyle: TextStyle(
              fontSize: 24,
              color: Colors.black,
            ),

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

          onChanged: (value) {
            setState(() {
              paidAmount = int.tryParse(value) ?? 0;
            });
          },
        ),

        const SizedBox(height: 25),

        /// =========================
        /// RECOMMENDED CASH
        /// =========================
        const Text(
          "Recommended Cash",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 10),

        Wrap(
          spacing: 10,
          children: [

            cashButton(50000),
            cashButton(100000),
            cashButton(200000),

            ElevatedButton(
              onPressed: () => setCash(total),
              child: const Text("Exact"),
            ),
          ],
        ),

        const SizedBox(height: 30),

        /// =========================
        /// OTHER PAYMENT
        /// =========================
        const Text(
          "Other Payment Method",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 10),

        Wrap(
          spacing: 10,
          children: [

            paymentButton(Icons.qr_code, "QRIS"),
            paymentButton(Icons.credit_card, "Card"),

          ],
        ),

        const Spacer(),

        /// =========================
        /// CHANGE DISPLAY
        /// =========================
        Text(
          change >= 0
              ? "Change: Rp $change"
              : "Cash kurang",
          style: TextStyle(
            fontSize: 20,
            color: change >= 0
                ? Colors.green
                : Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 20),

        /// =========================
        /// CONFIRM BUTTON
        /// =========================
        SizedBox(
          width: double.infinity,
          height: 60,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
            ),

            onPressed: change >= 0
                ? () {

                    ref
                        .read(cartProvider.notifier)
                        .clearCart();

                    Navigator.pop(context);

                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      const SnackBar(
                        content: Text("Payment Success"),
                      ),
                    );
                  }
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
  ),
),
        ],
      ),
    );
  }

  Widget cashButton(int amount) {

    return ElevatedButton(
      onPressed: () => setCash(amount),
      child: Text("Rp $amount"),
    );
  }

  Widget paymentButton(IconData icon, String label) {

    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon),
      label: Text(label),
    );
  }
}