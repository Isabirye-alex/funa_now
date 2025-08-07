import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_shop/ui/pages/reusables/products_builder.dart';
import 'package:go_shop/ui/pages/reusables/shimmer_grid.dart';
import 'package:go_shop/controllers/products_controller.dart';
import 'package:go_shop/controllers/cart_controller.dart';
import 'package:go_shop/controllers/wishlist_controller.dart';
// import 'dart:async';

class AllProducts extends StatefulWidget {
  const AllProducts({super.key});

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  final controller = Get.put(ProductsController());

  @override
  Widget build(BuildContext context) {
    final productController = Get.find<ProductsController>();
    final cartController = Get.find<CartController>();
    final wishlistController = Get.find<WishlistController>();

    return Obx(() {
      if (productController.products.isEmpty &&
          productController.isLoading.value) {
        return ShimmerGrid();
      }

      if (productController.products.isEmpty){
         productController.fetchProducts(context);
      }

      return ProductsBuilder(
        scrollController: controller.scrollController,
        productController: productController,
        wishlistController: wishlistController,
        cartController: cartController,
      );
    });
  }
}
