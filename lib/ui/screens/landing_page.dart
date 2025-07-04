import 'package:flutter/material.dart';
import 'package:go_shop/ui/pages/reusables/custom_app_bar.dart';
import 'package:go_shop/ui/pages/stand_alone/all_products.dart';
import 'package:go_shop/ui/pages/stand_alone/featured_products.dart';
import 'package:go_shop/ui/pages/stand_alone/summer_products.dart';

//Landing where app users are directed on opening the application
class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 75, title: CustomAppBar()),

      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 14),
            Text(
              "Welcome to MyShop",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            //Summer products
            SummerProducts(),
            const SizedBox(height: 24),
            Text(
              "Featured Products",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            //Featured Products
            FeaturedProduct(),
            const SizedBox(height: 24),
            Text(
              "Products",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            //All products
            AllProducts(),
          ],
        ),
      ),
    );
  }
}
