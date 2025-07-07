import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_shop/controllers/cart_controller.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Obx(() {
        if (cartController.cartItem.isEmpty) {
          return const Center(
            child: Text('Your cart is empty!', style: TextStyle(fontSize: 18)),
          );
        }

        return Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: cartController.cartItem.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final item = cartController.cartItem[index];

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.deepPurple.shade200,
                      child: Text(
                        '${item.quantity}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text('Product ID: ${item.productId}'),
                    subtitle: Text('Cart ID: ${item.cartId}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {},
                      // onPressed: () => cartController.removeItem(item.id),
                    ),
                  );
                },
              ),
            ),

            // Total Price and Checkout
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Obx(() {
                    final total = cartController.cartItem.fold<double>(
                      0.0,
                      (sum, item) => sum + (item.quantity * item.price!),
                    );
                    return Text(
                      'Total: UGX ${total.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Get.snackbar('Checkout', 'Proceeding to checkout...');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Proceed to Checkout'),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
