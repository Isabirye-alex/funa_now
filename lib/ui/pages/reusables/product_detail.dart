import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:go_shop/controllers/cart_controller.dart';
import 'package:go_shop/models/products_model.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({
    super.key,
    required this.description,
    required this.price,
    required this.image,
    required this.name,
    required this.productId,
  });

  final String description;
  final String price;
  final String image;
  final String name;
  final int productId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());
    final double rating = 4.5;
    final int totalReviews = 32;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.network(
                image,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),

            // Product Name
            Text(
              name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            // Price
            Text(
              'UGX $price',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.amber,
              ),
            ),

            const SizedBox(height: 20),

            // Rating bar
            Row(
              children: [
                RatingBarIndicator(
                  rating: rating,
                  itemBuilder: (context, index) =>
                      const Icon(Icons.star, color: Colors.amber),
                  itemCount: 5,
                  itemSize: 24.0,
                  direction: Axis.horizontal,
                ),
                const SizedBox(width: 10),
                Text('($totalReviews reviews)'),
              ],
            ),

            const SizedBox(height: 24),

            // Description
            const Text(
              'Description',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),

            const SizedBox(height: 30),

            // Add to Cart button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  final product = ProductsModel(
                    id: productId,
                    name: name,
                    description: description,
                    price: price,
                    imageUrl: image,
                  );

                  controller.addToCart(product, context);
                  Flushbar(
                    shouldIconPulse: false,
                    borderRadius: BorderRadius.circular(8),
                    margin: EdgeInsets.all(24),
                    flushbarPosition: FlushbarPosition.TOP,
                    animationDuration: const Duration(milliseconds: 300),
                    backgroundColor: const Color.fromARGB(255, 29, 204, 40),
                    messageText: Text(
                      'Success',
                      style: const TextStyle(color: Colors.white),
                    ),
                    duration: const Duration(seconds: 4),
                    icon: Icon(Icons.check_circle, color: Colors.white),
                    titleText: Text(
                      'Item added to cart',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ).show(context);

                  debugPrint('Success');
                },

                icon: const Icon(Icons.shopping_cart),
                label: const Text('Add to Cart'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Reviews Section
            // Reviews Section Title
            const Text(
              'Reviews',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Example Reviews List
            ...List.generate(3, (index) {
              return ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.deepPurple,
                  child: Icon(Icons.person),
                ),
                title: Text(
                  'User ${index + 1}',
                  style: TextStyle(color: Colors.black),
                ),
                subtitle: const Text(
                  'This product exceeded my expectations! The quality is excellent and it arrived very quickly. I would definitely recommend it to anyone looking for a reliable product. Will buy again for sure.',
                  style: TextStyle(color: Colors.white),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
              );
            }),
          ],
        ),
      ),
    );
  }
}
