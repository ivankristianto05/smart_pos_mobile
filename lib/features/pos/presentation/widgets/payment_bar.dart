import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_pos_mobile/features/pos/application/provider/cart_provider.dart';
import '../../../../core/theme/app_colors.dart';

class PaymentBar extends ConsumerWidget {
  const PaymentBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final cartItems = ref.watch(cartProvider);
    final bool hasOrder = cartItems.isNotEmpty;

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
                  hasOrder
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
                if (hasOrder) {
                  debugPrint("Saving Order...");
                } else {
                  debugPrint("Opening Order...");
                }
              },
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