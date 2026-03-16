import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_pos_mobile/core/theme/app_colors.dart';
import 'package:smart_pos_mobile/features/pos/application/provider/saved_order_provider.dart';

class TableSelectorDialog extends ConsumerStatefulWidget {
  final int selectedTable;
  final int totalTables;

  const TableSelectorDialog({
    super.key,
    required this.selectedTable,
    this.totalTables = 50,
  });

  @override
  ConsumerState<TableSelectorDialog> createState() => _TableSelectorDialogState();
}

class _TableSelectorDialogState extends ConsumerState<TableSelectorDialog> {

  late int selected;

  @override
  void initState() {
    super.initState();
    selected = widget.selectedTable;
  }

  @override
  Widget build(BuildContext context) {

    /// ambil semua saved order
    final orders = ref.watch(savedOrderProvider);

    /// ambil semua nomor meja yang sedang dipakai
    final occupiedTables = orders
        .where((o) => o.tableNumber != null)
        .map((o) => o.tableNumber)
        .toSet();

    return Dialog(
      child: Container(
        width: 400,
        height: 450,
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Select Table",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            /// GRID TABLE
            Expanded(
              child: GridView.builder(
                itemCount: widget.totalTables,

                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),

                itemBuilder: (context, index) {

                  final tableNumber = index + 1;

                  final isSelected = tableNumber == selected;
                  final isOccupied = occupiedTables.contains(tableNumber);

                  /// warna berdasarkan status meja
                  Color backgroundColor;
                  Color textColor;

                  if (isSelected) {
                    backgroundColor = Colors.blue;
                    textColor = Colors.white;
                  } else if (isOccupied) {
                    backgroundColor = Colors.green;
                    textColor = Colors.white;
                  } else {
                    backgroundColor = Colors.white;
                    textColor = Colors.black;
                  }

                  return InkWell(
                    onTap: () {
                      setState(() {
                        selected = tableNumber;
                      });
                    },

                    child: Container(
                      alignment: Alignment.center,

                      decoration: BoxDecoration(
                        color: backgroundColor,

                        borderRadius: BorderRadius.circular(10),

                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                      ),

                      child: Text(
                        tableNumber.toString(),

                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 15),

            /// BUTTONS
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),

                const SizedBox(width: 10),

                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, selected);
                  },
                  child: const Text("Select"),
                ),

              ],
            )
          ],
        ),
      ),
    );
  }
}