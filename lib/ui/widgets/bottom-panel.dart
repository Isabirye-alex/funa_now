import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:go_shop/controllers/address_controller.dart';
import 'package:go_shop/controllers/cart_controller.dart';
import 'package:go_shop/controllers/order_controller.dart';
import 'package:go_shop/controllers/payment_controller.dart';
import 'package:go_shop/features/helper_function/number_formatter.dart';

class BottomPanel extends StatelessWidget {
  const BottomPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    final orderController = Get.find<OrderController>();
    final addressController = Get.find<AddressController>();
    final paymentController = Get.find<PaymentController>();
    final totalItems = cartController.cartItem.fold<int>(
      0,
      (sum, item) => sum + item.quantity,
    );
    final totalAmount = cartController.cartItem.fold<double>(
      0.0,
      (sum, item) => sum + (item.price * item.quantity),
    );

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
        ),
        constraints: const BoxConstraints(minHeight: 150),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Total Items: $totalItems",
              style: const TextStyle(fontSize: 16, color: Colors.amber),
            ),
            const SizedBox(height: 8),
            Text(
              "Total: UGX ${NumberFormatter.formatPrice(totalAmount)}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 16),
            Obx(() {
              print(
                'Obx rebuilding: isPlacingOrder = ${orderController.isPlacingOrder.value}',
              );
              return ElevatedButton(
                onPressed: orderController.isPlacingOrder.value
                    ? null
                    : () async {
                        final cartId = cartController.cart_id.value;
                        final address = addressController.selectedAddess.value;
                        final payment = paymentController.selectedMethod.value;
                        final total = totalAmount;

                        if (address.isEmpty || payment.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Please select address and payment method',
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        await orderController.placeOrder(
                          cartId.toString(),
                          total.toString(),
                          address,
                          payment,
                          context,
                        );
                      },
                style: ElevatedButton.styleFrom(
                  foregroundColor:
                      Colors.white, // Changed to white for contrast
                  backgroundColor: Colors.deepOrange,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 16),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                ),
                child: orderController.isPlacingOrder.value
                    ?SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.blue,
                          ),
                          strokeWidth: 2,
                        ),
                      )
                    :Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.payment, color: Colors.white),
                          SizedBox(width: 8),
                          Text('Confirm Order'),
                        ],
                      ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
