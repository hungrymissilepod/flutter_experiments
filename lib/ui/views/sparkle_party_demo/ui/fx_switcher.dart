import 'package:flutter/material.dart';

typedef FXChangeCallback = void Function(int);

class FXSwitcher extends StatelessWidget {
  static final List<String> buttonNames = [
    'Waterfall',
    'Fireworks',
    'Comet',
    'Pinwheel'
  ];
  static final List<String> selectedPaths = [
    'waterfall-selected',
    'fireworks-selected',
    'comet-selected',
    'pinwheel-selected'
  ];
  static final List<String> paths = [
    'waterfall-idle',
    'fireworks-idle',
    'comet-idle',
    'pinwheel-idle'
  ];

  final int activeEffect;
  final FXChangeCallback? callback;

  const FXSwitcher({super.key, required this.activeEffect, this.callback});

  @override
  Widget build(context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: 320,
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [0, 1, 2, 3]
              .map((int index) => _FXSwitcherButton(
                    name: buttonNames[index],
                    image: AssetImage(
                      'assets/sparkle/buttons/${activeEffect == index ? selectedPaths[index] : paths[index]}.png',
                    ),
                    handleTap: () => _handleButtonPress(index),
                  ))
              .toList(),
        ),
      ),
    );
  }

  void _handleButtonPress(int index) {
    callback?.call(index);
  }
}

class _FXSwitcherButton extends StatelessWidget {
  final String name;
  final ImageProvider image;
  final VoidCallback handleTap;

  const _FXSwitcherButton(
      {required this.name, required this.image, required this.handleTap});

  @override
  Widget build(context) {
    return Column(children: [
      GestureDetector(
        onTap: handleTap,
        child: Image(
          image: image,
          width: 56,
          height: 52,
        ),
      ),
      Padding(
        padding: EdgeInsets.all(2.0),
      ),
      Text(
        name,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12),
      ),
    ]);
  }
}
