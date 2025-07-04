import 'package:flutter/material.dart';

class ACircularContainer extends StatelessWidget {
  const ACircularContainer({
    super.key,
    required this.height,
    required this.width,
    required this.color,
    required this.radius,
    this.top,
    this.right,
  });
  final double height;
  final double width;
  final Color color;
  final double radius;
  final double? top;
  final double? right;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      right: right,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius),
        ),
        height: 400,
        width: 400,
      ),
    );
  }
}
