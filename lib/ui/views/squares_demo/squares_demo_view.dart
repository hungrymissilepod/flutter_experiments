import 'dart:math';
import 'dart:ui';

import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_template/ui/views/squares_demo/ui/custom_slider.dart';
import 'package:stacked/stacked.dart';

import 'squares_demo_viewmodel.dart';

class SquaresDemoView extends StackedView<SquaresDemoViewModel> {
  const SquaresDemoView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SquaresDemoViewModel viewModel,
    Widget? child,
  ) {
    return const SquaresDemo();
  }

  @override
  SquaresDemoViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SquaresDemoViewModel();
}

class SquaresDemo extends StatefulWidget {
  const SquaresDemo({super.key});

  @override
  State<SquaresDemo> createState() => _SquaresDemoState();
}

class _SquaresDemoState extends State<SquaresDemo> {
  double sideLength = 80;
  double strokeWidth = 2;
  double gap = 30;
  double minSquareSideFraction = 0.2;
  double saturation = 0.7;
  double lightness = 0.5;
  bool enabledColors = true;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: size.height * 0.75,
              child: RepaintBoundary(
                child: CustomPaint(
                  painter: SquareCustomPainter(
                    sideLength: sideLength,
                    strokeWidth: strokeWidth,
                    gap: gap,
                    minSquareSideFraction: minSquareSideFraction,
                    saturation: saturation,
                    lightness: lightness,
                    enableColors: enabledColors,
                  ),
                  child: Container(),
                ),
              ),
            ),
            Expanded(
              child: Scrollbar(
                child: ListView(
                  physics: AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    PaddedColumn(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomSlider(
                          label: 'Side Length',
                          value: sideLength,
                          min: 10,
                          max: 120,
                          onChanged: (value) {
                            setState(() {
                              sideLength = value;
                            });
                          },
                        ),
                        CustomSlider(
                          label: 'Stroke Width',
                          value: strokeWidth,
                          min: 0.1,
                          max: 10.0,
                          onChanged: (value) {
                            setState(() {
                              strokeWidth = value;
                            });
                          },
                        ),
                        CustomSlider(
                          label: 'Gap',
                          value: gap,
                          min: -20,
                          max: 60,
                          onChanged: (value) {
                            setState(() {
                              gap = value;
                            });
                          },
                        ),
                        CustomSlider(
                          label: 'Min Square Side Fraction',
                          value: minSquareSideFraction,
                          min: 0.01,
                          max: 1.0,
                          onChanged: (value) {
                            setState(() {
                              minSquareSideFraction = value;
                            });
                          },
                        ),
                        CustomSlider(
                          label: 'Saturation',
                          value: saturation,
                          min: 0.0,
                          max: 1.0,
                          onChanged: (value) {
                            setState(() {
                              saturation = value;
                            });
                          },
                        ),
                        CustomSlider(
                          label: 'Lightness',
                          value: lightness,
                          min: 0.0,
                          max: 1.0,
                          onChanged: (value) {
                            setState(() {
                              lightness = value;
                            });
                          },
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Enabled Colors: ${enabledColors}'),
                            Switch(
                              value: enabledColors,
                              onChanged: (value) {
                                setState(() {
                                  enabledColors = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SquareCustomPainter extends CustomPainter {
  SquareCustomPainter({
    this.sideLength = 80,
    this.strokeWidth = 2,
    this.gap = 30,
    this.minSquareSideFraction = 0.2,
    this.saturation = 0.7,
    this.lightness = 0.5,
    this.enableColors = true,
  }) : minSideLength = sideLength * minSquareSideFraction;

  final double sideLength;
  final double strokeWidth;
  final double gap;
  final double minSideLength;
  final double minSquareSideFraction;
  final double lightness;
  final double saturation;
  final bool enableColors;

  final Random random = Random();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    /// Calculate number of squares that can fit horizontally and vertically
    final xCount = ((size.width + gap) / (sideLength + gap)).floor();
    final yCount = ((size.height + gap) / (sideLength + gap)).floor();

    /// Calculate the size of the grid of squares
    final contentSize = Size(
      (xCount * sideLength) + ((xCount - 1) * gap),
      (yCount * sideLength) + ((yCount - 1) * gap),
    );

    /// Calculate the offset from which we should start painting
    /// the grid so that it is is eventually centered
    final offset = Offset(
      (size.width - contentSize.width) / 2,
      (size.height - contentSize.height) / 2,
    );

    final totalCount = xCount * yCount;

    canvas.save();
    canvas.translate(offset.dx, offset.dy);

    /// Randomise depth
    final depth = random.nextInt(5) + 5;

    for (int index = 0; index < totalCount; index++) {
      int i = index ~/ yCount;
      int j = index % yCount;

      drawNestedSquares(
        canvas,
        Offset(
          (i * (sideLength + gap)),
          (j * (sideLength + gap)),
        ),
        sideLength,
        paint,
        depth,
      );
    }
    canvas.restore();
  }

  void drawNestedSquares(
    Canvas canvas,
    Offset start,
    double sideLength,
    Paint paint,
    int depth,
  ) {
    if (sideLength < minSideLength || depth <= 0) return;

    if (enableColors) {
      paint.color = HSLColor.fromAHSL(
        1,
        random.nextInt(360).toDouble(),
        saturation,
        lightness,
      ).toColor();
    }

    canvas.drawRect(
      Rect.fromLTWH(
        start.dx,
        start.dy,
        sideLength,
        sideLength,
      ),
      paint,
    );

    /// Calculate the side length for the next square
    final nextSideLength = sideLength * (random.nextDouble() * 0.5 + 0.5);

    final nextStart = Offset(
      start.dx + sideLength / 2 - nextSideLength / 2,
      start.dy + sideLength / 2 - nextSideLength / 2,
    );

    /// Recursively call this method to draw another square
    drawNestedSquares(canvas, nextStart, nextSideLength, paint, depth - 1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
