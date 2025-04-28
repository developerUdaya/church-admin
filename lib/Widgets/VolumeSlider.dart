import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Slider.dart';

class VolumeIncDec extends StatelessWidget {
  final double volumeValue;
  final Function(double) onChangedVolume;

  VolumeIncDec({
    super.key,
    required this.volumeValue,
    required this.onChangedVolume,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.volume_down),
          onPressed: () {
            if (volumeValue > 0.1) {
              onChangedVolume(volumeValue - 0.1);
            }
          },
        ),
        SizedBox(width: 8),
        SizedBox(
      width: 500,
      child: Slider(
        activeColor: Color(0xff635bff),
        value: volumeValue,
        onChanged: onChangedVolume,
      ),
    ),
        SizedBox(width: 8),
        IconButton(
          icon: Icon(Icons.volume_up),
          onPressed: () {
            if (volumeValue < 1.0) {
              onChangedVolume(volumeValue + 0.1);
            }
          },
        ),
      ],
    );
  }
}