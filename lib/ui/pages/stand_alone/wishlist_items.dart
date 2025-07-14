import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_shop/controllers/cart_controller.dart';
import 'package:go_shop/controllers/wishlist_controller.dart';
import 'package:go_shop/models/products_model.dart';
import 'package:go_shop/models/wishlist_items_model.dart';
import 'package:go_shop/ui/pages/reusables/product_detail.dart';
import 'package:iconsax/iconsax.dart';

class WishlistItems extends StatelessWidget {
  const WishlistItems({super.key});

  @override
  Widget build(BuildContext context) {
    final wishlistController = Get.put(WishlistController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Wishlist"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Obx(() {
        final items = wishlistController.items;

        if (items.isEmpty) {
          return const Center(
            child: Text(
              'Your wishlist is empty.',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: GridView.builder(
            itemCount: items.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 250,
              mainAxisSpacing: 16,
              crossAxisSpacing: 12,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (context, index) {
              final item = items[index];
              return WishlistCard(item: item);
            },
          ),
        );
      }),
    );
  }
}

class WishlistCard extends StatelessWidget {
  final WishlistItemsModel item;

  const WishlistCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final wishlistController = Get.put(WishlistController());
    final cartController = Get.put(CartController());

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetail(
                          productId: item.product_id,
                          description: item.product_description,
                          price: item.product_price,
                          image: item.product_image,
                          name: item.product_name,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(item.product_image),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Colors.black.withAlpha(10),
                          BlendMode.darken,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 4,
                  left: 8,
                  right: 8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          '20% OFF',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          wishlistController.toggleWishList(item.product_id);
                        },
                        child: Obx(() {
                          final isWishlisted = wishlistController.isWishlisted(
                            item.product_id,
                          );
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product_name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "UGX ${item.product_price}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 2,
                    ),
                    InkWell(
                      onTap: () {
                        final product = ProductsModel(
                          id: item.product_id,
                          name: item.product_name,
                          description: item.product_description,
                          price: item.product_price,
                          imageUrl: item.product_image,
                        );

                        cartController.addToCart(product, context);
                        Flushbar(
                          shouldIconPulse: false,
                          duration: const Duration(milliseconds: 500),
                          isDismissible: true,
                          dismissDirection: FlushbarDismissDirection.HORIZONTAL,
                          borderRadius: BorderRadius.circular(8),
                          margin: const EdgeInsets.all(16),
                          flushbarPosition: FlushbarPosition.TOP,
                          animationDuration: const Duration(milliseconds: 300),
                          backgroundColor: Colors.green,
                          messageText: const Text(
                            'Item added to cart',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          icon: const Icon(
                            Icons.check_circle,
                            color: Colors.white,
                          ),
                        ).show(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                          color: Colors.blue,
                        ),
                        child: const Icon(
                          Iconsax.add,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
