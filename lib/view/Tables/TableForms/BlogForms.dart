import 'dart:io';
import 'dart:typed_data';

import 'package:church_admin/Widgets/AddProductPhotoWidget.dart';
import 'package:church_admin/Widgets/CustomButtons.dart';
import 'package:church_admin/Widgets/TextFieldForms.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class BlogForms extends StatefulWidget {
  const BlogForms({super.key});

  @override
  State<BlogForms> createState() => _BlogFormsState();
}

class _BlogFormsState extends State<BlogForms> {
  // Define fields dynamically
  final List<Map<String, dynamic>> fields = [
    {'title': 'Title *', 'hint': 'Enter text', 'isMultiline': false},
    {'title': 'Author Name *', 'hint': 'Enter name', 'isMultiline': false},
    {'title': 'Description', 'hint': 'Enter message', 'isMultiline': true},
  ];

  // Controllers and Error States
  final Map<String, TextEditingController> _textControllers = {};
  final Map<String, bool> _errorStates = {};
  File? selectedImageFile;
  Uint8List? selectedImageBytes;
  @override
  void initState() {
    super.initState();
    // Initialize controllers and error states
    for (var field in fields) {
      _textControllers[field['title']] = TextEditingController();
      _errorStates[field['title']] = false;
    }
  }

  @override
  void dispose() {
    // Dispose all controllers
    for (var controller in _textControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  // Validate the form
  void _validateForm() {
    setState(() {
      for (var field in fields) {
        String title = field['title'];
        if (title.endsWith('*')) {
          _errorStates[title] = _textControllers[title]!.text.isEmpty;
        }
      }
    });

    // Check if the form is valid
    bool isValid = !_errorStates.values.contains(true);
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
          _buildSectionHeader('Add Blog Post'),
          const Divider(thickness: 1, color: Color(0xFFE4E6E8)),
          const SizedBox(height: 15),

          // Add Cover Photo Widget
          Center(
            child: AddproductphotoWidget(
              titleName: 'Add Cover Photo',
              onImageSelected: (File? file, Uint8List? bytes) {
                setState(() {
                  selectedImageFile = file;
                  selectedImageBytes = bytes;
                });
              },
            ),
          ),
          const SizedBox(height: 15),

          // Dynamically build rows of fields
          ..._buildFormRows(),

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

  // Dynamically build rows of fields
  List<Widget> _buildFormRows() {
    List<Widget> rows = [];

    // First Row: Two Fields (Title and Author Name)
    rows.add(
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: _buildTextField(fields[0]['title'], hint: fields[0]['hint']),
          ),
          const SizedBox(width: 15),
          Expanded(
            flex: 1,
            child: _buildTextField(fields[1]['title'], hint: fields[1]['hint']),
          ),
        ],
      ),
    );
    rows.add(const SizedBox(height: 15));

    // Remaining Fields (Message)
    for (int i = 2; i < fields.length; i++) {
      rows.add(
        _buildTextField(
          fields[i]['title'],
          hint: fields[i]['hint'],
          isMultiline: fields[i]['isMultiline'],
        ),
      );
      rows.add(const SizedBox(height: 15));
    }

    return rows;
  }

  // Build a single text field
  Widget _buildTextField(String fieldName,
      {String? hint, bool isMultiline = false}) {
    return Textfieldforms(
      title: fieldName,
      hint: hint ?? '',
      isBlocked: false,
      isMultiline: isMultiline,
      isController: _textControllers[fieldName]!,
      isErrorText: _errorStates[fieldName]!,
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
