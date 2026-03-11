import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_pos_mobile/features/pos/application/provider/cart_provider.dart';
import 'package:smart_pos_mobile/features/pos/application/provider/saved_order_active_provider.dart';
import 'package:smart_pos_mobile/features/pos/application/provider/saved_order_provider.dart';
import '../../../domain/models/saved_order_model.dart';

class OpenOrderDialog extends ConsumerWidget {
  const OpenOrderDialog({super.key});

  String formatTime(DateTime time) {
    return "${time.hour.toString().padLeft(2, '0')}:"
        "${time.minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final orders = ref.watch(savedOrderProvider);

    return AlertDialog(
      title: const Text("Open Order"),
      content: SizedBox(
        width: 420,
        child: orders.isEmpty
            ? const Padding(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: Text("Tidak ada order tersimpan"),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [

                          /// ORDER NAME
                          Text(
                            order.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),

                          const SizedBox(height: 4),

                          /// ITEM COUNT
                          Text(
                            "${order.items.length} items • ${formatTime(order.createdAt)}",
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),

                          const SizedBox(height: 10),

                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.end,
                            children: [

                              /// DELETE BUTTON
                              TextButton.icon(
                                icon: const Icon(
                                  Icons.delete_outline,
                                  size: 18,
                                ),
                                label: const Text("DELETE"),
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.red,
                                ),
                                onPressed: () {
                                  _confirmDelete(
                                    context,
                                    ref,
                                    order.id,
                                  );
                                },
                              ),

                              const SizedBox(width: 8),

                              /// OPEN BUTTON
                              ElevatedButton.icon(
                                icon: const Icon(
                                  Icons.lock_open,
                                  size: 18,
                                ),
                                label: const Text("OPEN"),
                                onPressed: () {

                                  ref
                                      .read(cartProvider.notifier)
                                      .setCart(order.items);

                                  ref
                                      .read(
                                          activeSavedOrderIdProvider
                                              .notifier)
                                      .state = order.id;

                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }

  /// =============================
  /// DELETE CONFIRMATION
  /// =============================
  void _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    String id,
  ) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Hapus Order"),
        content: const Text(
          "Apakah Anda yakin ingin menghapus order ini?",
        ),
        actions: [

          TextButton(
            child: const Text("Batal"),
            onPressed: () => Navigator.pop(context),
          ),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text("Hapus"),
            onPressed: () {

              ref
                  .read(savedOrderProvider.notifier)
                  .deleteOrder(id);

              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}