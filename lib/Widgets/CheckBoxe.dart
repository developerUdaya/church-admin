import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// old code
/*class CheckBoxes extends StatelessWidget {
  final List<bool> checker;
  final List<String> text;
  final Function onChangedCheckBox;
  final String name;
  const CheckBoxes({super.key, required this.checker, required this.text, required this.onChangedCheckBox,this.name ='Select Options'});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          name,
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
                  cursor: checker[index]
                      ? SystemMouseCursors.click
                      : SystemMouseCursors.forbidden,
                  child: Checkbox(
                    activeColor: Color(0xff635bff),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    visualDensity: VisualDensity.compact,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    side: BorderSide(
                      width: 0.5,
                      color: Colors.grey,
                    ),
                    value: checker[index],
                    onChanged: (value) {
                            onChangedCheckBox(value, index);
                          },
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
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
}*/

 //alter some change between old code

class CheckBoxes extends StatelessWidget {
  final List<bool> checker;
  final List<String> text;
  final Function onChangedCheckBox;
  final String name;

  const CheckBoxes({
    super.key,
    required this.checker,
    required this.text,
    required this.onChangedCheckBox,
    this.name = '',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (name.isNotEmpty) ...[
          Text(
            name,
            style: GoogleFonts.manrope(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
        ],
        LayoutBuilder(
          builder: (context, constraints) {
            int itemsPerRow = (constraints.maxWidth / 150).floor();
            itemsPerRow = itemsPerRow.clamp(1, checker.length);

            return Wrap(
              spacing: 20, // Horizontal spacing between items
              runSpacing: 10, // Vertical spacing between rows
              children: List.generate(checker.length, (index) {
                return SizedBox(
                  width: (constraints.maxWidth / itemsPerRow) - 20, // Dynamic width
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        activeColor: const Color(0xff635bff),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        visualDensity: VisualDensity.compact,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        side: const BorderSide(
                          width: 0.5,
                          color: Colors.grey,
                        ),
                        value: checker[index],
                        onChanged: (value) {
                          // Call the unchanged onChangedCheckBox function
                          onChangedCheckBox(value, index);
                        },
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          text[index],
                          style: GoogleFonts.manrope(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            );
          },
        ),
      ],
    );
  }
}