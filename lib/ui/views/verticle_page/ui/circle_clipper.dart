import 'package:flutter/material.dart';

class CircleClipper extends CustomClipper<Path> {
  final double radius;
  final Offset offset;

  CircleClipper(this.radius, this.offset);
  @override
  getClip(Size size) {
    var path = Path();
    path.addOval(Rect.fromCircle(center: offset, radius: radius));
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }
}
