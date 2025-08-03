import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_shop/controllers/wishlist_controller.dart';

class WishlistIconButton extends StatelessWidget {
  const WishlistIconButton({
    super.key,
    this.icon,
    this.iconText,
    this.color,
    this.onTap,
  });

  final IconData? icon;
  final String? iconText;
  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WishlistController>();
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(14)),
          child: Column(
            children: [
              Stack(
                children: [
                  Icon(icon, color: color),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Obx(
                      () => Text(
                        '${controller.items.length}',
                        style: TextStyle(color: Colors.amber.shade300),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Text(
                  iconText ?? '',
                  style: const TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
