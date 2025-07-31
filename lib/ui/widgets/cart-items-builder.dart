import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:go_shop/controllers/cart_controller.dart';
import 'package:go_shop/features/helper_function/number_formatter.dart';
import 'package:go_shop/models/cart_item_model.dart';
import 'package:go_shop/models/products_model.dart';
import 'package:go_shop/ui/pages/reusables/pop_up_dialog.dart';

class CartItemsBuilder extends StatelessWidget {
  const CartItemsBuilder({
    super.key,
    required this.total,
    required this.cartController,
    required this.item,
  });

  final double total;
  final CartController cartController;
  final CartItemModel item; // Add this line

  @override
  Widget build(BuildContext context) {
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  cartController.decreaseItemQuantity(
                                    item.id,
                                    context,
                                  );
                                },
                              );
                            } else {
                              cartController.decreaseItemQuantity(
                                item.id,
                                context,
                              );
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 6),
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.green.shade100,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Icon(Icons.remove, color: Colors.red),
                          ),
                        ),
                        Text(
                          '${item.quantity}',
                          style: const TextStyle(color: Colors.purple),
                        ),
                        InkWell(
                          onTap: () {
                            final product = ProductsModel(
                              id: item.productId,
                              name: item.title,
                              price: item.price.toString(),
                              imageUrl: item.imageUrl,
                            );

                            cartController.addToCart(product, context);

                            Flushbar(
                              borderRadius: BorderRadius.circular(8),
                              margin: const EdgeInsets.all(24),
                              flushbarPosition: FlushbarPosition.TOP,
                              backgroundColor: Colors.green,
                              messageText: const Text(
                                'Success',
                                style: TextStyle(color: Colors.white),
                              ),
                              duration: const Duration(seconds: 3),
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
                            margin: const EdgeInsets.only(left: 6),
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Icon(Icons.add, color: Colors.white),
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
            onPressed: () {
              cartController.removeItemFromCart(item.id);
              // cartController.removeItem(item.id, context);
            },
          ),
        ],
      ),
    );
  }
}
