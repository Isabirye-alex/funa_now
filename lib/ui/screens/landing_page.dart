// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:go_shop/controllers/cart_controller.dart';
import 'package:go_shop/controllers/categories_controller.dart';
import 'package:go_shop/ui/pages/reusables/custom_app_bar.dart';
import 'package:go_shop/ui/pages/stand_alone/all_products.dart';
import 'package:go_shop/ui/pages/stand_alone/featured_products.dart';
import 'package:go_shop/ui/pages/stand_alone/summer_products.dart';
import 'package:iconsax/iconsax.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});
  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState(){
    super.initState();
    final categoryController = Get.put(CategoriesController());
    categoryController.fetchCategories();
  }
  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        title: Obx(
          () => CustomAppBar(
            icon: Iconsax.shopping_bag4,
            color: Colors.purpleAccent,
            hint: 'Search Product...',
            icon2: Iconsax.lovely,
            iconText2: 'WishList',
            iconText: 'View Cart',
            items: cartController.cartItem.length,
            onTap1: () => context.go('/wishlist'),
            onTap2: () => context.go('/cartpage'),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.zero,

     child:  Padding(padding: EdgeInsets.zero,
  child:  ListView(
    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
    children: [
      const SizedBox(height: 14),
      const Text(
        "Welcome to MyShop",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      const SizedBox(height: 16),
      SummerProducts(),
      const SizedBox(height: 24),
      const Text(
        "Featured Products",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      const SizedBox(height: 12),
      FeaturedProduct(),
      const SizedBox(height: 24),
      const Text(
        "Products",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      const SizedBox(height: 12),
      Container(
        padding: EdgeInsets.zero, 
        child: AllProducts(),
      ),
    ],
  )
)
      )
      
    );
  }
}
