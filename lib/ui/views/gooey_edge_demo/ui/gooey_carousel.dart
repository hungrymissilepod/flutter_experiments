import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_app_template/ui/views/gooey_edge_demo/ui/gooey_edge.dart';

class GooeyCarousel extends StatefulWidget {
  const GooeyCarousel({super.key, required this.children});

  final List<Widget> children;

  @override
  State<GooeyCarousel> createState() => _GooeyCarouselState();
}

class _GooeyCarouselState extends State<GooeyCarousel>
    with SingleTickerProviderStateMixin {
  /// index of the bottom child
  int _index = 0;

  /// index of the top child
  int? _dragIndex;

  /// starting offset of the drag
  late Offset _dragOffset;

  /// +1 when dragging left to right, -1 for right to left
  late double _dragDirection;

  /// has the drag successfully resulted in a swipe
  bool? _dragCompleted;

  late GooeyEdge edge;

  late Ticker ticker;
  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    edge = GooeyEdge(count: 25);
    ticker = createTicker(_tick)..start();
    super.initState();
  }

  @override
  void dispose() {
    ticker.dispose();
    super.dispose();
  }

  void _tick(Duration duration) {
    edge.tick(duration);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    int l = widget.children.length;
    // print('index: ${_index % l}');
    return GestureDetector(
      key: _key,
      onPanDown: (details) => _handlePanDown(details, _getSize()),
      onPanUpdate: (details) => _handlePanUpdate(details, _getSize()),
      onPanEnd: (details) => _handlePanEnd(details, _getSize()),
      child: Stack(
        children: <Widget>[
          widget.children[_index % l],
          _dragIndex == null
              ? const SizedBox()
              : ClipPath(
                  clipBehavior: Clip.hardEdge,
                  clipper: GooeyEdgeClipper(edge, margin: 10.0),
                  child: widget.children[_dragIndex! % l],
                )
        ],
      ),
    );
  }

  Size _getSize() {
    final RenderBox box = _key.currentContext!.findRenderObject() as RenderBox;
    return box.size;
  }

  void _handlePanDown(DragDownDetails details, Size size) {
    // print('_handlePanDown');
    if (_dragIndex != null && _dragCompleted!) {
      _index = _dragIndex!;
    }
    _dragIndex = null;
    _dragOffset = details.localPosition;
    _dragCompleted = false;
    _dragDirection = 0;

    edge.farEdgeTension = 0.0;
    edge.edgeTension = 0.01;
    edge.reset();
  }

  void _handlePanUpdate(DragUpdateDetails details, Size size) {
    // print('_handlePanUpdate');
    double dx = details.globalPosition.dx - _dragOffset.dx;

    if (!_isSwipeActive(dx)) {
      // print('swipe not active');
      return;
    }
    if (_isSwipeComplete(dx, size.width)) {
      print('swipe complete');
      return;
    }

    if (_dragDirection == -1) {
      dx = size.width + dx;
    }
    edge.applyTouchOffset(Offset(dx, details.localPosition.dy), size);
  }

  void _handlePanEnd(DragEndDetails details, Size size) {
    // print('_handlePanEnd');
    edge.applyTouchOffset(null, null);
  }

  bool _isSwipeActive(double dx) {
    /// check if swipe is start starting
    if (_dragDirection == 0.0 && dx.abs() > 20.0) {
      _dragDirection = dx.sign;
      edge.side = _dragDirection == 1.0 ? Side.left : Side.right;
      setState(() {
        _dragIndex = _index - _dragDirection.toInt();
      });
    }
    return _dragDirection != 0.0;
  }

  bool _isSwipeComplete(double dx, double width) {
    /// if we haven't started swiping
    if (_dragDirection == 0.0) {
      return false;
    }

    /// we have already done swiping
    if (_dragCompleted!) {
      return true;
    }

    /// check if swipe is just completed
    double availW = _dragOffset.dx;
    if (_dragDirection == 1) {
      availW = width - availW;
    }
    double ratio = dx * _dragDirection / availW;

    if (ratio > 0.8 && availW / width > 0.5) {
      _dragCompleted = true;
      edge.farEdgeTension = 0.01;
      edge.edgeTension = 0.0;
      edge.applyTouchOffset(null, null);
    }
    return _dragCompleted!;
  }
}
