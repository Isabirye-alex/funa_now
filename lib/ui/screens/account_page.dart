import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:go_shop/controllers/cart_controller.dart';
import 'package:go_shop/controllers/login_controller.dart';
import 'package:go_shop/controllers/user_controller.dart';
import 'package:iconsax/iconsax.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  void initState() {
    super.initState();
    final userController = Get.put(UserController());
    userController.fetchUserId();
    userController.fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final cartController = Get.put(CartController());
    final userController = Get.put(UserController());

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Account'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile section
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.amber,
                    child: const Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() {
                          final uid = userController.userId.value;
                          return uid != null
                              ? Text(
                                  'Username: ${userController.username.toString()}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,

                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              : Text(
                                  'Create an account to start shopping',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  maxLines: 2,
                                );
                        }),
                        SizedBox(height: 4),
                        Obx(() {
                          final uid = userController.userId.value;
                          return uid != null
                              ? Text(
                                  'Email: ${userController.email.toString()}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              : Text(
                                  'Track orders and Save items',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  maxLines: 2,
                                );
                        }),
                      ],
                    ),
                  ),

                  Obx(() {
                    final uid = userController.userId.value;
                    return uid != null
                        ? InkWell(
                            onTap: () {
                              cartController.clearCart();
                              controller.logout(context);
                            },
                            child: Column(
                              children: [
                                Icon(Iconsax.logout, color: Colors.blueAccent),
                                Text(
                                  'Log out',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              context.go('/loginpage');
                            },
                            child: Column(
                              children: [
                                Icon(Iconsax.login, color: Colors.blueAccent),
                                Text(
                                  'LogIn',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          );
                  }),
                ],
              ),
            ),

            const SizedBox(height: 16),
            // Options section
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  Obx(() {
                    final uid = userController.userId.value;
                    return uid != null
                        ? _accountCard(
                            icon: Icons.person_3_rounded,
                            label:
                                '${userController.firstname.toString()} ${userController.lastname.toString()}',
                            color: Colors.blue[700],
                            onTap: () {},
                          )
                        : _accountCard(
                            icon: Icons.account_circle_sharp,
                            label: "Sign up to personalize",
                            color: const Color.fromARGB(255, 13, 171, 15),
                            onTap: () {
                              context.go('/registerpage');
                            },
                          );
                  }),
                  _accountCard(
                    icon: Icons.shopping_bag,
                    label: "My Orders",
                    color: Colors.blue[700],
                    onTap: () {
                      GoRouter.of(context).go('/orderspage');
                    },
                  ),
                  _accountCard(
                    icon: Iconsax.shopping_bag4,
                    label: "My Cart",
                    color: Colors.amber,
                    onTap: () {
                      context.go('/cartpage');
                    },
                  ),
                  _accountCard(
                    icon: Icons.favorite,
                    label: "Wishlist",
                    color: Colors.pink,
                    onTap: () {
                      context.go('/wishlist');
                    },
                  ),
                  _accountCard(
                    icon: Icons.shop,
                    label: "Follow Vendor",
                    color: Colors.pink,
                    onTap: () {
                      // context.go('/wishlist');
                    },
                  ),
                  _accountCard(
                    icon: Icons.location_on,
                    label: "My Addresses",
                    color: Colors.green[600],
                    onTap: () {
                      context.go('/addresslistpage');
                    },
                  ),
                  _accountCard(
                    icon: Icons.credit_card,
                    label: "Payment Methods",
                    color: Colors.indigo,
                    onTap: () {},
                  ),
                  _accountCard(
                    icon: Icons.notifications,
                    label: "Notifications",
                    color: Colors.deepOrange,
                    onTap: () {},
                  ),
                  _accountCard(
                    icon: Icons.settings,
                    label: "Settings",
                    color: Colors.grey[700],
                    onTap: () {},
                  ),
                  _accountCard(
                    icon: Icons.help_outline,
                    label: "Help Center",
                    color: Colors.teal,
                    onTap: () {},
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  // Card style for each option for nicer UI
  Widget _accountCard({
    required IconData icon,
    required String label,
    required Color? color,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: ListTile(
        leading: Icon(icon, color: color, size: 28),
        title: Text(label, style: const TextStyle(fontSize: 16)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      ),
    );
  }
}
