import 'package:flutter/material.dart';

class CustomShape extends CustomClipper<Path>{
  @override
  getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);

    final firstCurve = Offset(0, size.height-20);
    final secondCurve = Offset(30, size.height-20);
    path.quadraticBezierTo(firstCurve.dx, firstCurve.dy, secondCurve.dx, secondCurve.dy);

    final secondFirstCurve = Offset(0, size.height-20);
    final secondLastCurve = Offset(size.width-30, size.height-20);
    path.quadraticBezierTo(secondFirstCurve.dx, secondFirstCurve.dy, secondLastCurve.dx, secondLastCurve.dy);


    final thirdFirstCurve = Offset(size.width, size.height -20);
    final thirdSecondCurve = Offset(size.width, size.height);
    path.quadraticBezierTo(thirdFirstCurve.dx, thirdFirstCurve.dy, thirdSecondCurve.dx, thirdSecondCurve.dy);

    path.lineTo(size.width, 0);
    return path;

  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }

}