import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app_template/ui/views/stars_demo/models/star.dart';
import 'dart:ui' as ui;

class StarFieldPainter extends CustomPainter {
  final List<Star> stars;
  final ui.Image? glowImage;

  StarFieldPainter(this.stars, this.glowImage);

  @override
  void paint(Canvas canvas, Size size) {
    if (stars.isEmpty) return;
    canvas.translate(size.width / 2, size.height / 2);

    var paint = Paint()..color = Colors.white;

    for (int i = 0; i < stars.length; i++) {
      var scale = .1 + map(stars[i].z, 0, size.width, stars[i].size, 0);
      var sx = map(stars[i].x / stars[i].z, 0, 1, 0, size.width);
      var sy = map(stars[i].y / stars[i].z, 0, 1, 0, size.height);
      var time = DateTime.now().millisecondsSinceEpoch / 200;
      paint.color = stars[i].color;
      var pos = Offset(sx, sy);
      canvas.drawCircle(pos, scale, paint);
      if (glowImage != null && stars[i].color != Colors.white) {
        if (stars[i].color == Colors.red) {
          var glowSizeX = scale * 6 + 2 * (sin(time * .25));
          var glowSizeY = scale * 6 + 2 * (cos(time * .150));
          var src = Rect.fromPoints(Offset.zero, Offset(glowImage!.width.toDouble(), glowImage!.height.toDouble()));
          var rect = Rect.fromCenter(center: pos, width: glowSizeX, height: glowSizeY);
          canvas.drawImageRect(glowImage!, src, rect, paint);
        } else {
          var glowSizeX = scale * 8 + 2 * (sin(time * .5));
          var glowSizeY = scale * 8 + 2 * (cos(time * .75));
          var src = Rect.fromPoints(Offset.zero, Offset(glowImage!.width.toDouble(), glowImage!.height.toDouble()));
          var rect = Rect.fromCenter(center: pos, width: glowSizeX, height: glowSizeY);
          canvas.drawImageRect(glowImage!, src, rect, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  double map(double value, double from1, double to1, double from2, double to2) {
    return (value - from1) / (to1 - from1) * (to2 - from2) + from2;
  }
}
