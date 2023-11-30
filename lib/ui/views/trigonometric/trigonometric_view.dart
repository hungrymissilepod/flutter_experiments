import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:statsfl/statsfl.dart';

import 'trigonometric_viewmodel.dart';

class TrigonometricView extends StackedView<TrigonometricViewModel> {
  const TrigonometricView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    TrigonometricViewModel viewModel,
    Widget? child,
  ) {
    return const TrigonometricDemo();
  }

  @override
  TrigonometricViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      TrigonometricViewModel();
}

// This could have been a list of colors, I just picked the list off another project of mine
var ColorList = [
  //ColorInfo("black", Colors.black, Colors.black.toString()),
  ColorInfo("red", Colors.red, Colors.red[500].toString()),
  ColorInfo("green", Colors.green, Colors.green[500].toString()),
  ColorInfo("blue", Colors.blue, Colors.blue[500].toString()),
  ColorInfo("yellow", Colors.yellow, Colors.yellow[500].toString()),
  ColorInfo("purple", Colors.purple, Colors.purple[500].toString()),
  ColorInfo("amber", Colors.amber, Colors.amber[500].toString()),
  ColorInfo("cyan", Colors.cyan, Colors.cyan[500].toString()),
  ColorInfo("grey", Colors.grey, Colors.grey[500].toString()),
  ColorInfo("teal", Colors.teal, Colors.teal[500].toString()),
  ColorInfo("pink", Colors.pink, Colors.pink[500].toString()),
  ColorInfo("orange", Colors.orange, Colors.orange[500].toString()),
  //ColorInfo("white", Colors.white, Colors.white.toString()),
  //ColorInfo("transparent", Colors.transparent, Colors.transparent.toString()),
];

class ColorInfo {
  String name;
  MaterialColor color;
  String hex;

  ColorInfo(this.name, this.color, this.hex);
}

class TrigonometricDemo extends StatefulWidget {
  const TrigonometricDemo({super.key});

  @override
  State<TrigonometricDemo> createState() => _TrigonometricDemoState();
}

class _TrigonometricDemoState extends State<TrigonometricDemo> {
  double iter = 0.0;

  // Choose a random color for this iteration
  var colors = List.generate(20, (index) => ColorList[Random().nextInt(ColorList.length)]);

  Timer? _timer;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _schedule() async {
    _timer = Timer(const Duration(seconds: 1), () async {
      _tick();
    });
  }

  void _tick() async {
    for (int i = 0; i < 200; i++) {
      setState(() {
        iter = iter + 0.00001;
      });
      await Future.delayed(const Duration(milliseconds: 50));
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomPaint(
            painter: DemoPainter(iter, colors),
            child: Container(),
          ),
          SafeArea(
            child: StatsFl(),
          ),
        ],
      ),
    );
  }
}

class DemoPainter extends CustomPainter {
  double iter;
  List<ColorInfo> colors;

  @override
  void paint(Canvas canvas, Size size) {
    renderDrawing(canvas, size);
  }

  void renderDrawing(Canvas canvas, Size size) {
    canvas.drawPaint(Paint()..color = Colors.black87);

    renderStructure2(canvas, size, iter, colors, 9);
  }

  void renderStructure2(Canvas canvas, Size size, double iter, List<ColorInfo> colors, int totalIter) {
    for (int j = 0; j < totalIter; j++) {
      double distance = 0.0;
      double tempIter = totalIter - j + iter;

      // We draw a LOT of points
      for (double i = 0; i < 80; i = i + 0.01) {
        canvas.drawCircle(
          Offset(
            (size.width / 2) + (distance * cos(distance) * sin(distance) * atan(distance)),
            (size.height / 2) + (distance * cos(distance) * sin(distance) * tan(distance)),
          ),

          // Change this for changing radius in different iterations
          5.0 - (0.5 * (totalIter - tempIter)),

          // Well... color
          Paint()..color = colors[j].color,
        );

        // Change the "0.1" for varying point distances
        distance = distance + (0.2 + (0.1 * totalIter - tempIter));
      }
    }
  }

  @override
  bool shouldRepaint(DemoPainter oldDelegate) {
    return iter != oldDelegate.iter;
  }

  DemoPainter(this.iter, this.colors);
}
