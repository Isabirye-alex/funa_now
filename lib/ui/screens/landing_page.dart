import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

//Landing where app users are directed on opening the application
class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        children: [
                          Icon(Iconsax.notification),
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Text(
                              'Notifications',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: SearchBar(
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      leading: Icon(Icons.search, color: Colors.black),
                      onChanged: (value) {},
                      onSubmitted: (value) {},
                      onTap: () {},
                      onTapOutside: (event) {},
                      hintText: 'Search product....',
                      hintStyle: WidgetStateTextStyle.resolveWith(
                        (states) => TextStyle(
                          color: Colors.black,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      elevation: WidgetStateProperty.all(2.0),
                      backgroundColor: WidgetStateColor.resolveWith(
                        (states) => Colors.white,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        children: [
                          Icon(Iconsax.shopping_bag4),
                          Text(
                            'Cart',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 18),
          ],
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          top: 90,
          left: 16,
          right: 16,
          bottom: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome to Funa Now",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Colors.blue[700],
                image: DecorationImage(
                  image: NetworkImage(
                    "https://res.cloudinary.com/doxivkfxr/image/upload/v1751547241/products/aelysxt8osxxbsxamhts.jpg",
                  ),
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
                    "Big Summer Sale!\nUp to 50% OFF",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      shadows: [Shadow(color: Colors.black45, blurRadius: 4)],
                    ),
                  ),
                ),
              ),
            ),
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
            SizedBox(
              height: 140,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                separatorBuilder: (_, __) => SizedBox(width: 12),
                itemBuilder: (context, index) => Container(
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Iconsax.bag, size: 40, color: Colors.blue[700]),
                      SizedBox(height: 8),
                      Text(
                        "Product ${index + 1}",
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "\$${(20 + index * 5)}",
                        style: TextStyle(
                          color: Colors.blue[700],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
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
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: List.generate(
                20,
                (index) => Chip(
                  label: Text(
                    [
                      "Electronics",
                      "Fashion",
                      "Home",
                      "Beauty",
                      "Electronics",
                      "Fashion",
                      "Home",
                      "Beauty",
                      "Electronics",
                      "Fashion",
                      "Home",
                      "Beauty",
                      "Electronics",
                      "Fashion",
                      "Home",
                      "Beauty",
                      "Electronics",
                      "Fashion",
                      "Home",
                      "Beauty",
                    ][index],
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.green,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
