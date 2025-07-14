import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:go_shop/controllers/review_controller.dart';
import 'package:iconsax/iconsax.dart';

class ProductReview extends StatefulWidget {
  final int productId;

  const ProductReview({super.key, required this.productId});

  @override
  State<ProductReview> createState() => _ProductReviewState();
}

class _ProductReviewState extends State<ProductReview> {
  late final int productId;

  double rating = 0.0;
  @override
  void initState() {
    super.initState();
    productId = widget.productId;
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReviewController());
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Rat this product',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          RatingBar.builder(
            initialRating: 0,
            minRating: 1,
            allowHalfRating: true,
            itemCount: 5,
            itemBuilder: (context, __) {
              return Icon(Icons.star, color: Colors.amber);
            },
            onRatingUpdate: (rating) => setState(() {
              controller.rating.value = rating;
            }),
          ),
          SizedBox(height: 10),
          TextField(
            controller: controller.commentController,
            maxLines: 4,
            decoration: InputDecoration(
              labelText: 'Write Your review',
              border: OutlineInputBorder(),
            ),
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: () async {
              controller.postReview(widget.productId);
            },
            icon: Icon(Iconsax.send, color: Colors.blue),
            label: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
