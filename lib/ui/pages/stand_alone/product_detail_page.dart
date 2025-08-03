import 'package:flutter/material.dart';
import 'package:go_shop/controllers/cart_controller.dart';
import 'package:go_shop/ui/pages/stand_alone/add_to_cart_button.dart';

class ProductDetailsSection extends StatelessWidget {
  const ProductDetailsSection({
    super.key,
    required this.product,
    required this.cartController,
  });

  final dynamic product;
  final CartController cartController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 6, right: 8, bottom: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "UGX ${product.formattedPrice}",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue,
                ),
              ),
              AddToCartButton(product: product, cartController: cartController),
            ],
          ),
        ],
      ),
    );
  }
}
