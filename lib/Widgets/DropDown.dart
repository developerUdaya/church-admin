import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DropdownSelector extends StatefulWidget {
  final String value;
  final String title;
  final Function(String?) onChanged;
  final List<String> ItemList;

  const DropdownSelector(
      {super.key,
        required this.value,
        required this.onChanged,
        required this.title, required this.ItemList});

  @override
  State<DropdownSelector> createState() => _DropdownSelectorState();
}

class _DropdownSelectorState extends State<DropdownSelector> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.title,
          style: GoogleFonts.manrope(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8),
        DropdownButtonFormField<String>(
          borderRadius: BorderRadius.circular(10),
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff635bff), width: 0.5),
              borderRadius: BorderRadius.circular(10),
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                )),
          ),
          dropdownColor: Colors.white,
          style: GoogleFonts.manrope(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          value: widget.value,
          items: widget.ItemList.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: widget.onChanged,
        ),
      ],
    );
  }
}
