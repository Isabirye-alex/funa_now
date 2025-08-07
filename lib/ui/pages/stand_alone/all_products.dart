import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_shop/ui/pages/reusables/products_builder.dart';
import 'package:go_shop/ui/pages/reusables/shimmer_grid.dart';
import 'package:go_shop/controllers/products_controller.dart';
import 'package:go_shop/controllers/cart_controller.dart';
import 'package:go_shop/controllers/wishlist_controller.dart';
// import 'dart:async';

class AllProducts extends StatelessWidget {
  const AllProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final productController = Get.find<ProductsController>();
    final cartController = Get.find<CartController>();
    final wishlistController = Get.find<WishlistController>();

    return Obx(() {
      if (productController.products.isEmpty &&
          productController.isLoading.value) {
        return const ShimmerGrid();
      }

      if (productController.products.isEmpty) {
        productController.fetchProducts(context);
      }

      return ProductsBuilder(
        productController: productController,
        wishlistController: wishlistController,
        cartController: cartController,
      );
    });
  }
}
