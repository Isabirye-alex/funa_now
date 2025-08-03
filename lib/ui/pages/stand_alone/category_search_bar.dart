import 'package:flutter/material.dart';
import 'package:go_shop/ui/pages/stand_alone/cart_icon_button.dart';
import 'package:go_shop/ui/pages/stand_alone/search_bar.dart';
import 'package:go_shop/ui/pages/stand_alone/wishlist_icon.dart';

class CategorySearchBar extends StatelessWidget {
  const CategorySearchBar({
    super.key,
    this.hint,
    required this.icon,
    this.icon2,
    this.iconText,
    this.iconText2,
    this.color,
    this.onTap1,
    this.onTap2,
    this.items,
  });

  final String? hint;
  final IconData icon;
  final IconData? icon2;
  final String? iconText;
  final String? iconText2;
  final Color? color;
  final VoidCallback? onTap1;
  final VoidCallback? onTap2;
  final int? items;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            WishlistIconButton(
              icon: icon2,
              iconText: iconText2,
              color: color,
              onTap: onTap1,
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SearchBarWidget(hint: hint),
              ),
            ),
            CartIconButton(icon: icon, iconText: iconText, onTap: onTap2),
          ],
        ),
        const SizedBox(height: 18),
      ],
    );
  }
}
