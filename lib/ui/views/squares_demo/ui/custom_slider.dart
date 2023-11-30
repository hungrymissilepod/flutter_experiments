import 'package:flutter/material.dart';

class CustomSlider extends StatefulWidget {
  const CustomSlider({
    super.key,
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  final String label;
  final double value;
  final double min;
  final double max;
  final Function(double) onChanged;

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${widget.label}: ${widget.value.toStringAsPrecision(3)}'),
        Slider(
          value: widget.value,
          min: widget.min,
          max: widget.max,
          onChanged: widget.onChanged,
        ),
      ],
    );
  }
}
