import 'package:flutter/material.dart';
import 'package:go_shop/controllers/cart_controller.dart';
import 'package:go_shop/controllers/wishlist_controller.dart';
import 'package:go_shop/ui/pages/stand_alone/product_detail_page.dart';
import 'package:go_shop/ui/pages/stand_alone/product_image_section.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.wishlistController,
    required this.cartController,
  });

  final dynamic product;
  final WishlistController wishlistController;
  final CartController cartController;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.blue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProductImageSection(
            product: product,
            wishlistController: wishlistController,
          ),
          ProductDetailsSection(
            product: product,
            cartController: cartController,
          ),
        ],
      ),
    );
  }
}
