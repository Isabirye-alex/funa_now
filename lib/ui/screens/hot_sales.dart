import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_shop/controllers/products_controller.dart';
import 'package:go_shop/ui/pages/reusables/product_detail.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../pages/stand_alone/dsicount_badge.dart';
// optional if you want the badge

class HotSales extends StatefulWidget {
  const HotSales({super.key});

  @override
  State<HotSales> createState() => _HotSalesState();
}

class _HotSalesState extends State<HotSales> {
  late ProductsController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<ProductsController>();
    controller.getHotSaleProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        centerTitle: true,
        title: const Text(
          '🔥Today\'s Hot Sales',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.redAccent,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 6, 16.0, 16.0),
        child: Obx(() {
          final hotSales = controller.hotSaleProducts;
          final isLoading = controller.isHLoading.value;

          if (isLoading && hotSales.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (hotSales.isEmpty) {
            return const Center(child: Text("No hot sales available"));
          }

          return GridView.builder(
            itemCount: hotSales.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 18,
              crossAxisSpacing: 18,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) {
              final product = hotSales[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductDetail(
                        description: product.description ?? "",
                        price: product.formattedPrice,
                        image: product.imageUrl,
                        name: product.name,
                        productId: product.id!,
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(18),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: product.imageUrl,
                              height: 110,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                height: 110,
                                width: double.infinity,
                                color: Colors.grey[300],
                              ),
                              errorWidget: (context, url, error) => Container(
                                height: 110,
                                width: double.infinity,
                                color: Colors.grey,
                                child: const Icon(Icons.broken_image),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "UGX ${product.formattedPrice}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // Hot badge
                      Positioned(
                        top: 12,
                        left: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            "Hot",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      // Optional: discount badge if percentage exists
                      if ((product.percentage_discount ?? 0) > 0)
                        Positioned(
                          top: 12,
                          right: 12,
                          child: DiscountBadge(product: product),
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
