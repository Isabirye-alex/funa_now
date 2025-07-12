// order_details_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_shop/controllers/order_controller.dart';

class OrderDetailsPage extends StatelessWidget {
  final int orderId;

  OrderDetailsPage({super.key, required this.orderId});

  final OrderController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    controller.getOrderItems(orderId);

    return Scaffold(
      appBar: AppBar(title: const Text('Order Details')),
      body: Obx(() {
        final order = controller.order.firstWhereOrNull((o) => o.id == orderId);

        if (order == null) {
          return const Center(child: Text('Order not found.'));
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text('Order #${order.id}'),
              // subtitle: Text(order.created_at ?? ''),
              trailing: Chip(label: Text(order.status ?? '')),
            ),
            ListTile(
              title: const Text('Shipping Address'),
              subtitle: Text(order.shipping_address ?? ''),
            ),
            ListTile(
              title: const Text('Payment Method'),
              subtitle: Text(order.payment_method ?? ''),
            ),
            ListTile(
              title: const Text('Total Amount'),
              subtitle: Text('UGX ${order.total_amount}'),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Items',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            // Replace with a reactive list of order items
            Expanded(
              child: Obx(() {
                final items = controller.it;

                if (items.isEmpty) return const Center(child: Text('No items'));

                return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return ListTile(
                      leading: Image.network(item.product_image, width: 40),
                      title: Text(item.product_name),
                      subtitle: Text('Qty: ${item.quantity}'),
                      trailing: Text('UGX ${item.price}'),
                    );
                  },
                );
              }),
            ),
          ],
        );
      }),
    );
  }
}
