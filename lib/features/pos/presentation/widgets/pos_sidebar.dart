import 'package:flutter/material.dart';

class PosSidebar extends StatelessWidget {
  const PosSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      child: Column(
        children: const [
          SizedBox(height: 40),
          Icon(Icons.point_of_sale, color: Colors.white),
          SizedBox(height: 30),
          Icon(Icons.history, color: Colors.white54),
          SizedBox(height: 30),
          Icon(Icons.inventory, color: Colors.white54),
        ],
      ),
    );
  }
}