import 'package:flutter/material.dart';
import 'package:go_shop/ui/pages/reusables/circular_container.dart';
import 'custom_shape.dart';

class Shape extends StatelessWidget {
  const Shape({super.key, required this.height, this.child});
  final double height;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomShape(),
      child: Container(
        decoration: BoxDecoration(color: Colors.grey),
        height: height,
        width: double.infinity,
        child: Stack(
          children: [
            ACircularContainer(
              height: 400,
              width: 400,
              color: Colors.lightBlue,
              radius: 400,
              top: -150,
              right: -170,
            ),
            ACircularContainer(
              height: 400,
              width: 400,
              color: Colors.lightBlueAccent,
              radius: 400,
              top: 100,
              right: -300,
            ),
            child!,
          ],
        ),
      ),
    );
  }
}
