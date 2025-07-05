import 'package:flutter/material.dart';
import 'package:go_shop/ui/pages/reusables/shape.dart';
import 'package:iconsax/iconsax.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Shape(
              height: 150,
              child: Column(
                children: [
                  SizedBox(height: kToolbarHeight),
                  ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.amber,
                    ),
                    title: Text(
                      'Name:John Doe',
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      'Email:johndoe@gmail.com',
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: Icon(Iconsax.edit, color: Colors.white),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                _accountTile(
                  icon: Icons.shopping_bag,
                  label: "My Orders",
                  color: Colors.blue[700],
                  onTap: () {},
                ),
                _accountTile(
                  icon: Iconsax.shopping_bag4,
                  label: "My Cart",
                  color: Colors.amber,
                  onTap: () {},
                ),
                _accountTile(
                  icon: Icons.favorite,
                  label: "Wishlist",
                  color: Colors.pink,
                  onTap: () {},
                ),
                _accountTile(
                  icon: Icons.location_on,
                  label: "My Addresses",
                  color: Colors.green[600],
                  onTap: () {},
                ),
                _accountTile(
                  icon: Icons.credit_card,
                  label: "Payment Methods",
                  color: Colors.indigo,
                  onTap: () {},
                ),
                _accountTile(
                  icon: Icons.notifications,
                  label: "Notifications",
                  color: Colors.deepOrange,
                  onTap: () {},
                ),
                _accountTile(
                  icon: Icons.settings,
                  label: "Settings",
                  color: Colors.grey[700],
                  onTap: () {},
                ),
                _accountTile(
                  icon: Icons.help_outline,
                  label: "Help Center",
                  color: Colors.teal,
                  onTap: () {},
                ),
                _accountTile(
                  icon: Icons.logout,
                  label: "Logout",
                  color: Colors.red,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  //ListTile for account items
  Widget _accountTile({
    required IconData icon,
    required String label,
    required Color? color,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      visualDensity: VisualDensity(vertical: -4),
      leading: Icon(icon, color: color),

      title: Text(label, style: TextStyle(color: Colors.black)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
