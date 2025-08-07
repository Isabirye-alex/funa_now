import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_shop/controllers/products_controller.dart';
import 'package:go_shop/ui/pages/reusables/products_builder.dart';
import 'package:go_shop/controllers/cart_controller.dart';
import 'package:go_shop/controllers/wishlist_controller.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productsController = Get.find<ProductsController>();
    final cartController = Get.find<CartController>();
    final wishlistController = Get.find<WishlistController>();
    final scrollController = ScrollController();

    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverAppBar(
            title: const Text("Search"),
            centerTitle: true,
            pinned: true,
            floating: false,
            backgroundColor: Colors.blue,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60.0),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 2),
                child: SearchBar(
                  backgroundColor: WidgetStateColor.resolveWith(
                    (states) => Colors.white,
                  ),
                  leading: const Icon(Icons.search, color: Colors.black),
                  onChanged: (value) {
                    productsController.searchProducts(value, context);
                  },

                  hintText: 'Search products...',
                  hintStyle: WidgetStateTextStyle.resolveWith(
                    (states) => const TextStyle(
                      color: Colors.black,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: ProductsBuilder(
              productController: productsController,
              wishlistController: wishlistController,
              cartController: cartController,
            ),
          ),
        ],
      ),
    );
  }
}
