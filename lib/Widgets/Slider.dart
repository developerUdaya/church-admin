import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SliderWidgets extends StatelessWidget {
  final double sliderValue;
  final ValueChanged<double> onChanged;

  SliderWidgets({super.key, required this.sliderValue, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child: Slider(
        activeColor: Color(0xff635bff),
        value: sliderValue,
        onChanged: onChanged,
      ),
    );
  }
}
