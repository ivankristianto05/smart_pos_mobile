import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_pos_mobile/features/pos/application/provider/cart_provider.dart';
import 'package:smart_pos_mobile/features/pos/application/provider/saved_order_active_provider.dart';
import '../../../../core/theme/app_colors.dart';
import 'dialogs/save_order_dialog.dart';
import 'dialogs/open_order_dialog.dart';
import '../../application/provider/saved_order_provider.dart';

class PaymentBar extends ConsumerWidget {
  const PaymentBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final cartItems = ref.watch(cartProvider);
    final bool hasOrder = cartItems.isNotEmpty;
    final activeOrderId = ref.watch(activeSavedOrderIdProvider);

    return Container(
      height: 85,
      padding: const EdgeInsets.all(12),

      /// =============================
      /// PAYMENT BAR BACKGROUND
      /// =============================
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.dark,
            Color(0xFF2A2A40),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),

      child: Row(
        children: [

          /// =============================
          /// OPEN / SAVE ORDER BUTTON
          /// =============================
          Expanded(
            child: ElevatedButton.icon(
              icon: Icon(
                hasOrder ? Icons.save : Icons.lock_open,
                size: 20,
              ),

              label: FittedBox(
                child: Text(
                  activeOrderId != null
                  ?"UPDATE ORDER"
                  :hasOrder
                      ? "SAVE ORDER"
                      : "OPEN ORDER",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              style: ElevatedButton.styleFrom(
                backgroundColor: hasOrder
                    ? AppColors.primary
                    : Colors.grey.shade600,

                foregroundColor: Colors.white,

                elevation: 4,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),

              onPressed: () {

  final savedOrders = ref.read(savedOrderProvider);
  final activeOrderId = ref.read(activeSavedOrderIdProvider);

  if (hasOrder) {

    /// ===============================
    /// UPDATE ORDER (jika sudah ada)
    /// ===============================
    if (activeOrderId != null) {

  /// UPDATE ORDER
  ref.read(savedOrderProvider.notifier)
      .updateOrder(activeOrderId, cartItems);

  /// KOSONGKAN CART
  ref.read(cartProvider.notifier).clearCart();

  /// RESET ACTIVE ORDER
  ref.read(activeSavedOrderIdProvider.notifier).state = null;

  /// FEEDBACK USER
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("Order berhasil diperbarui"),
      duration: Duration(seconds: 2),
    ),
  );

  return;
}

    /// ===============================
    /// SAVE ORDER BARU
    /// ===============================
    showDialog(
      context: context,
      builder: (_) => SaveOrderDialog(
        onSave: (name) {

          ref.read(savedOrderProvider.notifier)
              .saveOrder(name, cartItems);

          ref.read(cartProvider.notifier).clearCart();
        },
      ),
    );

  } else {

    /// ===============================
    /// OPEN ORDER
    /// ===============================
    showDialog(
  context: context,
  builder: (_) => const OpenOrderDialog(),
);
  }
}
            ),
          ),

          const SizedBox(width: 12),

          /// =============================
          /// PAY BUTTON (PRIMARY ACTION)
          /// =============================
          Expanded(
  flex: 1,
  child: ElevatedButton.icon(

    /// ✅ FORCE ICON COLOR
    icon: const IconTheme(
      data: IconThemeData(
        color: Colors.white,
      ),
      child: Icon(Icons.payment),
    ),

    label: const FittedBox(
      child: Text(
        "PAY",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    ),

    style: ElevatedButton.styleFrom(
      backgroundColor: hasOrder
          ? AppColors.primaryDark
          : Colors.grey.shade700,

      foregroundColor: Colors.white,

      elevation: hasOrder ? 8 : 0,
      shadowColor: Colors.black54,

      side: BorderSide(
        color: Colors.white.withOpacity(0.2),
      ),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),

    onPressed: hasOrder
        ? () {
            debugPrint("Processing Payment...");
          }
        : null,
  ),
),
        ],
      ),
    );
  }
}