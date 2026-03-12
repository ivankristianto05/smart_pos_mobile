import 'package:flutter/material.dart';
import 'package:smart_pos_mobile/core/utils/currency_formatter.dart';

class OrderSummaryPanel extends StatelessWidget {
  final List cartItems;
  final int total;

  const OrderSummaryPanel({
    super.key,
    required this.cartItems,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
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
                  trailing: Text(
                    "Rp ${CurrencyFormatter.rupiah(item.totalPrice.toInt())}",
                  ),
                );
              },
            ),
          ),

          const Divider(),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              const Text(
                "TOTAL",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                "Rp ${CurrencyFormatter.rupiah(total)}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )

        ],
      ),
    );
  }
}