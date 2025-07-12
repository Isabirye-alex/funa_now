// orders_list_page.dart
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
    controller.fetchUserOrders();
  }

  @override
  Widget build(BuildContext context) {
    // Fetch orders on build

    return Scaffold(
      appBar: AppBar(title: const Text('My Orders')),
      body: Obx(() {
        if (controller.order.isEmpty) {
          return const Center(child: Text('No orders found.'));
        }

        return InkWell(
          onTap: () {},
          child: ListView.builder(
            itemCount: controller.order.length,
            itemBuilder: (context, index) {
              final order = controller.order[index];
              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text('Order AIFH#${order.id} - ${order.status}'),
                  subtitle: Text('Total: UGX ${order.total_amount}'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    GoRouter.of(context).go('/orderdetails/${order.id}');
                  },
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
