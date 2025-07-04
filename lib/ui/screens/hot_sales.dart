import 'package:flutter/material.dart';
import 'package:go_shop/ui/pages/reusables/custom_app_bar.dart';
import 'package:iconsax/iconsax.dart';

class HotSales extends StatelessWidget {
  const HotSales({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> hotSalesList = [
      {
        "title": "Wireless Headphones",
        "image":
            "https://res.cloudinary.com/doxivkfxr/image/upload/v1751547241/products/aelysxt8osxxbsxamhts.jpg",
        "price": 59.99,
        "oldPrice": 89.99,
        "discount": "33% OFF",
      },
      {
        "title": "Smart Watch",
        "image":
            "https://res.cloudinary.com/doxivkfxr/image/upload/v1751547241/products/aelysxt8osxxbsxamhts.jpg",
        "price": 99.99,
        "oldPrice": 149.99,
        "discount": "34% OFF",
      },
      {
        "title": "Sneakers",
        "image":
            "https://res.cloudinary.com/doxivkfxr/image/upload/v1751547241/products/aelysxt8osxxbsxamhts.jpg",
        "price": 49.99,
        "oldPrice": 79.99,
        "discount": "38% OFF",
      },
      {
        "title": "Bluetooth Speaker",
        "image":
            "https://res.cloudinary.com/doxivkfxr/image/upload/v1751547241/products/aelysxt8osxxbsxamhts.jpg",
        "price": 29.99,
        "oldPrice": 49.99,
        "discount": "40% OFF",
      },
      {
        "title": "Bluetooth Speaker",
        "image":
            "https://res.cloudinary.com/doxivkfxr/image/upload/v1751547241/products/aelysxt8osxxbsxamhts.jpg",
        "price": 29.99,
        "oldPrice": 49.99,
        "discount": "40% OFF",
      },
      {
        "title": "Bluetooth Speaker",
        "image":
            "https://res.cloudinary.com/doxivkfxr/image/upload/v1751547241/products/aelysxt8osxxbsxamhts.jpg",
        "price": 29.99,
        "oldPrice": 49.99,
        "discount": "40% OFF",
      },
      {
        "title": "Bluetooth Speaker",
        "image":
            "https://res.cloudinary.com/doxivkfxr/image/upload/v1751547241/products/aelysxt8osxxbsxamhts.jpg",
        "price": 29.99,
        "oldPrice": 49.99,
        "discount": "40% OFF",
      },
      {
        "title": "Bluetooth Speaker",
        "image":
            "https://res.cloudinary.com/doxivkfxr/image/upload/v1751547241/products/aelysxt8osxxbsxamhts.jpg",
        "price": 29.99,
        "oldPrice": 49.99,
        "discount": "40% OFF",
      },
      {
        "title": "Bluetooth Speaker",
        "image":
            "https://res.cloudinary.com/doxivkfxr/image/upload/v1751547241/products/aelysxt8osxxbsxamhts.jpg",
        "price": 29.99,
        "oldPrice": 49.99,
        "discount": "40% OFF",
      },
      {
        "title": "Bluetooth Speaker",
        "image":
            "https://res.cloudinary.com/doxivkfxr/image/upload/v1751547241/products/aelysxt8osxxbsxamhts.jpg",
        "price": 29.99,
        "oldPrice": 49.99,
        "discount": "40% OFF",
      },
      {
        "title": "Bluetooth Speaker",
        "image":
            "https://res.cloudinary.com/doxivkfxr/image/upload/v1751547241/products/aelysxt8osxxbsxamhts.jpg",
        "price": 29.99,
        "oldPrice": 49.99,
        "discount": "40% OFF",
      },
      {
        "title": "Bluetooth Speaker",
        "image":
            "https://res.cloudinary.com/doxivkfxr/image/upload/v1751547241/products/aelysxt8osxxbsxamhts.jpg",
        "price": 29.99,
        "oldPrice": 49.99,
        "discount": "40% OFF",
      },
      {
        "title": "Bluetooth Speaker",
        "image":
            "https://res.cloudinary.com/doxivkfxr/image/upload/v1751547241/products/aelysxt8osxxbsxamhts.jpg",
        "price": 29.99,
        "oldPrice": 49.99,
        "discount": "40% OFF",
      },
      {
        "title": "Bluetooth Speaker",
        "image":
            "https://res.cloudinary.com/doxivkfxr/image/upload/v1751547241/products/aelysxt8osxxbsxamhts.jpg",
        "price": 29.99,
        "oldPrice": 49.99,
        "discount": "40% OFF",
      },
      {
        "title": "Bluetooth Speaker",
        "image":
            "https://res.cloudinary.com/doxivkfxr/image/upload/v1751547241/products/aelysxt8osxxbsxamhts.jpg",
        "price": 29.99,
        "oldPrice": 49.99,
        "discount": "40% OFF",
      },
      {
        "title": "Bluetooth Speaker",
        "image":
            "https://res.cloudinary.com/doxivkfxr/image/upload/v1751547241/products/aelysxt8osxxbsxamhts.jpg",
        "price": 29.99,
        "oldPrice": 49.99,
        "discount": "40% OFF",
      },
      {
        "title": "Bluetooth Speaker",
        "image":
            "https://res.cloudinary.com/doxivkfxr/image/upload/v1751547241/products/aelysxt8osxxbsxamhts.jpg",
        "price": 29.99,
        "oldPrice": 49.99,
        "discount": "40% OFF",
      },
      {
        "title": "Bluetooth Speaker",
        "image":
            "https://res.cloudinary.com/doxivkfxr/image/upload/v1751547241/products/aelysxt8osxxbsxamhts.jpg",
        "price": 29.99,
        "oldPrice": 49.99,
        "discount": "40% OFF",
      },
      {
        "title": "Bluetooth Speaker",
        "image":
            "https://res.cloudinary.com/doxivkfxr/image/upload/v1751547241/products/aelysxt8osxxbsxamhts.jpg",
        "price": 29.99,
        "oldPrice": 49.99,
        "discount": "40% OFF",
      },
      {
        "title": "Bluetooth Speaker",
        "image":
            "https://res.cloudinary.com/doxivkfxr/image/upload/v1751547241/products/aelysxt8osxxbsxamhts.jpg",
        "price": 29.99,
        "oldPrice": 49.99,
        "discount": "40% OFF",
      },
      {
        "title": "Bluetooth Speaker",
        "image":
            "https://res.cloudinary.com/doxivkfxr/image/upload/v1751547241/products/aelysxt8osxxbsxamhts.jpg",
        "price": 29.99,
        "oldPrice": 49.99,
        "discount": "40% OFF",
      },
      {
        "title": "Bluetooth Speaker",
        "image":
            "https://res.cloudinary.com/doxivkfxr/image/upload/v1751547241/products/aelysxt8osxxbsxamhts.jpg",
        "price": 29.99,
        "oldPrice": 49.99,
        "discount": "40% OFF",
      },
      {
        "title": "Bluetooth Speaker",
        "image":
            "https://res.cloudinary.com/doxivkfxr/image/upload/v1751547241/products/aelysxt8osxxbsxamhts.jpg",
        "price": 29.99,
        "oldPrice": 49.99,
        "discount": "40% OFF",
      },
      {
        "title": "Bluetooth Speaker",
        "image":
            "https://res.cloudinary.com/doxivkfxr/image/upload/v1751547241/products/aelysxt8osxxbsxamhts.jpg",
        "price": 29.99,
        "oldPrice": 49.99,
        "discount": "40% OFF",
      },
      {
        "title": "Bluetooth Speaker",
        "image":
            "https://res.cloudinary.com/doxivkfxr/image/upload/v1751547241/products/aelysxt8osxxbsxamhts.jpg",
        "price": 29.99,
        "oldPrice": 49.99,
        "discount": "40% OFF",
      },
      {
        "title": "Bluetooth Speaker",
        "image":
            "https://res.cloudinary.com/doxivkfxr/image/upload/v1751547241/products/aelysxt8osxxbsxamhts.jpg",
        "price": 29.99,
        "oldPrice": 49.99,
        "discount": "40% OFF",
      },
      {
        "title": "Bluetooth Speaker",
        "image":
            "https://res.cloudinary.com/doxivkfxr/image/upload/v1751547241/products/aelysxt8osxxbsxamhts.jpg",
        "price": 29.99,
        "oldPrice": 49.99,
        "discount": "40% OFF",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        title: CustomAppBar(
          icon: Iconsax.trend_up,
          hint: 'Browse Hot deals....',
          iconText: 'Hot Sales',
          icon2: Iconsax.flash_1,
          iconText2: 'New Stock',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "🔥 Today's Hot Sales",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.red[700],
              ),
            ),
            const SizedBox(height: 18),
            Expanded(
              child: GridView.builder(
                itemCount: hotSalesList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 18,
                  crossAxisSpacing: 18,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  final item = hotSalesList[index];
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(18),
                              ),
                              child: Image.network(
                                item["image"],
                                height: 110,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item["title"],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Text(
                                        "\$${item["price"]}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.red[700],
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        "\$${item["oldPrice"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // Discount badge
                        Positioned(
                          top: 12,
                          left: 12,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red[700],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              item["discount"],
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                        // Favorite icon
                        Positioned(
                          top: 12,
                          right: 12,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(color: Colors.black12, blurRadius: 4),
                              ],
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.favorite_border,
                                color: Colors.red,
                              ),
                              onPressed: () {},
                              iconSize: 22,
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                            ),
                          ),
                        ),
                      ],
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
