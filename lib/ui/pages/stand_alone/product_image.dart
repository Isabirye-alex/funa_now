import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_shop/ui/pages/reusables/product_detail.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({super.key, required this.product});

  final dynamic product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetail(
              productId: product.id!,
              description: product.description ?? '',
              price: product.formattedPrice,
              image: product.imageUrl,
              name: product.name,
            ),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
        child: CachedNetworkImage(
          imageUrl: product.imageUrl,
          height: 130,
          width: double.infinity,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            height: 130,
            width: double.infinity,
            color: Colors.grey[300],
            child: const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            height: 130,
            width: double.infinity,
            color: Colors.grey,
            child: const Icon(Icons.broken_image, color: Colors.red),
          ),
        ),
      ),
    );
  }
}
