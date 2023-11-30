import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class VerticlePage extends StatelessWidget {
  const VerticlePage({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/verticle_pages/$index.jpg',
          ),
          fit: BoxFit.fitHeight,
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
