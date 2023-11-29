import 'package:flutter/material.dart';
import 'package:flutter_app_template/ui/views/sparkle_party_demo/particlefx/comet.dart';
import 'package:flutter_app_template/ui/views/sparkle_party_demo/particlefx/fireworks.dart';
import 'package:flutter_app_template/ui/views/sparkle_party_demo/particlefx/pinwheel.dart';
import 'package:flutter_app_template/ui/views/sparkle_party_demo/particlefx/waterfall.dart';
import 'package:flutter_app_template/ui/views/sparkle_party_demo/ui/fx_entry.dart';
import 'package:flutter_app_template/ui/views/sparkle_party_demo/ui/fx_renderer.dart';
import 'package:flutter_app_template/ui/views/sparkle_party_demo/ui/fx_switcher.dart';
import 'package:flutter_app_template/utils/sprite_sheet.dart';
import 'package:stacked/stacked.dart';
import 'package:statsfl/statsfl.dart';

import 'sparkle_party_demo_viewmodel.dart';

class SparklePartyDemoView extends StackedView<SparklePartyDemoViewModel> {
  const SparklePartyDemoView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SparklePartyDemoViewModel viewModel,
    Widget? child,
  ) {
    return const SparkPartyDemoWidget();
  }

  @override
  SparklePartyDemoViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SparklePartyDemoViewModel();
}

class SparkPartyDemoWidget extends StatefulWidget {
  const SparkPartyDemoWidget({super.key});

  static final List<FXEntry> fxs = [
    FXEntry("Waterfall",
        create: ({required spriteSheet, required size}) => Waterfall(spriteSheet: spriteSheet, size: size)),
    FXEntry("Fireworks",
        create: ({required spriteSheet, required size}) => Fireworks(spriteSheet: spriteSheet, size: size)),
    FXEntry("Comet", create: ({required spriteSheet, required size}) => Comet(spriteSheet: spriteSheet, size: size)),
    FXEntry("Pinwheel",
        create: ({required spriteSheet, required size}) => Pinwheel(spriteSheet: spriteSheet, size: size)),
  ];

  static final List<String> instructions = [
    'TOUCH AND DRAG ON THE SCREEN',
    'TAP OR DRAG ON THE SCREEN',
    'DRAG ON THE SCREEN',
    'DRAG ON THE SCREEN',
  ];

  @override
  State<SparkPartyDemoWidget> createState() => _SparkPartyDemoWidgetState();
}

class _SparkPartyDemoWidgetState extends State<SparkPartyDemoWidget> with TickerProviderStateMixin {
  int _fxIndex = 0;
  int _buttonIndex = 0;

  AnimationController? _transitionController;
  AnimationController? _textController;

  @override
  void initState() {
    super.initState();
    _transitionController = AnimationController(vsync: this, duration: Duration(milliseconds: 350));
    _textController = AnimationController(vsync: this, duration: Duration(milliseconds: 800));

    Listenable.merge([_transitionController, _textController]).addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _transitionController?.dispose();
    _textController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/sparkle/sparkleparty_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Image.asset('assets/sparkle/sparkleparty_logo.png'),
          ),
          SafeArea(
            child: Opacity(
              opacity: 1.0 - _transitionController!.value,
              child: NotificationListener<TouchPointChangeNotification>(
                onNotification: _handleInteraction,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return FxRenderer(
                      fx: SparkPartyDemoWidget.fxs[_fxIndex],
                      size: constraints.biggest,
                      spriteSheet: SpriteSheet(
                        imageProvider: const AssetImage('assets/sparkle/sparkleparty_spritesheet_2.png'),
                        length: 16,
                        frameWidth: 64,
                        frameHeight: 64,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          IgnorePointer(
            child: Center(
              child: Image.asset('assets/sparkle/sparkleparty_logo_outline.png'),
            ),
          ),
          FXSwitcher(activeEffect: _buttonIndex, callback: _handleFxChange),
          SafeArea(child: StatsFl()),
        ],
      ),
    );
  }

  void _handleFxChange(int index) {
    if (index == _fxIndex) return;
    setState(() => _buttonIndex = index);
    _transitionController?.forward(from: 0.0).whenComplete(() {
      setState(() => _fxIndex = index);
      _transitionController?.reverse(from: 1.0);
      _textController?.reverse();
    });
  }

  bool _handleInteraction(TouchPointChangeNotification notification) {
    return false;
  }
}

class TouchPointChangeNotification extends Notification {}
