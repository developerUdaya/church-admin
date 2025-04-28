import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class DropdownWidget extends StatefulWidget {
  final List<String> items;
  final String? initialValue;
  final ValueChanged<String?>? onChanged;
  final double outerwidth;
  final double outerheigth;

  const DropdownWidget({
    super.key,
    required this.items,
    this.initialValue,
    this.onChanged,
    this.outerwidth =  0.30,
    this.outerheigth = 0.06,
  });

  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  String? selectedValue;
  double? withvalue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
    withvalue = widget.outerwidth - 8;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * widget.outerwidth,
      height: MediaQuery.of(context).size.height *widget.outerheigth,
      padding: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: DropdownButtonFormField2<String>(
        value: selectedValue,
        isExpanded: true,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.zero,
          border: InputBorder.none,
        ),
        hint: const Text(
          "Select an option",
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        items: widget.items
            .map((item) => DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: const TextStyle(fontSize: 14),
          ),
        ))
            .toList(),
        onChanged: (value) {
          setState(() {
            selectedValue = value;
          });
          widget.onChanged!(value);
        },
        dropdownStyleData: DropdownStyleData(
          width: MediaQuery.of(context).size.width * 0.25,
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
        ),
        buttonStyleData: ButtonStyleData(
          height: MediaQuery.of(context).size.height *widget.outerheigth,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      /*  validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select an option';
          }
          return null;
        },*/
      ),
    );
  }
}


