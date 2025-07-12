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
      appBar: AppBar(centerTitle: true, title: const Text('Order Details')),
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
            // ✅ Order Summary Card
            Card(
              margin: const EdgeInsets.all(12),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order #${order.id}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          order.createdAt != null
                              ? 'Placed on ${DateFormat.yMMMd().format(order.createdAt!)}'
                              : 'Placed on -',
                          style: const TextStyle(color: Colors.grey),
                        ),
                        Chip(
                          label: Text(order.status),
                          backgroundColor: Colors.blue.shade50,
                          labelStyle: const TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                    const Divider(height: 24),
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 20),
                        const SizedBox(width: 8),
                        Expanded(child: Text(order.shipping_address)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.payment, size: 20),
                        const SizedBox(width: 8),
                        Text(order.payment_method),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.attach_money, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'UGX ${order.total_amount}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Text(
                'Items in this order',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),

            // ✅ Order Items
            Expanded(
              child: Obx(() {
                final items = controller.orderItem;

                if (items.isEmpty) {
                  return const Center(child: Text('No items in this order.'));
                }

                return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    final double subtotal =
                        double.tryParse(item.productPrice)! * item.quantity;

                    return ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          item.productImage,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(item.productName),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text('Qty: ${item.quantity}'),
                          Text('Price: UGX ${item.productPrice}'),
                          Text(
                            'Subtotal: UGX ${subtotal.toStringAsFixed(0)}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
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
