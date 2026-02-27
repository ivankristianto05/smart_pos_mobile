import 'package:flutter/material.dart';
import '../widget/dashboard_card.dart';
import 'package:go_router/go_router.dart';
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f6fa),

      appBar: AppBar(
        title: const Text("Dashboard"),
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),
        child: LayoutBuilder(
          builder: (context, constraints) {

            /// ✅ RESPONSIVE GRID
            int crossAxisCount = 1;

            if (constraints.maxWidth > 1200) {
              crossAxisCount = 4;
            } else if (constraints.maxWidth > 800) {
              crossAxisCount = 3;
            } else if (constraints.maxWidth > 600) {
              crossAxisCount = 2;
            }

            return Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [

                /// ================= HEADER =================
                const Text(
                  "Welcome Back 👋",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  "Here is today's POS overview",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),

                const SizedBox(height: 24),

                /// ================= GRID =================
                Expanded(
                  child: GridView.count(
  crossAxisCount: crossAxisCount,
  crossAxisSpacing: 20,
  mainAxisSpacing: 20,
  childAspectRatio: 1.8,
  children: [

    DashboardCard(
      title: "Today's Sales",
      value: "Rp 2.450.000",
      icon: Icons.point_of_sale,
      color: Colors.blue,
    ),

    DashboardCard(
      title: "Transactions",
      value: "128",
      icon: Icons.receipt_long,
      color: Colors.green,
    ),

    DashboardCard(
      title: "Products",
      value: "54",
      icon: Icons.inventory,
      color: Colors.orange,
    ),

    DashboardCard(
      title: "Customers",
      value: "32",
      icon: Icons.people,
      color: Colors.purple,
    ),

    DashboardCard(
  title: "Point of Sale",
  value: "",
  icon: Icons.point_of_sale,
  color: Colors.indigo,
  onTap: () {
    context.push('/pos');
  },
),
  ],
),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}