import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_app_template/ui/views/sparkle_party_demo/particlefx/particle_fx.dart';
import 'package:flutter_app_template/ui/views/sparkle_party_demo/particlefx/particle_fx_painter.dart';
import 'package:flutter_app_template/ui/views/sparkle_party_demo/sparkle_party_demo_view.dart';
import 'package:flutter_app_template/ui/views/sparkle_party_demo/ui/fx_entry.dart';
import 'package:flutter_app_template/utils/sprite_sheet.dart';

class FxRenderer extends StatefulWidget {
  final SpriteSheet spriteSheet;
  final FXEntry fx;
  final Size size;

  const FxRenderer({required this.spriteSheet, required this.fx, required this.size, super.key});

  @override
  State<FxRenderer> createState() => _FxRendererState();
}

class _FxRendererState extends State<FxRenderer> with SingleTickerProviderStateMixin {
  late Ticker _ticker;
  ParticleFX? _fxWidget;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_tick)..start();
    _fxWidget = widget.fx.create(spriteSheet: widget.spriteSheet, size: widget.size);
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(FxRenderer oldWidget) {
    if (oldWidget.size != widget.size || oldWidget.fx != widget.fx) {
      _fxWidget = widget.fx.create(spriteSheet: widget.spriteSheet, size: widget.size);
    }
    super.didUpdateWidget(oldWidget);
  }

  void setTouchPoint(Offset? pt) {
    TouchPointChangeNotification().dispatch(context);
    if (pt == null) {
      _fxWidget?.touchPoint = null;
    } else {
      _fxWidget?.touchPoint = pt;
    }
  }

  void _tick(Duration duration) {
    if (_fxWidget != null) {
      _fxWidget?.tick(duration);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (TapDownDetails details) => setTouchPoint(details.localPosition),
      onTapUp: (TapUpDetails details) => setTouchPoint(null),
      onPanStart: (DragStartDetails details) => setTouchPoint(details.localPosition),
      onPanEnd: (DragEndDetails details) => setTouchPoint(null),
      onPanUpdate: (DragUpdateDetails details) => setTouchPoint(details.localPosition),
      child: CustomPaint(
        painter: ParticleFXPainter(fx: _fxWidget!),
        child: Container(),
      ),
    );
  }
}
