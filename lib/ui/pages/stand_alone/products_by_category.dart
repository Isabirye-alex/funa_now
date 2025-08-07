import 'package:flutter/material.dart';
import 'package:go_shop/models/products_model.dart';
import 'package:go_shop/ui/pages/stand_alone/product_card.dart';
import 'package:go_shop/controllers/cart_controller.dart';
import 'package:go_shop/controllers/wishlist_controller.dart';

class ProductsByCategory extends StatelessWidget {
  final String category;
  final List<ProductsModel> products;
  final WishlistController wishlistController;
  final CartController cartController;

  const ProductsByCategory({
    super.key,
    required this.category,
    required this.products,
    required this.wishlistController,
    required this.cartController,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(category)),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 3 / 3.5,
        ),
        itemBuilder: (context, i) {
          return ProductCard(
            product: products[i],
            wishlistController: wishlistController,
            cartController: cartController,
          );
        },
      ),
    );
  }
}
