import 'package:flutter/material.dart';
import 'package:go_shop/controllers/wishlist_controller.dart';
import 'package:go_shop/ui/pages/stand_alone/dsicount_badge.dart';
import 'package:go_shop/ui/pages/stand_alone/product_image.dart';
import 'package:go_shop/ui/pages/stand_alone/wishlist_button.dart';

class ProductImageSection extends StatelessWidget {
  const ProductImageSection({
    super.key,
    required this.product,
    required this.wishlistController,
  });

  final dynamic product;
  final WishlistController wishlistController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          ProductImage(product: product),
          Positioned(
            top: 4,
            left: 8,
            right: 8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const DiscountBadge(),
                WishlistButton(
                  productId: product.id!,
                  wishlistController: wishlistController,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
