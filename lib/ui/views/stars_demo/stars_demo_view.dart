import 'package:flutter/material.dart';
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
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      ),
    );
  }

  @override
  StarsDemoViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      StarsDemoViewModel();
}
