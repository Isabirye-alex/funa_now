import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:go_shop/controllers/order_controller.dart';

class OrdersListPage extends StatefulWidget {
  const OrdersListPage({super.key});

  @override
  State<OrdersListPage> createState() => _OrdersListPageState();
}

class _OrdersListPageState extends State<OrdersListPage> {
  final controller = Get.put(OrderController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final loggedIn = await controller.checkUserLoggedIn(context);
      if (loggedIn) {
        controller.fetchUserOrders();
      } else {
        // Optionally navigate to login page or elsewhere

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginPromptPage()),
        );
      }
    });
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'processing':
        return Colors.blue;
      case 'shipped':
        return Colors.teal;
      case 'delivered':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('My Orders')),
      body: Obx(() {
        if (controller.order.isEmpty) {
          return const Center(child: Text('No orders found.'));
        }

        return ListView.builder(
          itemCount: controller.order.length,
          itemBuilder: (context, index) {
            final order = controller.order[index];
            final color = _getStatusColor(order.status);

            return InkWell(
              onTap: () {
                GoRouter.of(context).go('/orderdetails/${order.id}');
              },
              child: Card(
                margin: const EdgeInsets.all(8),
                elevation: 2,
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Order AIFH#${order.id}'),
                      Chip(
                        label: Text(order.status),
                        backgroundColor: color.withOpacity(0.1),
                        labelStyle: TextStyle(
                          color: color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Text('Total: UGX ${order.total_amount}'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

class LoginPromptPage extends StatelessWidget {
  const LoginPromptPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.amber.shade200, Colors.deepPurple.shade200],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.shopping_cart_checkout_rounded,
                    size: 60,
                    color: Colors.teal,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Welcome to Go Shop",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.teal[800],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "You're not logged in.\nPlease log in to view your orders and start shopping.",
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 28),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.login),
                    label: const Text(
                      "Log In & Start Shopping",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onPressed: () {
                      GoRouter.of(context).go('/loginpage');
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
