import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app_template/ui/views/stars_demo/ui/starfield.dart';
import 'package:stacked/stacked.dart';

import 'stars_demo_viewmodel.dart';

class StarsDemoView extends StackedView<StarsDemoViewModel> {
  const StarsDemoView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    StarsDemoViewModel viewModel,
    Widget? child,
  ) {
    return const StarsDemo();
  }

  @override
  StarsDemoViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      StarsDemoViewModel();
}

class StarsDemo extends StatefulWidget {
  const StarsDemo({super.key});

  @override
  State<StarsDemo> createState() => _StarsDemoState();
}

class _StarsDemoState extends State<StarsDemo> {
  static const double idleSpeed = 0.2;
  static const double maxSpeed = 10;

  final ValueNotifier<double> _speedValue = ValueNotifier(idleSpeed);

  int starCount = 400;

  onScrolled(double delta) {
    setState(() {
      if (delta == 0) {
        _speedValue.value = idleSpeed;
      } else {
        _speedValue.value = delta.clamp(-maxSpeed, maxSpeed);
      }
    });
  }

  double _prevScrollPos = 0;
  double _scrollVel = 0;

  bool _handleScrollNotification(ScrollNotification notification) {
    //Determine scrollVelocity and dispatch it to any listeners
    _scrollVel = notification.metrics.pixels - _prevScrollPos;
    onScrolled(_scrollVel);
    _prevScrollPos = notification.metrics.pixels;
    //Return true to cancel the notification bubbling, we've handled it here.
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          ValueListenableBuilder(
            valueListenable: _speedValue,
            builder: (context, value, child) {
              return StarField(
                starSpeed: value,
                starCount: starCount,
              );
            },
          ),

          /// Using an invisible container in a scroll view here so that we can scroll on screen to
          /// change speed of stars
          SafeArea(
            child: NotificationListener(
              onNotification: _handleScrollNotification,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                child: Column(
                  children: [
                    Container(
                      height: size.height,
                      width: size.width,
                      color: Colors.transparent,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
