import 'dart:math';

import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_app_template/ui/common/app_colors.dart';
import 'package:flutter_app_template/ui/common/ui_helpers.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  final int startingIndex;
  const HomeView({Key? key, required this.startingIndex}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                verticalSpaceLarge,
                SeparatedColumn(
                  separatorBuilder: () => const SizedBox(height: 10),
                  children: [
                    TextButton(
                      onPressed: viewModel.navigateToGooeyEdgeDemo,
                      child: const Text(
                        'Gooey Edge Demo',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: viewModel.navigateToStarsDemo,
                      child: const Text(
                        'Stars Demo',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: viewModel.navigateToSparklePartyDemo,
                      child: const Text(
                        'Sparkle Party Demo',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: viewModel.navigateToVerticlePageDemo,
                      child: const Text(
                        'Circle Clipper Demo',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: viewModel.navigateToTrigonometricPageDemo,
                      child: const Text(
                        'Trigonometric Demo',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: viewModel.navigateToSquaresDemo,
                      child: const Text(
                        'Squares Squares Squares Demo',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel(startingIndex);
}
