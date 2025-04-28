import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Widgets/CheckBoxe.dart';
import '../../../Widgets/CustomButtons.dart';
import '../../../Widgets/DropDown.dart';
import '../../../Widgets/TextFieldForms.dart';
import '../../../Widgets/TitleRow.dart';


// old code
/*
class SmsCommunicationForms extends StatefulWidget {
  const SmsCommunicationForms({super.key});

  @override
  State<SmsCommunicationForms> createState() => _SmsCommunicationFormsState();
}

class _SmsCommunicationFormsState extends State<SmsCommunicationForms> {
  String Status = 'AB+';
  String Status1 = 'Male';

  final List<bool> boxChecker = List.generate(5, (index) => false);
  void onChangedCheckBox(bool value, int index) {
    setState(() {
      boxChecker[index] = value;
    });
  }

  final List<bool> boxChecker1 = List.generate(5, (index) => false);
  void onChangedCheckBox1(bool value, int index) {
    setState(() {
      boxChecker1[index] = value;
    });
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
            TitleRow(title: 'Sms Communication'),
            const SizedBox(height: 30),

            // Merged Form UI
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
                  _buildSectionHeader('SMS'),
                  const Divider(thickness: 1, color: Color(0xFFE4E6E8)),
                  const SizedBox(height: 15),

                  // ✅ First Row: Checkboxes (Full Width)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CheckBoxes(
                      checker: boxChecker,
                      text: ["Users", "Members", "Student", "Department",'Church Staff'],
                      onChangedCheckBox: onChangedCheckBox,
                    ),
                  ),

                  const SizedBox(height: 15),

                  // ✅ Second Row: Checkboxes + Dropdown
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center, // Ensures alignment
                    children: [
                      Expanded(
                        flex: 3, // Gives more space for checkboxes
                        child: CheckBoxes(
                          checker: boxChecker1,
                          text: ["Pastors", "Committee", "Chorus",'Married','Single'],
                          onChangedCheckBox: onChangedCheckBox1,
                          name: '   ',
                        ),
                      ),

                      // Responsive Space Between Items
                      SizedBox(width: MediaQuery.of(context).size.width * 0.04),

                      Expanded(
                        child: DropdownSelector(
                          title: 'Blood Group',
                          value: Status,
                          onChanged: (newValue) {
                            setState(() {
                              Status = newValue!;
                            });
                          },
                          ItemList: ["AB+", "AB-", 'A+', "A-", 'O+', 'O-'],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),

                  Row(
                    children: [
                      Expanded(
                        child: DropdownSelector(
                          title: 'Gender',
                          value: Status1,
                          onChanged: (newValue) {
                            setState(() {
                              Status1 = newValue!;
                            });
                          },
                          ItemList: ["Male", "Female", 'Transgender'],
                        ),
                      ),
                      const SizedBox(width: 15),
                      // Amount Field (Expanded to take available space)
                      Expanded(
                        flex: 1, // Adjust flex values if needed
                        child: Textfieldforms(
                          title: 'Pin Code',
                          hint: 'Enter pin code',
                          isBlocked: false,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: CustomButton(
                      text: "Apply",
                      color: Colors.blue,
                      textColor: Colors.white,
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(height: 15),
                  // ✅ Third Row: Remarks & Button
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Remarks Field (Multiline)
                      Textfieldforms(
                        title: 'Message *',
                        hint: 'Enter Message',
                        isBlocked: false,
                        isMultiline: true,
                      ),
                      const SizedBox(height: 15), // Space between fields

                      Align(
                        alignment: Alignment.bottomRight,
                        child: CustomButton(
                          text: "Add Now",
                          color: Colors.blue,
                          textColor: Colors.white,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
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
*/


class SmsCommunicationForms extends StatefulWidget {
  const SmsCommunicationForms({super.key});

  @override
  State<SmsCommunicationForms> createState() => _SmsCommunicationFormsState();
}

