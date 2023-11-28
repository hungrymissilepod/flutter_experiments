import 'package:flutter/material.dart';
import 'package:flutter_app_template/ui/views/gooey_edge_demo/ui/gooey_carousel.dart';
import 'package:stacked/stacked.dart';

import 'gooey_edge_demo_viewmodel.dart';

class GooeyEdgeDemoView extends StackedView<GooeyEdgeDemoViewModel> {
  const GooeyEdgeDemoView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    GooeyEdgeDemoViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: GooeyCarousel(
        children: <Widget>[
          Container(
            color: Colors.purple,
          ),
          Container(
            color: Colors.green,
          ),
          Container(
            color: Colors.orange,
          ),
        ],
      ),
    );
  }

  @override
  GooeyEdgeDemoViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      GooeyEdgeDemoViewModel();
}
