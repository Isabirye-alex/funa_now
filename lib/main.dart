import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_shop/controllers/cart_controller.dart';
import 'package:go_shop/controllers/order_controller.dart';
import 'package:go_shop/controllers/products_controller.dart';
import 'package:go_shop/controllers/signup_controller.dart';
import 'package:go_shop/controllers/user_controller.dart';
import 'package:go_shop/controllers/wishlist_controller.dart';
import 'package:go_shop/features/helper_function/db_helper.dart';
import 'package:go_shop/features/helper_function/internet_helper.dart';

void main() {
  Get.put(CartController());
  Get.put(WishlistController());
  Get.put(OrderController());
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

      final currentUserController = Get.put(UserController());

      await currentUserController.fetchUser();

      final orderController = Get.put(OrderController());
      await orderController.fetchUserOrders();

      final cartController = Get.put(CartController());

      await cartController.loadCartOnAppStart(userId);
    }
    final controller = Get.put(ProductsController());
    controller.fetchProducts(context);
  }

  @override
  Widget build(BuildContext context) {
    return const ConnectionChecker(); // handles both online/offline scenarios
  }
}