class _SmsCommunicationFormsState extends State<SmsCommunicationForms> {
  // Define fields dynamically
  final List<Map<String, dynamic>> fields = [
    {'title': 'Message *', 'hint': 'Enter Message', 'isMultiline': true, 'widgetType': 'text'},
    {'title': 'Pin Code', 'hint': 'Enter pin code', 'isMultiline': false, 'widgetType': 'text'},
  ];

  // Controllers and Error States
  final Map<String, TextEditingController> _textControllers = {};
  final Map<String, bool> _errorStates = {};

  String bloodGroup = 'Select Blood Group';
  String gender = 'Select Gender';

  // Checkboxes states
  final List<bool> boxChecker = List.generate(5, (index) => false);
  void onChangedCheckBox(bool value, int index) {
    setState(() {
      boxChecker[index] = value;
    });
  }

  final List<bool> boxChecker1 = List.generate(5, (index) => false);
  void onChangedCheckBox1(bool value, int index) {
    setState(() {
      boxChecker1[index] = value;
    });
  }

  @override
  void initState() {
    super.initState();
    // Initialize controllers and error states for text fields
    for (var field in fields) {
      if (field['widgetType'] == 'text') {
        _textControllers[field['title']] = TextEditingController();
        _errorStates[field['title']] = false;
      }
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
      // Check dropdowns
      _errorStates['Blood Group'] = bloodGroup == 'Select Blood Group';
      _errorStates['Gender'] = gender == 'Select Gender';
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
                  _buildSectionHeader('SMS'),
                  const Divider(thickness: 1, color: Color(0xFFE4E6E8)),
                  const SizedBox(height: 15),

                  // Dynamically build rows of fields
                  ..._buildFormRows(),

                  // Submit Button
                  const SizedBox(height: 20),
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
            ),
          ],
        ),
      ),
    );
  }

  // Build a list of form rows
  List<Widget> _buildFormRows() {
    List<Widget> rows = [];

    // First Row: Recipients (Checkboxes)
    rows.add(
      Align(
        alignment: Alignment.centerLeft,
        child: CheckBoxes(
          checker: boxChecker,
          text: ["Users", "Members", "Student", "Department", "Church Staff"],
          onChangedCheckBox: onChangedCheckBox,
        ),
      ),
    );
    rows.add(const SizedBox(height: 15));

    // Second Row: Groups + Dropdown (Blood Group)
    rows.add(
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: CheckBoxes(
              checker: boxChecker1,
              text: ["Pastors", "Committee", "Chorus", "Married", "Single"],
              onChangedCheckBox: onChangedCheckBox1,
              name: '   ',
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: DropdownSelector(
              title: 'Blood Group',
              value: bloodGroup,
              onChanged: (newValue) {
                setState(() {
                  bloodGroup = newValue!;
                  _errorStates['Blood Group'] = false; // Clear error state
                });
              },
              ItemList: ["Select Blood Group", "AB+", "AB-", "A+", "A-", "O+", "O-"],
            ),
          ),
        ],
      ),
    );
    rows.add(const SizedBox(height: 15));

    // Third Row: Gender + Pin Code
    rows.add(
      Row(
        children: [
          Expanded(
            child: DropdownSelector(
              title: 'Gender',
              value: gender,
              onChanged: (newValue) {
                setState(() {
                  gender = newValue!;
                  _errorStates['Gender'] = false; // Clear error state
                });
              },
              ItemList: ["Select Gender", "Male", "Female", "Transgender"],
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: _buildTextField('Pin Code', hint: 'Enter pin code', isMultiline: false),
          ),
        ],
      ),
    );
    rows.add(const SizedBox(height: 15));

    // Fourth Row: Message (Multiline)
    rows.add(
      _buildTextField('Message *', hint: 'Enter Message', isMultiline: true),
    );

    return rows;
  }

  // Build a single text field
  Widget _buildTextField(String fieldName, {String? hint, bool isMultiline = false}) {
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
