import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_shop/controllers/cart_controller.dart';
import 'package:go_shop/controllers/products_controller.dart';
import 'package:go_shop/controllers/wishlist_controller.dart';
import 'package:go_shop/models/categories_model.dart';
import 'package:go_shop/ui/pages/stand_alone/product_card.dart';

class ProductsByCategory2 extends StatelessWidget {
  final CategoriesModel category;

  ProductsByCategory2({super.key, required this.category});

  final ProductsController productsController = Get.find();

  @override
  Widget build(BuildContext context) {
    final products = productsController.products
        .where((p) => p.categoryId == category.id)
        .toList();
    debugPrint('Found the following products: $products');
    return Scaffold(
      appBar: AppBar(title: Text(category.name)),
      body: products.isEmpty
          ? const Center(child: Text("No products found in this category."))
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.72,
              ),
              itemBuilder: (context, index) {
                final cartController = Get.find<CartController>();
                final wishListController = Get.find<WishlistController>();
                final product = products[index];
                return ProductCard(
                  product: product,
                  wishlistController: wishListController,
                  cartController: cartController,
                ); // Use your existing card
              },
            ),
    );
  }
}
