import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_shop/controllers/cart_controller.dart';
import 'package:go_shop/controllers/products_controller.dart';
import 'package:go_shop/controllers/wishlist_controller.dart';
import 'package:go_shop/models/products_model.dart';
import 'package:go_shop/ui/pages/reusables/product_detail.dart';
import 'package:iconsax/iconsax.dart';

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
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.products.isEmpty) {
        return const Center(child: Text('No products found'));
      }

      return GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(12),
        itemCount: controller.products.length,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 3 / 3,
        ),
        itemBuilder: (context, index) {
          final product = controller.products[index];
          final wishlistController = Get.put(WishlistController());

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Container(
                    padding: EdgeInsets.only(left: 2, right: 2),
                    decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text('20% OFF'),
                  ),
                  InkWell(
                    onTap: () {
                      wishlistController.toggleWishList(product.id!);
                      setState(() {
                        wishlistController.isWislisted.value !=
                            wishlistController.isWislisted.value;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(),
                      child: Icon(
                        Iconsax.heart,
                        color: wishlistController.isWislisted.value
                            ? Colors.white
                            : Colors.amber,
                      ),
                    ),
                  ),
                ],
              ),
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
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.blue[600],
                    image: DecorationImage(
                      image: NetworkImage(product.imageUrl),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withAlpha(20),
                        BlendMode.darken,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                shadows: [
                                  Shadow(blurRadius: 2, color: Colors.black),
                                ],
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "UGX ${product.formattedPrice}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                shadows: [
                                  Shadow(blurRadius: 2, color: Colors.black),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "UGX ${product.formattedPrice}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      shadows: [Shadow(blurRadius: 2, color: Colors.black)],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(color: Colors.blue),
                    child: InkWell(
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
                          duration: Duration(seconds: 1),
                          isDismissible: true,
                          dismissDirection: FlushbarDismissDirection.HORIZONTAL,
                          shouldIconPulse: false,
                          borderRadius: BorderRadius.circular(8),
                          margin: EdgeInsets.all(24),

                          flushbarPosition: FlushbarPosition.TOP,
                          animationDuration: const Duration(milliseconds: 300),
                          backgroundColor: const Color.fromARGB(
                            255,
                            29,
                            204,
                            40,
                          ),
                          messageText: Text(
                            'Success',
                            style: const TextStyle(color: Colors.white),
                          ),
                          icon: Icon(Icons.check_circle, color: Colors.white),
                          titleText: Text(
                            'Item added to cart',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ).show(context);
                      },
                      child: Icon(Iconsax.add),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      );
    });
  }
}
