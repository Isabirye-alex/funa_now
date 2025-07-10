import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:go_shop/controllers/cart_controller.dart';
import 'package:go_shop/controllers/login_controller.dart';
import 'package:iconsax/iconsax.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final cartController = Get.put(CartController());

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
                      children: const [
                        Text(
                          'John Doe',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'johndoe@gmail.com',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Iconsax.edit, color: Colors.blueAccent),
                    onPressed: () {
                      // Edit profile action
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Options section
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  _accountCard(
                    icon: Icons.account_circle_sharp,
                    label: "Log in or Register",
                    color: const Color.fromARGB(255, 13, 171, 15),
                    onTap: () {
                      context.go('/loginpage');
                    },
                  ),
                  _accountCard(
                    icon: Icons.shopping_bag,
                    label: "My Orders",
                    color: Colors.blue[700],
                    onTap: () {},
                  ),
                  _accountCard(
                    icon: Iconsax.shopping_bag4,
                    label: "My Cart",
                    color: Colors.amber,
                    onTap: () {},
                  ),
                  _accountCard(
                    icon: Icons.favorite,
                    label: "Wishlist",
                    color: Colors.pink,
                    onTap: () {},
                  ),
                  _accountCard(
                    icon: Icons.location_on,
                    label: "My Addresses",
                    color: Colors.green[600],
                    onTap: () {},
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
                  _accountCard(
                    icon: Icons.logout,
                    label: "Logout",
                    color: Colors.red,
                    onTap: () {
                      cartController.clearCart();
                      controller.logout(context);
                    },
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
