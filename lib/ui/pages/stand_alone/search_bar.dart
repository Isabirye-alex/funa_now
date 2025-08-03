import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_shop/controllers/products_controller.dart';
import 'package:go_shop/ui/widgets/search_page.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key, this.hint});

  final String? hint;

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      ),
      leading: const Icon(Icons.search, color: Colors.black),
      onChanged: (value) {
        final controller = Get.find<ProductsController>();
        controller.searchProducts(value, context);
      },
      onSubmitted: (value) {
        final controller = Get.find<ProductsController>();
        controller.searchProducts(value, context);
      },
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SearchPage()),
        );
      },
      onTapOutside: (event) {},
      hintText: hint,
      hintStyle: WidgetStateTextStyle.resolveWith(
        (states) => const TextStyle(
          color: Colors.black,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      elevation: WidgetStateProperty.all(2.0),
      backgroundColor: WidgetStateColor.resolveWith((states) => Colors.white),
    );
  }
}
