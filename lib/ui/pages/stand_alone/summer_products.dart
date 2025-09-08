import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_shop/controllers/products_controller.dart';
import 'package:go_shop/models/products_model.dart';

class SummerProducts extends StatefulWidget {
  const SummerProducts({super.key});

  @override
  State<SummerProducts> createState() => _SummerProductsState();
}

class _SummerProductsState extends State<SummerProducts> {


  @override
  Widget build(BuildContext context) {
    final summerProductsController = Get.find<ProductsController>();
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
      child: SizedBox(
        height: 170,
        child: Obx(() {
          final summerSales = summerProductsController.summerProducts;
          final isLoading = summerProductsController.isSLoading.value;

          if (isLoading && summerSales.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (summerSales.isEmpty) {
            return const Center(child: Text("No Summer Sales available"));
          }

          return ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: summerProductsController.summerProducts.length,
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              ProductsModel product = summerProductsController.summerProducts[index];
              return Container(
                width: MediaQuery.of(context).size.width * 0.70,
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.blue[700],
                  image: DecorationImage(
                    image: NetworkImage(product.imageUrl),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withAlpha(20),
                      BlendMode.darken,
                    ),
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "${product.name}\nUp to ${product.percentage_discount ?? 0}% OFF",
                      style:TextStyle(
                        color: Colors.yellow,
                        fontSize: 20,
                        // shadows: [
                        //   Shadow(color: Colors.black45, blurRadius: 4)
                        // ],
                      ),
                    ),
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
