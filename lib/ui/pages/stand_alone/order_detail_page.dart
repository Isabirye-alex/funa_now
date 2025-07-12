import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_shop/controllers/order_controller.dart';
import 'package:intl/intl.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({super.key, required this.orderId});

  final String orderId;

  @override
  Widget build(BuildContext context) {
    final OrderController controller = Get.find();
    controller.getOrderItems(int.parse(orderId));

    return Scaffold(
      appBar: AppBar(title: const Text('Order Details')),
      body: Obx(() {
        final order = controller.order.firstWhereOrNull(
          (o) => o.id == int.tryParse(orderId),
        );

        if (order == null) {
          return const Center(child: Text('Order not found.'));
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Order Summary
            ListTile(
              title: Text('Order #${order.id}'),
              subtitle: Text(
                'Placed on ${DateFormat.yMMMd().format(order.createdAt!)}',
              ),
              trailing: Chip(label: Text(order.status)),
            ),
            ListTile(
              title: const Text('Shipping Address'),
              subtitle: Text(order.shipping_address),
            ),
            ListTile(
              title: const Text('Payment Method'),
              subtitle: Text(order.payment_method),
            ),
            ListTile(
              title: const Text('Total Amount'),
              subtitle: Text('UGX ${order.total_amount}'),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Items',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),

            // ✅ Order Items List
            Expanded(
              child: Obx(() {
                final items = controller.orderItem;

                if (items.isEmpty) {
                  return const Center(child: Text('No items in this order.'));
                }

                return ListView.separated(
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    final double subtotal =
                        double.tryParse(item.productPrice)! * item.quantity;

                    return ListTile(
                      leading: Image.network(
                        item.productImage,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(item.productName),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Price: UGX ${item.productPrice}'),
                          Text('Quantity: ${item.quantity}'),
                          Text('Subtotal: UGX ${subtotal.toStringAsFixed(2)}'),
                        ],
                      ),
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
