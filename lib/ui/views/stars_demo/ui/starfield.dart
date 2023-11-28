import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_template/ui/views/stars_demo/models/star.dart';
import 'package:flutter_app_template/ui/views/stars_demo/ui/starfield_painter.dart';

class StarField extends StatefulWidget {
  const StarField({super.key, this.starSpeed = 3, this.starCount = 500});

  final double starSpeed;
  final int starCount;

  @override
  State<StarField> createState() => _StarFieldState();
}

class _StarFieldState extends State<StarField> {
  List<Star> stars = [];
  ui.Image? glowImage;
  double maxZ = 500;
  double minZ = 1;

  Ticker? ticker;

  @override
  void initState() {
    super.initState();
    _loadGlowImage();

    for (int i = 0; i < widget.starCount; i++) {
      var s = _randomiseStar(true);
      stars.add(s);
    }
    ticker = Ticker(_handleStarTick)..start();
  }

  Future<void> _loadGlowImage() async {
    final ByteData data = await rootBundle.load('assets/stars/glow.png');
    ui.decodeImageFromList(Uint8List.view(data.buffer), (img) => glowImage = img);
  }

  void _handleStarTick(Duration duration) {
    setState(() {
      advanceStars(widget.starSpeed);
    });
  }

  @override
  void dispose() {
    ticker?.dispose();
    super.dispose();
  }

  void advanceStars(double distance) {
    for (int i = 0; i < stars.length; i++) {
      stars[i].z -= distance;
      if (stars[i].z < minZ) {
        stars[i] = _randomiseStar(false);
      } else if (stars[i].z > maxZ) {
        stars[i].z = minZ;
      }
    }
  }

  Star _randomiseStar(bool randomZ) {
    Star star = Star();
    Random rand = Random();

    /// randomly distribute stars on screen
    star.x = (-1 + rand.nextDouble() * 2) * 75;
    star.y = (-1 + rand.nextDouble() * 2) * 75;
    star.z = randomZ ? rand.nextDouble() * maxZ : maxZ;
    star.rotation = rand.nextDouble() * pi * 2;

    final double colorRand = rand.nextDouble();
    if (colorRand < 0.05) {
      star.color = Colors.red;
      star.size = 3 + rand.nextDouble() * 2;
    } else if (colorRand < 0.1) {
      star.color = const Color(0xffD4A1FF);
      star.size = 2 + rand.nextDouble() * 2;
    } else {
      star.color = Colors.white;
      star.size = .5 + rand.nextDouble() * 2;
    }
    return star;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black,
      child: CustomPaint(
        painter: StarFieldPainter(
          stars,
          glowImage,
        ),
      ),
    );
  }
}
