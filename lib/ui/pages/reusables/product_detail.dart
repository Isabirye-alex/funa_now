import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({
    super.key,
    required this.description,
    required this.price,
    required this.image,
    required this.name,
  });

  final String description;
  final String price;
  final String image;
  final String name;

  @override
  Widget build(BuildContext context) {
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
                  // Add to cart logic
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
