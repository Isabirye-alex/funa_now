import 'package:flutter/material.dart';
import 'package:go_shop/models/products_model.dart'; // your product model

class DiscountBadge extends StatelessWidget {
  final ProductsModel product;

  const DiscountBadge({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final discount = product.percentage_discount ?? 0;
    if (discount <= 0) {
      // return Text('0% OFF');
      return const SizedBox.shrink();
    }


    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        '${discount.toInt()}% OFF',  // <-- fixed here
        style: TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
