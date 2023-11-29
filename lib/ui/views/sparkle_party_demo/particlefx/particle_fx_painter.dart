import 'package:flutter/material.dart';
import 'package:flutter_app_template/ui/views/sparkle_party_demo/particlefx/particle_fx.dart';

class ParticleFXPainter extends CustomPainter {
  ParticleFX fx;

  ParticleFXPainter({required this.fx}) : super(repaint: fx);

  @override
  void paint(Canvas canvas, Size size) {
    if (fx.vertices == null) return;

    Paint paint = Paint()
      ..shader = ImageShader(
        fx.spriteSheet.image!,
        TileMode.clamp,
        TileMode.clamp,
        Matrix4.identity().storage,
      );
    canvas.drawVertices(fx.vertices!, BlendMode.dstIn, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
