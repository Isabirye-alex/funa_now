// ignore_for_file: unnecessary_string_interpolations

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:go_shop/controllers/cart_controller.dart';
import 'package:go_shop/features/helper_function/db_helper.dart';
import 'package:go_shop/features/helper_function/number_formatter.dart';
import 'package:go_shop/models/products_model.dart';
import 'package:go_shop/ui/pages/reusables/pop_up_dialog.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final cartController = Get.put(CartController());

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    final authStorage = AuthStorage();
    final authData = await authStorage.getAuthData();

    if (authData != null) {
      final userId = authData['userId'];
      final cartController = Get.put(CartController());
      await cartController.loadCartOnAppStart(userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('🛒 My Cart'),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
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
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: cartController.cartItem.length,
                itemBuilder: (context, index) {
                  final item = cartController.cartItem[index];
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
                                  color: Colors.black,
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
                                  Container(
                                    decoration: BoxDecoration(),
                                    child: Row(
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
                                            margin: EdgeInsets.only(right: 6),
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            child: Icon(
                                              Icons.remove,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '${item.quantity}',
                                          style: TextStyle(
                                            color: Colors.purple,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          maxLines: 1,
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
                                              shouldIconPulse: false,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              margin: EdgeInsets.all(24),
                                              flushbarPosition:
                                                  FlushbarPosition.TOP,
                                              animationDuration: const Duration(
                                                milliseconds: 300,
                                              ),
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                    255,
                                                    29,
                                                    204,
                                                    40,
                                                  ),
                                              messageText: Text(
                                                'Success',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              duration: const Duration(
                                                seconds: 4,
                                              ),
                                              icon: Icon(
                                                Icons.check_circle,
                                                color: Colors.white,
                                              ),
                                              titleText: Text(
                                                'Cart updated successfully',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ).show(context);

                                            debugPrint('Success');
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(left: 6),
                                            decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            child: Icon(
                                              Icons.add,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            // cartController.removeItem(item.id);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Total Price and Checkout
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Obx(() {
                    final total = cartController.cartItem
                        .fold<double>(
                          0.0,
                          (sum, item) => sum + (item.quantity * item.price),
                        )
                        .toStringAsFixed(0);
                    return Row(
                      children: [
                        Text(
                          'Total: UGX ',
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                        Text(
                          '${NumberFormatter.formatPrice(total)}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    );
                  }),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.go('/orderpage');
                    },
                    icon: const Icon(Icons.payment),
                    label: const Text('Proceed to Checkout'),
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
