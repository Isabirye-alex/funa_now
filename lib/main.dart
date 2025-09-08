// ignore_for_file: use_build_context_synchronously
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_shop/controllers/categories_controller.dart';
import 'package:go_shop/controllers/order_controller.dart';
import 'package:go_shop/controllers/products_controller.dart';
import 'package:go_shop/controllers/signup_controller.dart';
import 'package:go_shop/controllers/user_controller.dart';
import 'package:go_shop/controllers/wishlist_controller.dart';
import 'package:go_shop/features/helper_function/db_helper.dart';
import 'package:go_shop/features/helper_function/internet_helper.dart';
import 'package:go_shop/firebase_options.dart';

import 'controllers/cart_controller.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(CartController(), permanent: true);
  Get.put(WishlistController(), permanent: true); 
  Get.put(OrderController(), permanent: true); 
  Get.put(SignUpController(), permanent: true); 
  Get.put(UserController(), permanent: true); 
  Get.put(CategoriesController(), permanent: true); 
  Get.put(ProductsController(), permanent: true);
  runApp(const FunaNow());
}

class FunaNow extends StatefulWidget {
  const FunaNow({super.key});
  @override
  State<FunaNow> createState() => _FunaNowState();
}

class _FunaNowState extends State<FunaNow> {
  @override
  void initState() {
    super.initState();
    if (!mounted) return;
    _initializeApp();
  }

Future<void> _initializeApp() async {
    final authStorage = AuthStorage();
    final authData = await authStorage.getAuthData();

    if (authData != null) {
      final userId = authData['userId'];

      final userController = Get.find<SignUpController>();
      await userController.fetchUserById(userId);

      final currentUserController = Get.find<UserController>();
      await currentUserController.fetchUser();

      final categoryController = Get.find<CategoriesController>();
      await categoryController.fetchCategories();

      final orderController = Get.find<OrderController>();
      await orderController.fetchUserOrders();

      final cartController = Get.find<CartController>();
      await cartController.loadCartOnAppStart(userId);
    }
    final productController = Get.find<ProductsController>();
    productController.getSummerProducts();
    productController.getHotSaleProducts();
    productController.getFeaturedProducts();
    productController.fetchProducts(context);


  }
  @override
  Widget build(BuildContext context) {
    return ConnectionChecker();
  }
}
