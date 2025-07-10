// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_shop/controllers/cart_controller.dart';
import 'package:go_shop/controllers/signup_controller.dart';
import 'package:go_shop/features/helper_function/db_helper.dart';
import 'package:go_shop/ui/pages/reusables/cart.dart';
import 'package:go_shop/ui/pages/reusables/custom_app_bar.dart';
import 'package:go_shop/ui/pages/stand_alone/all_products.dart';
import 'package:go_shop/ui/pages/stand_alone/featured_products.dart';
import 'package:go_shop/ui/pages/stand_alone/summer_products.dart';
import 'package:go_shop/controllers/products_controller.dart';
import 'package:iconsax/iconsax.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});
  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    if (!mounted) return;
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    final authStorage = AuthStorage();
    final authData = await authStorage.getAuthData();

    if (authData != null) {
      final userId = authData['userId'];

      final userController = Get.put(SignUpController());
      await userController.fetchUserById(userId);

      final cartController = Get.put(CartController());

      await cartController.loadCartOnAppStart(userId);
    }
    final controller = Get.put(ProductsController());
    controller.fetchProducts(context);
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
            onTap1: () {},
            onTap2: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Cart()),
              );
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            AllProducts(),
          ],
        ),
      ),
    );
  }
}
