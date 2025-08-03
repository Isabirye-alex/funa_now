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
  // Timer? _debounce;

  // @override
  // void initState() {
  //   super.initState();

  //   final productController = Get.put(ProductsController());

  //   controller.scrollController.addListener(() {
  //     if (controller.scrollController.position.pixels >=
  //         controller.scrollController.position.maxScrollExtent - 200) {
  //       if (_debounce?.isActive ?? false) return; // Prevent multiple calls
  //       _debounce = Timer(const Duration(milliseconds: 500), () {
  //         productController.fetchProducts(context);
  //       });
  //     }
  //   });
  // }

  // @override
  // void dispose() {
  //   _debounce?.cancel();
  //   controller.scrollController.dispose();
  //   // super.dispose();
  // }

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

      if (productController.products.isEmpty) {
        return const Center(child: Text('No products found'));
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
