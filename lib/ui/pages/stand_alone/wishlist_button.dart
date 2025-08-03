import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_shop/controllers/wishlist_controller.dart';
import 'package:iconsax/iconsax.dart';

class WishlistButton extends StatelessWidget {
  const WishlistButton({
    super.key,
    required this.productId,
    required this.wishlistController,
  });

  final int productId;
  final WishlistController wishlistController;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => wishlistController.toggleWishList(productId),
      child: Obx(() {
        final isWishlisted = wishlistController.isWishlisted(productId);
        return Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.blue.withAlpha(200),
            shape: BoxShape.circle,
          ),
          child: Icon(
            isWishlisted ? Iconsax.heart5 : Iconsax.heart,
            color: isWishlisted ? Colors.amber : Colors.white,
            size: 20,
          ),
        );
      }),
    );
  }
}
