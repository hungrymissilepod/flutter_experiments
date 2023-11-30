import 'package:flutter/material.dart';
import 'package:flutter_app_template/ui/views/verticle_page/ui/circle_clipper.dart';
import 'package:flutter_app_template/ui/views/verticle_page/ui/circle_painter.dart';
import 'dart:math';
import 'package:flutter_app_template/ui/views/verticle_page/ui/verticle_page.dart';
import 'package:stacked/stacked.dart';

import 'verticle_page_viewmodel.dart';

class VerticlePageView extends StackedView<VerticlePageViewModel> {
  const VerticlePageView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    VerticlePageViewModel viewModel,
    Widget? child,
  ) {
    return const VerticlePageDemoWidget(
      pages: [
        VerticlePage(index: 0),
        VerticlePage(index: 1),
        VerticlePage(index: 2),
        VerticlePage(index: 3),
        VerticlePage(index: 4),
        VerticlePage(index: 5),
      ],
    );
  }

  @override
  VerticlePageViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      VerticlePageViewModel();
}

class VerticlePageDemoWidget extends StatefulWidget {
  const VerticlePageDemoWidget({
    super.key,
    required this.pages,
  });

  final List<Widget> pages;

  @override
  State<VerticlePageDemoWidget> createState() => _VerticlePageDemoWidgetState();
}

class _VerticlePageDemoWidgetState extends State<VerticlePageDemoWidget>
    with TickerProviderStateMixin {
  int currentPage = 0;

  /// Animation for the new page that animates on screen
  late Animation<double> pageAnimation;
  late AnimationController pageAnimationController;

  /// Circle radius animation
  late Animation<double> circleRadiusAnimation;
  late AnimationController circleRadiusAnimationController;

  /// Circle size animation
  late Animation<double> circleSizeAnimation;
  late AnimationController circleSizeAnimationController;

  final Tween<double> circleSizeTween = Tween(begin: 0, end: 2000);

  static const Offset logoOffset = Offset(20, 60);
  static const double logoWidth = 100;
  Offset circleOffset =
      Offset(logoOffset.dx + (logoWidth / 2), logoOffset.dy + (logoWidth / 2));

  /// Have we already cycled through all pages?
  /// Need this to fix an edge case where the wrong image is displayed
  /// in the background when re-starting the cycle
  bool hasCycledPages = false;

  @override
  void initState() {
    super.initState();

    /// All animations have same duration
    pageAnimationController = circleRadiusAnimationController =
        circleSizeAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    pageAnimation =
        CurvedAnimation(parent: pageAnimationController, curve: Curves.easeIn);

    circleRadiusAnimation =
        circleSizeTween.animate(circleRadiusAnimationController);
    circleSizeAnimation =
        circleSizeTween.animate(circleSizeAnimationController);
  }

  @override
  void dispose() {
    pageAnimationController.dispose();
    circleRadiusAnimationController.dispose();
    circleSizeAnimationController.dispose();
    super.dispose();
  }

  void onPageChanged(int value) {
    currentPage = value;
  }

  int previousPage() {
    int prevPage = currentPage - 1;
    if (prevPage < 0) {
      if (hasCycledPages) {
        prevPage = widget.pages.length - 1;
      } else {
        prevPage = 0;
      }
    }
    return prevPage;
  }

  void onPressed() {
    setState(() {
      currentPage++;
      if (currentPage > widget.pages.length - 1) {
        /// set [hasCycledPages] so that we can fix edge case where background image was displayed incorrectly
        hasCycledPages = true;
        currentPage = 0;
      }
    });

    pageAnimationController.reset();
    circleRadiusAnimationController.reset();
    circleSizeAnimationController.reset();

    pageAnimationController.forward();
    circleRadiusAnimationController.forward();
    circleSizeAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        onPressed: onPressed,
        child: Transform.rotate(
          angle: -pi / 4,
          child: const Icon(
            Icons.arrow_circle_down_sharp,
            size: 60,
          ),
        ),
      ),
      body: Stack(
        children: [
          /// Display previous page in background so that we see the clipper change current page
          widget.pages[previousPage()],

          /// Clipper to show the new page
          AnimatedBuilder(
            animation: pageAnimation,
            builder: (context, index) {
              return ClipPath(
                clipper: CircleClipper(circleSizeAnimation.value, circleOffset),
                child: widget.pages[currentPage],
              );
            },
          ),

          /// Circle animation
          AnimatedBuilder(
            animation: circleRadiusAnimation,
            builder: (context, child) {
              return CustomPaint(
                painter: CirclePainter(circleRadiusAnimation.value,
                    circleSizeAnimation.value, circleOffset),
                child: Container(),
              );
            },
          ),

          /// Logo
          Positioned(
            left: logoOffset.dx,
            top: logoOffset.dy,
            child: const Image(
              width: logoWidth,
              height: logoWidth,
              image: AssetImage(
                'assets/verticle_pages/logo.png',
              ),
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
