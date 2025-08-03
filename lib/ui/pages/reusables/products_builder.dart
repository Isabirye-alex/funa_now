import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_shop/controllers/cart_controller.dart';
import 'package:go_shop/controllers/products_controller.dart';
import 'package:go_shop/controllers/wishlist_controller.dart';
import 'package:go_shop/ui/pages/stand_alone/product_card.dart';
class ProductsBuilder extends StatelessWidget {
  const ProductsBuilder({
    super.key,
    required ScrollController scrollController,
    required this.productController,
    required this.wishlistController,
    required this.cartController,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;
  final ProductsController productController;
  final WishlistController wishlistController;
  final CartController cartController;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final controller = ProductsController.to;
      final list = controller.searchResults.isNotEmpty
          ? controller.searchResults
          : controller.products;
      return GridView.builder(
        controller: _scrollController,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 3 / 3.5,
        ),
        itemCount: list.length,
        itemBuilder: (context, index) {
          final product = list[index];
          return ProductCard(
            product: product,
            wishlistController: wishlistController,
            cartController: cartController,
          );
        },
      );
    });
  }
}






