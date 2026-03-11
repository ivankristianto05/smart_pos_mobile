import 'package:flutter/material.dart';

class SaveOrderDialog extends StatefulWidget {
  final Function(String name) onSave;

  const SaveOrderDialog({super.key, required this.onSave});

  @override
  State<SaveOrderDialog> createState() => _SaveOrderDialogState();
}

class _SaveOrderDialogState extends State<SaveOrderDialog> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Save Order"),
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(
          hintText: "Nama Order (ex: Table 5)",
        ),
      ),
      actions: [
        TextButton(
          child: const Text("Cancel"),
          onPressed: () => Navigator.pop(context),
        ),
        ElevatedButton(
          child: const Text("Save"),
          onPressed: () {
            widget.onSave(controller.text);
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}