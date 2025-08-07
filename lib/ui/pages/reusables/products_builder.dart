import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_shop/controllers/cart_controller.dart';
import 'package:go_shop/controllers/products_controller.dart';
import 'package:go_shop/controllers/wishlist_controller.dart';
import 'package:go_shop/models/products_model.dart';
import 'package:go_shop/ui/pages/stand_alone/product_card.dart';
import 'package:go_shop/ui/pages/stand_alone/products_by_category.dart';

class ProductsBuilder extends StatelessWidget {
  final ProductsController productController;
  final WishlistController wishlistController;
  final CartController cartController;

  const ProductsBuilder({
    super.key,
    required this.productController,
    required this.wishlistController,
    required this.cartController,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final products = productController.searchResults.isNotEmpty
          ? productController.searchResults
          : productController.products;

      final Map<String, List<ProductsModel>> groupedProducts = {};

      for (var product in products) {
        final category = product.categoryName ?? 'Uncategorized';
        groupedProducts.putIfAbsent(category, () => []).add(product);
      }

      return Column(
        children: groupedProducts.entries.map((entry) {
          final category = entry.key;
          final allProducts = entry.value;
          final showViewMore = allProducts.length > 4;
          final displayed = showViewMore
              ? allProducts.take(4).toList()
              : allProducts;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title & View More
              Padding(
                padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                child: Container(
                  padding: EdgeInsets.only(left: 12),
                  height: 45,
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.orange),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        category,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                      ),
                      if (showViewMore)
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ProductsByCategory(
                                  category: category,
                                  products: allProducts,
                                  wishlistController: wishlistController,
                                  cartController: cartController,
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            "View More >>",
                            style: TextStyle(color: Colors.blue, fontSize: 16),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              // Product Grid
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: GridView.builder(
                  itemCount: displayed.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 3 / 3.5,
                  ),
                  itemBuilder: (_, i) => ProductCard(
                    product: displayed[i],
                    wishlistController: wishlistController,
                    cartController: cartController,
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      );
    });
  }
}
