import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final Function? onPressed;

  const CustomButton(
      {super.key,
      required this.text,
      required this.color,
      required this.textColor,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: color,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      onPressed: onPressed as void Function()?,
      child: Text(text,
          style: GoogleFonts.manrope(fontSize: 14, color: textColor)),
    );
  }
}
