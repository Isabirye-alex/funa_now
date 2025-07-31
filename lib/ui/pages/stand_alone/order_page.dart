// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_shop/controllers/address_controller.dart';
import 'package:go_shop/controllers/cart_controller.dart';
import 'package:go_shop/controllers/payment_controller.dart';
import 'package:go_shop/ui/widgets/bottom-panel.dart';
import 'package:go_shop/ui/widgets/cart-items-builder.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final cartController = Get.put(CartController());
  final paymentController = Get.put(PaymentController());
  final addressController = Get.put(AddressController());

  @override
  void initState() {
    super.initState();
    paymentController.fetchPaymentMethods();
    addressController.fetchUserAddresses(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Confirm Order'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Obx(() {
        if (cartController.cartItem.isEmpty) {
          return const Center(
            child: Text('Your cart is empty!', style: TextStyle(fontSize: 18)),
          );
        }

        return ListView(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
          children: [
            // Cart Items
            ...cartController.cartItem.map((item) {
              final total = item.price * item.quantity;
              return CartItemsBuilder(
                item: item,
                total: total,
                cartController: cartController,
              );
            }),

            const SizedBox(height: 20),

            // Payment Method Dropdown
            const Text(
              "Payment Method",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Obx(() {
              if (paymentController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (paymentController.error.isNotEmpty) {
                return Text(paymentController.error.value);
              }

              return DropdownButtonFormField<String>(
                value: paymentController.selectedMethod.value,
                items: paymentController.paymentMethods
                    .map(
                      (method) =>
                          DropdownMenuItem(value: method, child: Text(method)),
                    )
                    .toList(),
                onChanged: (value) {
                  paymentController.selectedMethod.value = value!;
                },
                decoration: const InputDecoration(border: OutlineInputBorder()),
              );
            }),

            const SizedBox(height: 20),

            // Shipping Address Dropdown
            const Text(
              "Shipping Address",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: addressController.selectedAddess.value.isNotEmpty
                  ? addressController.selectedAddess.value
                  : null,
              items: addressController.address.map((addr) {
                final display =
                    '${addr.address_line}, ${addr.district}, ${addr.region}, ${addr.country}';
                return DropdownMenuItem(value: display, child: Text(display));
              }).toList(),
              onChanged: (value) {
                addressController.selectedAddess.value = value!;
              },
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
          ],
        );
      }),

      /// ✅ Make BottomPanel sticky
      bottomNavigationBar: BottomPanel(),
    );
  }
}
