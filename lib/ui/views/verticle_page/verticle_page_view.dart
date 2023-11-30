import 'package:flutter/material.dart';
import 'package:flutter_app_template/ui/views/verticle_page/ui/circular_reveal_animation.dart';
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
    return VerticlePageDemoWidget(
      pages: [
        VerticlePage(index: 1),
        VerticlePage(index: 2),
        VerticlePage(index: 3),
        VerticlePage(index: 4),
        VerticlePage(index: 5),
        VerticlePage(index: 6),
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

class _VerticlePageDemoWidgetState extends State<VerticlePageDemoWidget> with TickerProviderStateMixin {
  PageController? pageController;
  int currentPage = 0;

  AnimationController? animationController;
  late Animation<double> animation;

  late Animation<double> circleAnimation;
  AnimationController? circleAnimationController;

  Tween<double> _strokeTween = Tween(begin: 0, end: 2000);
  Tween<double> _sizeTween = Tween(begin: 0, end: 2000);

  late Animation<double> circleSizeAnimation;
  AnimationController? circleSizeAnimationController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();

    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );

    circleAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 900));

    circleSizeAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 900));

    animation = CurvedAnimation(parent: animationController!, curve: Curves.easeIn);

    circleAnimation = _strokeTween.animate(circleAnimationController!)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          circleAnimationController?.reset();
        }
      });

    circleSizeAnimation = _sizeTween.animate(circleSizeAnimationController!)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          circleSizeAnimationController?.reset();
        }
      });

    // circleSizeAnimation = CurvedAnimation(parent: circleSizeAnimationController!, curve: Curves.easeIn)
    //   ..addStatusListener((status) {
    //     if (status == AnimationStatus.completed) {
    //       circleSizeAnimationController?.reset();
    //     }
    //   });

    animationController?.forward();
    // circleAnimationController?.forward();
    // circleSizeAnimationController?.forward();
  }

  @override
  void dispose() {
    pageController?.dispose();

    animationController?.dispose();
    super.dispose();
  }

  void onPageChanged(int value) {
    currentPage = value;
  }

  Future<void> animateToPage(int value) async {
    pageController?.animateToPage(value, duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
  }

  bool hasCycledPages = false;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {
          setState(() {
            currentPage++;

            if (currentPage > widget.pages.length - 1) {
              hasCycledPages = true;
              currentPage = 0;
            }
            print('currentPage: $currentPage');
          });
          animationController?.reset();
          animationController?.forward();

          circleAnimationController?.reset();
          circleSizeAnimationController?.reset();
          circleAnimationController?.forward();
          circleSizeAnimationController?.forward();
        },
      ),
      body: Stack(
        children: [
          /// Display previous page in background so that we see the clipper change current page
          widget.pages[previousPage()],

          /// Clipper to show the new page
          AnimatedBuilder(
            animation: animation,
            builder: (context, index) {
              return ClipPath(
                clipper: ShapeClipper(circleSizeAnimation.value),
                child: widget.pages[currentPage],
              );
            },
          ),

          /// Circle animation
          AnimatedBuilder(
            animation: circleAnimation,
            builder: (context, child) {
              return CustomPaint(
                painter: ShapePainter(circleAnimation.value, circleSizeAnimation.value),
                child: Container(),
              );
            },
          ),

          /// Logo
          Positioned(
            top: 60,
            left: 20,
            child: Image(
              width: 100,
              height: 100,
              image: AssetImage(
                'assets/verticle_pages/logo.png',
              ),
              color: Colors.white,
            ),
          ),
        ],
      ),
      // body: AnimatedBuilder(
      //   animation: circleAnimation,
      //   builder: (context, child) {
      //     return CustomPaint(
      //       painter: ShapePainter(circleAnimation.value, circleSizeAnimation.value),
      //       child: Container(),
      //     );
      //   },
      // ),

      // body: CustomPaint(
      //   painter: ShapePainter(circleAnimation.value),
      //   child: Container(),
      // ),
      // body: Stack(
      //   children: [
      //     CircularRevealAnimation(
      //       child: widget.pages[currentPage],
      //       animation: animation,
      //     ),

      //     // widget.pages[currentPage],
      //     // widget.pages[0],
      //     // CircularRevealAnimation(
      //     //   child: widget.pages[currentPage + 1],
      //     //   animation: animation,
      //     // ),
      //   ],
      // ),
    );
  }
}

// class VerticlePageDemoWidget extends StatefulWidget {
//   const VerticlePageDemoWidget({
//     super.key,
//     required this.pages,
//   });

//   final List<Widget> pages;

//   @override
//   State<VerticlePageDemoWidget> createState() => _VerticlePageDemoWidgetState();
// }

// class _VerticlePageDemoWidgetState extends State<VerticlePageDemoWidget> {
//   PageController? pageController;
//   int currentPage = 0;

//   @override
//   void initState() {
//     super.initState();
//     pageController = PageController();
//   }

//   @override
//   void dispose() {
//     pageController?.dispose();
//     super.dispose();
//   }

//   void onPageChanged(int value) {
//     currentPage = value;
//   }

//   Future<void> animateToPage(int value) async {
//     pageController?.animateToPage(value, duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.orange,
//         onPressed: () {
//           animateToPage(currentPage + 1);
//         },
//       ),
//       body: PageView.builder(
//         controller: pageController,
//         scrollDirection: Axis.vertical,
//         physics: const ClampingScrollPhysics(),
//         onPageChanged: onPageChanged,
//         itemBuilder: (context, index) {
//           return widget.pages[index % widget.pages.length];
//         },
//       ),
//     );
//   }
// }

class ShapePainter extends CustomPainter {
  final double strokeWidth;
  final double radius;

  ShapePainter(this.strokeWidth, this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.teal
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round;

    // Offset center = Offset(size.width / 2, size.height / 2);
    Offset center = Offset(70, 110);
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class ShapeClipper extends CustomClipper<Path> {
  final double radius;

  ShapeClipper(this.radius);
  @override
  getClip(Size size) {
    var path = Path();
    path.addOval(Rect.fromCircle(center: Offset(70, 110), radius: radius));
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }
}
