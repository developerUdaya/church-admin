import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Widgets/AddProductPhotoWidget.dart';
import '../../../Widgets/CustomButtons.dart';
import '../../../Widgets/TextFieldForms.dart';
import '../../../Widgets/TitleRow.dart';

class ProductFromCreation extends StatefulWidget {
  const ProductFromCreation({super.key});

  @override
  State<ProductFromCreation> createState() => _ProductFromCreationState();
}

class _ProductFromCreationState extends State<ProductFromCreation> {
  // Define fields dynamically
  final List<Map<String, dynamic>> fields = [
    {'title': 'Title *', 'hint': 'Enter Title', 'isMultiline': false},
    {'title': 'Price *', 'hint': 'Enter Price', 'isMultiline': false},
    {'title': 'Categories', 'hint': 'Enter Categories', 'isMultiline': false},
    {'title': 'Tags', 'hint': 'Enter Tags', 'isMultiline': false},
    {'title': 'Description', 'hint': 'Enter Description', 'isMultiline': true},
  ];

  // Controllers and Error States
  final Map<String, TextEditingController> _textControllers = {};
  final Map<String, bool> _errorStates = {};

  String maritalStatus = 'Single';
  String profession = 'Engineer';
  String selectedGender = "Male";
  String selectBlood = 'O-';
  bool switchValue = false;
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
      width: double.infinity,
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
            // Title Row
            _buildSectionHeader('Add Product'),
            const SizedBox(height: 30),

            // Form Container
            Container(
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
                  _buildSectionHeader('ADD PRODUCT'),
                  const Divider(thickness: 1, color: Color(0xFFE4E6E8)),
                  const SizedBox(height: 15),

                  // Add Photo Widget
                  Center(
                    child: AddproductphotoWidget(
                      titleName: 'Add Photo',
                      outerWidth: 0.20,
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
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: CustomButton(
                      text: "ADD NOW",
                      color: Colors.blue,
                      textColor: Colors.white,
                      onPressed: _validateForm,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build a list of form rows
  List<Widget> _buildFormRows() {
    List<Widget> rows = [];

    // First Row: Title, Price, Categories, Tags
    if (fields.length >= 4) {
      rows.add(
        Row(
          children: [
            Expanded(
              child:
                  _buildTextField(fields[0]['title'], hint: fields[0]['hint']),
            ),
            const SizedBox(width: 15),
            Expanded(
              child:
                  _buildTextField(fields[1]['title'], hint: fields[1]['hint']),
            ),
            const SizedBox(width: 15),
            Expanded(
              child:
                  _buildTextField(fields[2]['title'], hint: fields[2]['hint']),
            ),
            const SizedBox(width: 15),
            Expanded(
              child:
                  _buildTextField(fields[3]['title'], hint: fields[3]['hint']),
            ),
          ],
        ),
      );
      rows.add(const SizedBox(height: 15));
    }

    // Remaining Fields (if any)
    for (int i = 4; i < fields.length; i++) {
      rows.add(
        _buildTextField(fields[i]['title'],
            hint: fields[i]['hint'],
            isMultiline: fields[i]['isMultiline'] ?? false),
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
