import 'package:flutter/material.dart';

class CirclePainter extends CustomPainter {
  final double strokeWidth;
  final double radius;
  final Offset offset;

  CirclePainter(this.strokeWidth, this.radius, this.offset);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = const Color.fromRGBO(201, 85, 42, 1.0)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round;

    canvas.drawCircle(offset, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
