import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Switches extends StatelessWidget {
  final List<bool> checker;
  final List<String> text;
  final Function onChangedSwitch;
  const Switches({super.key, required this.checker, required this.text, required this.onChangedSwitch});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Switches",
          style: GoogleFonts.manrope(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(checker.length, (index) {
            return Row(
              children: [
                MouseRegion(
                  cursor: (index == 2 || index == 3)
                      ? SystemMouseCursors.forbidden
                      : SystemMouseCursors.click,
                  child: Transform.scale(
                    scale: 0.9,
                    child: Switch(
                      inactiveThumbColor:Colors.white,
                          trackOutlineWidth: WidgetStatePropertyAll(0.5),
                          padding: EdgeInsets.all(0),
                      activeColor: Colors.white,
                      activeTrackColor: Color(0xff635bff),
                    
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: (index == 3) ? true : checker[index],
                      inactiveTrackColor:
                          (index == 3) ? Color(0xff635bff) : Color(0xffe6e7eb),
                      onChanged: (index == 2 || index == 3)
                          ? null
                          : (value) {
                              onChangedSwitch(value, index);
                            },
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  text[index],
                  style: GoogleFonts.manrope(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            );
          }),
        )
      ],
    );
  }
}
