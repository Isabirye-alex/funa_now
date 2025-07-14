import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_shop/controllers/cart_controller.dart';
import 'package:go_shop/controllers/products_controller.dart';
import 'package:go_shop/controllers/wishlist_controller.dart';
import 'package:go_shop/models/products_model.dart';
import 'package:go_shop/ui/pages/reusables/product_detail.dart';
import 'package:iconsax/iconsax.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({super.key});

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductsController());
    final cartController = Get.put(CartController());

    return Obx(() {
      // if (controller.isLoading.value) {
      //   return const Center(child: CircularProgressIndicator());
      // }

      // if (controller.products.isEmpty) {
      //   return const Center(child: Text('No products found'));
      // }

      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(left: 2, right: 2, top: 8, bottom: 8),
        itemCount: controller.products.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 3 / 3.5,
        ),
        itemBuilder: (context, index) {
          final product = controller.products[index];
          final wishlistController = Get.find<WishlistController>();

          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: Colors.white, // Changed background to white
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Container
                Expanded(
                  child: Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetail(
                                productId: product.id!,
                                description: product.description!,
                                price: product.formattedPrice,
                                image: product.imageUrl,
                                name: product.name,
                              ),
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          child: Stack(
                            children: [
                              CachedNetworkImage(
                                imageUrl: product.imageUrl,
                                height: 130,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                colorBlendMode: BlendMode.darken,
                                placeholder: (context, url) => Container(
                                  height: 130,
                                  width: double.infinity,
                                  color: Colors.grey[300],
                                  child: const Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  height: 130,
                                  width: double.infinity,
                                  color: Colors.grey,
                                  child: const Icon(
                                    Icons.broken_image,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              // Overlay buttons like discount and wishlist
                              Positioned(
                                top: 4,
                                left: 8,
                                right: 8,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                      onTap: () => wishlistController
                                          .toggleWishList(product.id!),
                                      child: Obx(() {
                                        final isWishlisted = wishlistController
                                            .isWishlisted(product.id!);
                                        return Container(
                                          padding: const EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                            color: Colors.blue.withAlpha(200),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            isWishlisted
                                                ? Iconsax.heart5
                                                : Iconsax.heart,
                                            color: isWishlisted
                                                ? Colors.amber
                                                : Colors.white,
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
                      ),
                      // Discount and Wishlist buttons
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
                              onTap: () async {
                                wishlistController.toggleWishList(product.id!);
                              },
                              child: Obx(() {
                                final isWishlisted = wishlistController
                                    .isWishlisted(product.id!);
                                return Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.withAlpha(200),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    isWishlisted
                                        ? Iconsax.heart5
                                        : Iconsax.heart,
                                    color: isWishlisted
                                        ? Colors.amber
                                        : Colors.white,
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
                // Product Info
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "UGX ${product.formattedPrice}",
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
                              final products = ProductsModel(
                                id: product.id!,
                                name: product.name,
                                description: product.description!,
                                price: product.price,
                                imageUrl: product.imageUrl,
                              );

                              cartController.addToCart(products, context);
                              Flushbar(
                                shouldIconPulse: false,
                                duration: const Duration(milliseconds: 500),
                                isDismissible: true,
                                dismissDirection:
                                    FlushbarDismissDirection.HORIZONTAL,
                                borderRadius: BorderRadius.circular(8),
                                margin: const EdgeInsets.all(16),
                                flushbarPosition: FlushbarPosition.TOP,
                                animationDuration: const Duration(
                                  milliseconds: 300,
                                ),
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
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
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
        },
      );
    });
  }
}
