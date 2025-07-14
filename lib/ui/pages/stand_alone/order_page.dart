// ignore_for_file: unnecessary_string_interpolations

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_shop/controllers/address_controller.dart';
import 'package:go_shop/controllers/cart_controller.dart';
import 'package:go_shop/controllers/order_controller.dart';
import 'package:go_shop/controllers/payment_controller.dart';
import 'package:go_shop/features/helper_function/number_formatter.dart';
import 'package:go_shop/models/products_model.dart';
import 'package:go_shop/ui/pages/reusables/pop_up_dialog.dart';

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

        final totalItems = cartController.cartItem.fold<int>(
          0,
          (sum, item) => sum + item.quantity,
        );
        final totalAmount = cartController.cartItem.fold<double>(
          0.0,
          (sum, item) => sum + (item.price * item.quantity),
        );

        return Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // Cart Items
                  ...cartController.cartItem.map((item) {
                    final total = item.price * item.quantity;
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: item.imageUrl.isNotEmpty
                                ? Image.network(
                                    item.imageUrl,
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    'assets/images/placeholder.png',
                                    width: 60,
                                    height: 60,
                                  ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'UGX ${NumberFormatter.formatPrice(total)}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.deepPurple,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            if (item.quantity <= 1) {
                                              showCustomDialog(
                                                context: context,
                                                title: 'Remove Item',
                                                content:
                                                    'Are you sure you want to remove this item from your cart?',
                                                onCancel: () {},
                                                onConfirm: () {
                                                  cartController
                                                      .decreaseItemQuantity(
                                                        item.id,
                                                        context,
                                                      );
                                                },
                                              );
                                            } else {
                                              cartController
                                                  .decreaseItemQuantity(
                                                    item.id,
                                                    context,
                                                  );
                                            }
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                              right: 6,
                                            ),
                                            padding: const EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              color: Colors.green.shade100,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            child: const Icon(
                                              Icons.remove,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '${item.quantity}',
                                          style: const TextStyle(
                                            color: Colors.purple,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            final product = ProductsModel(
                                              id: item.productId,
                                              name: item.title,
                                              price: item.price.toString(),
                                              imageUrl: item.imageUrl,
                                            );

                                            cartController.addToCart(
                                              product,
                                              context,
                                            );

                                            Flushbar(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              margin: const EdgeInsets.all(24),
                                              flushbarPosition:
                                                  FlushbarPosition.TOP,
                                              backgroundColor: Colors.green,
                                              messageText: const Text(
                                                'Success',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              duration: const Duration(
                                                seconds: 3,
                                              ),
                                              icon: const Icon(
                                                Icons.check_circle,
                                                color: Colors.white,
                                              ),
                                              titleText: const Text(
                                                'Cart updated successfully',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ).show(context);
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                              left: 6,
                                            ),
                                            padding: const EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            child: const Icon(
                                              Icons.add,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    );
                  }),

                  const SizedBox(height: 20),

                  // Payment Method Dropdown
                  Text(
                    "Payment Method",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Obx(() {
                    if (paymentController.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (paymentController.error.isNotEmpty) {
                      return Text(paymentController.error.value);
                    }

                    return DropdownButtonFormField<String>(
                      value: paymentController.selectedMethod.value,
                      items: paymentController.paymentMethods
                          .map(
                            (method) => DropdownMenuItem(
                              value: method,
                              child: Text(method),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          paymentController.selectedMethod.value = value!;
                        });
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    );
                  }),
                  const SizedBox(height: 20),

                  // Shipping Address Dropdown
                  const Text(
                    "Shipping Address",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),

                  DropdownButtonFormField<String>(
                    value: addressController.selectedAddess.value.isNotEmpty
                        ? addressController.selectedAddess.value
                        : null,
                    items: addressController.address.map((addr) {
                      final display =
                          '${addr.address_line}, ${addr.district}, ${addr.region}, ${addr.country}';
                      return DropdownMenuItem(
                        value: display,
                        child: Text(display),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        addressController.selectedAddess.value = value!;
                      });
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),

            // Bottom Panel
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Total Items: $totalItems",
                    style: const TextStyle(fontSize: 16, color: Colors.amber),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Total: UGX ${NumberFormatter.formatPrice(totalAmount)}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: () async {
                      final cartId = cartController.cart_id.value;
                      final address = addressController.selectedAddess.value;
                      final payment = paymentController.selectedMethod.value;
                      final total = totalAmount;
                      final orderController = Get.put(OrderController());
                      orderController.placeOrder(
                        cartId.toString(),
                        total.toString(),
                        address,
                        payment,
                        context,
                      );
                    },
                    icon: const Icon(Icons.payment),
                    label: const Text('Confirm Order'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
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
