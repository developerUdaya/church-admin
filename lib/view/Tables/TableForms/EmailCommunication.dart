import 'package:church_admin/Widgets/CheckBoxe.dart';
import 'package:church_admin/Widgets/CustomButtons.dart';
import 'package:church_admin/Widgets/DropDown.dart';
import 'package:church_admin/Widgets/TextFieldForms.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmailCommunication extends StatefulWidget {
  const EmailCommunication({super.key});

  @override
  State<EmailCommunication> createState() => _EmailCommunicationState();
}

class _EmailCommunicationState extends State<EmailCommunication> {
  // Define dynamic fields
  final List<Map<String, dynamic>> checkboxGroups = [
    {'title': 'Recipients', 'options': ["Users", "Members", "Student", "Department", "Church Staff"]},
    {'title': 'Categories', 'options': ["Pastors", "Committee", "Chorus", "Married", "Single"]},
  ];

  // Dropdown Values
  String bloodGroup = 'AB+';
  String gender = 'Male';

  // Checkbox States
  final Map<String, List<bool>> checkboxStates = {};

  // Text Field Controllers and Error States
  final Map<String, TextEditingController> _textControllers = {};
  final Map<String, bool> _errorStates = {};

  @override
  void initState() {
    super.initState();

    // Initialize checkbox states
    for (var group in checkboxGroups) {
      checkboxStates[group['title']] = List.generate(group['options'].length, (index) => false);
    }

    // Initialize text field controllers and error states
    _textControllers['Subject *'] = TextEditingController();
    _textControllers['Message *'] = TextEditingController();
    _errorStates['Subject *'] = false;
    _errorStates['Message *'] = false;
  }

  @override
  void dispose() {
    // Dispose all controllers
    for (var controller in _textControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  // Handle Checkbox Changes
  void onChangedCheckBox(bool value, String groupTitle, int index) {
    setState(() {
      checkboxStates[groupTitle]![index] = value;
    });
  }

  // Validate the form
  void _validateForm() {
    bool isValid = true;

    // Check if at least one checkbox is selected in each group
    for (var group in checkboxGroups) {
      if (!checkboxStates[group['title']]!.contains(true)) {
        isValid = false;
        print("${group['title']} must have at least one option selected.");
      }
    }

    // Check if required text fields are filled
    setState(() {
      _errorStates['Subject *'] = _textControllers['Subject *']!.text.isEmpty;
      _errorStates['Message *'] = _textControllers['Message *']!.text.isEmpty;
    });

    if (_errorStates.containsValue(true)) {
      isValid = false;
    }

    // Print validation result
    if (isValid) {
      print("Form submitted successfully!");
    } else {
      print("Form contains errors.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.74,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      margin: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xfff4f7fc),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Merged Form UI
            _buildFormContainer(),
          ],
        ),
      ),
    );
  }

  // Build the main form container
  Widget _buildFormContainer() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          _buildSectionHeader('Email'),
          const Divider(thickness: 1, color: Color(0xFFE4E6E8)),
          const SizedBox(height: 15),

          // First Row: Checkboxes (Full Width)
          for (var group in checkboxGroups)
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: CheckBoxes(
                  checker: checkboxStates[group['title']]!,
                  text: group['options'],
                  onChangedCheckBox: (value, index) => onChangedCheckBox(value!, group['title'], index),
                ),
              ),
            ),

          // Second Row: Blood Group and Gender Dropdowns
          Row(
            children: [
              Expanded(
                child: DropdownSelector(
                  title: 'Blood Group',
                  value: bloodGroup,
                  onChanged: (newValue) {
                    setState(() {
                      bloodGroup = newValue!;
                    });
                  },
                  ItemList: ["AB+", "AB-", "A+", "A-", "O+", "O-"],
                ),
              ),
              const SizedBox(width: 15), // Correct spacing between widgets
              Expanded(
                child: DropdownSelector(
                  title: 'Gender',
                  value: gender,
                  onChanged: (newValue) {
                    setState(() {
                      gender = newValue!;
                    });
                  },
                  ItemList: ["Male", "Female", "Transgender"],
                ),
              ),
              const SizedBox(width: 15), // Correct spacing between widgets
              Expanded(
                child: Textfieldforms(
                  title: 'Pin Code',
                  hint: 'Enter pin code',
                  isBlocked: false,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          // Fourth Row: Subject and Message Fields
          Textfieldforms(
            title: 'Subject *',
            hint: 'Enter Subject',
            isBlocked: false,
            isMultiline: true,
            isController: _textControllers['Subject *']!,
            isErrorText: _errorStates['Subject *']!,
          ),
          const SizedBox(height: 15),
          Textfieldforms(
            title: 'Message *',
            hint: 'Enter Message',
            isBlocked: false,
            isMultiline: true,
            isController: _textControllers['Message *']!,
            isErrorText: _errorStates['Message *']!,
          ),
          const SizedBox(height: 15),

          // Submit Button
          Align(
            alignment: Alignment.bottomRight,
            child: CustomButton(
              text: "Add Now",
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: _validateForm,
            ),
          ),
        ],
      ),
    );
  }

  // Section Header Styling
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: GoogleFonts.manrope(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }
}
