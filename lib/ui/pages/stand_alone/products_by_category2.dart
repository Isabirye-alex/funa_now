
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_shop/controllers/cart_controller.dart';
import 'package:go_shop/controllers/products_controller.dart';
import 'package:go_shop/controllers/wishlist_controller.dart';
import 'package:go_shop/models/categories_model.dart';

import 'package:go_shop/ui/pages/stand_alone/product_card.dart';

class ProductsByCategory2 extends StatefulWidget {
  final CategoriesModel category;
  final int categoryId;

  const ProductsByCategory2({
    super.key,
    required this.category,
    required this.categoryId,
  });

  @override
  State<ProductsByCategory2> createState() => _ProductsByCategory2State();
}

class _ProductsByCategory2State extends State<ProductsByCategory2> {
  final productsController = Get.find<ProductsController>();
  final cartController = Get.find<CartController>();
  final wishListController = Get.find<WishlistController>();

  @override
  void initState() {
    super.initState();
    productsController.fetchProductsByCategoryId(widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.category.name)),
      body: Obx(() {
        if (productsController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final allProducts = productsController.pro;

        if (allProducts.isEmpty) {
          return const Center(
            child: Text("No products found in this category."),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: allProducts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.72,
          ),
          itemBuilder: (context, index) {
            final product = allProducts[index];
            return ProductCard(
              product: product,
              wishlistController: wishListController,
              cartController: cartController,
            );
          },
        );
      }),
    );
  }
}
