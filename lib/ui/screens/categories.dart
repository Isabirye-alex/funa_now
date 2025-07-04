import 'package:flutter/material.dart';
import 'package:go_shop/ui/pages/reusables/custom_app_bar.dart';
import 'package:iconsax/iconsax.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  final List<Map<String, dynamic>> categoryList = const [
    {"name": "Electronics", "icon": Iconsax.cpu, "color": Colors.blue},
    {"name": "Fashion", "icon": Iconsax.shopping_bag, "color": Colors.pink},
    {"name": "Home", "icon": Iconsax.home, "color": Colors.green},
    {"name": "Beauty", "icon": Iconsax.magicpen, "color": Colors.purple},
    {"name": "Sports", "icon": Iconsax.activity, "color": Colors.orange},
    {"name": "Toys", "icon": Iconsax.game, "color": Colors.teal},
    {"name": "Books", "icon": Iconsax.book, "color": Colors.brown},
    {"name": "Groceries", "icon": Iconsax.shop, "color": Colors.red},
    {"name": "Electronics", "icon": Iconsax.cpu, "color": Colors.blue},
    {"name": "Fashion", "icon": Iconsax.shopping_bag, "color": Colors.pink},
    {"name": "Home", "icon": Iconsax.home, "color": Colors.green},
    {"name": "Beauty", "icon": Iconsax.magicpen, "color": Colors.purple},
    {"name": "Sports", "icon": Iconsax.activity, "color": Colors.orange},
    {"name": "Toys", "icon": Iconsax.game, "color": Colors.teal},
    {"name": "Books", "icon": Iconsax.book, "color": Colors.brown},
    {"name": "Groceries", "icon": Iconsax.shop, "color": Colors.red},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        title: CustomAppBar(
          icon: Iconsax.shopping_bag4,
          hint: 'Search Category...',
          icon2: Iconsax.notification,
          iconText2: 'Notifications',
          iconText: 'Cart',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Browse Categories",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
            const SizedBox(height: 18),
            Expanded(
              child: GridView.builder(
                itemCount: categoryList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 18,
                  crossAxisSpacing: 18,
                  childAspectRatio: 1.2,
                ),
                itemBuilder: (context, index) {
                  final category = categoryList[index];
                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        color: (category["color"] as Color).withAlpha(200),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: (category["color"] as Color).withAlpha(250),
                          width: 1.5,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: category["color"],
                            radius: 28,
                            child: Icon(
                              category["icon"],
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            category["name"],
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
