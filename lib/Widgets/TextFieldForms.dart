import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Textfieldforms extends StatelessWidget {
  final String title;
  final String hint;
  final bool isBlocked;
  final bool isMultiline; // New parameter to enable multiline
  final bool isErrorText;
  final TextEditingController? isController;

  Textfieldforms({
    required this.title,
    required this.hint,
    required this.isBlocked,
    this.isMultiline = false, this.isErrorText = false,
    TextEditingController? isController,
    // Default to false (single-line)
  }):
  isController = isController ?? TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return isBlocked
        ? SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: GoogleFonts.manrope(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey,
                width: 0.5,
              ),
            ),
            child: MouseRegion(
              cursor: SystemMouseCursors.forbidden,
              child: Text(
                'Blocked',
                style: GoogleFonts.manrope(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    )
        : SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: GoogleFonts.manrope(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          MouseRegion(
            cursor: SystemMouseCursors.text,
            child: Theme(
              data: ThemeData(
                textSelectionTheme: const TextSelectionThemeData(
                  selectionColor: Color(0xff635bff),
                ),
              ),
              child: TextField(
                controller: isController,
                cursorColor:Color(0xff635bff), // Cursor color changed to white
                cursorWidth: 1.2,
                maxLines: isMultiline ? 10 : 1, // Enable multiline if true
                minLines: isMultiline ? 5 : 1, // Minimum lines for multiline
                decoration: InputDecoration(
                  errorText: isErrorText ? 'Field is Required' : null,
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 0.8), // Error Red border color
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedErrorBorder:OutlineInputBorder(
                    borderSide: BorderSide(color:Colors.red,width: 1.5), // Error Red border on focus
                    borderRadius: BorderRadius.circular(10),
                   ),
                  hoverColor: Colors.transparent, // No hover background color
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color:Color(0xff635bff),width: 1.5), // Black border on focus
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400, width: 0.8), // Default border color
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: hint,
                  hintStyle: GoogleFonts.manrope(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
