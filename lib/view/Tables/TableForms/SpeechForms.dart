import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Widgets/Calendar.dart';
import '../../../Widgets/CustomButtons.dart';
import '../../../Widgets/DropDown.dart';
import '../../../Widgets/TextFieldForms.dart';
import '../../../Widgets/TitleRow.dart';

 // old code

/*
class SpeechForms extends StatefulWidget {
  const SpeechForms({super.key});

  @override
  State<SpeechForms> createState() => _SpeechFormsState();
}

class _SpeechFormsState extends State<SpeechForms> {
  String Status = 'Select Name';
  String Status1 = 'Select Number';
  String Status2 = 'Select UserId';

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
            TitleRow(title: 'Speech'),
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
                  _buildSectionHeader('Add Speech'),
                  const Divider(thickness: 1, color: Color(0xFFE4E6E8)),
                  const SizedBox(height: 15),


                  // ✅ Second Row: Checkboxes + Dropdown
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center, // Ensures alignment
                    children: [
                      Expanded(
                        child: DropdownSelector(
                          title: 'Name',
                          value: Status,
                          onChanged: (newValue) {
                            setState(() {
                              Status = newValue!;
                            });
                          },
                          ItemList: ['Select Name',"Demo", "John", 'Ravi',"Sam", 'Peter'],
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: DropdownSelector(
                          title: 'Phone Number',
                          value: Status1,
                          onChanged: (newValue) {
                            setState(() {
                              Status1 = newValue!;
                            });
                          },
                          ItemList: ["Select Number", "754895578622", '254569874556','7862476247895','745874512254'],
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: DropdownSelector(
                          title: 'User Id',
                          value: Status2,
                          onChanged: (newValue) {
                            setState(() {
                              Status2 = newValue!;
                            });
                          },
                          ItemList: ["Select UserId", "754895578622", '254569874556','7862476247895','745874512254'],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),

                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: CalendarApp(
                          onDateSelected: (DateTime) {},
                          defaultDate: DateTime.now(),
                        ),
                      ),

                      const SizedBox(width: 15),
                      Flexible(
                        flex: 1,
                        child: Textfieldforms(
                          title: 'Pin Code',
                          hint: 'Enter pin code',
                          isBlocked: false,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  // ✅ Third Row: Remarks & Button
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Textfieldforms(
                        title: 'Subject *',
                        hint: 'Enter Subject',
                        isBlocked: false,
                        isMultiline: true,
                      ),
                      const SizedBox(height: 15),


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

class SpeechForms extends StatefulWidget {
  const SpeechForms({super.key});

  @override
  State<SpeechForms> createState() => _SpeechFormsState();
}

class _SpeechFormsState extends State<SpeechForms> {
  // Define fields dynamically
  final List<Map<String, dynamic>> fields = [
    {'title': 'Name', 'hint': '', 'isMultiline': false, 'widgetType': 'dropdown'},
    {'title': 'Phone Number', 'hint': '', 'isMultiline': false, 'widgetType': 'dropdown'},
    {'title': 'User Id', 'hint': '', 'isMultiline': false, 'widgetType': 'dropdown'},
    {'title': 'Date', 'hint': '', 'isMultiline': false, 'widgetType': 'calendar'},
    {'title': 'Pin Code', 'hint': 'Enter pin code', 'isMultiline': false, 'widgetType': 'text'},
    {'title': 'Subject *', 'hint': 'Enter Subject', 'isMultiline': true, 'widgetType': 'text'},
  ];

  // Controllers and Error States
  final Map<String, TextEditingController> _textControllers = {};
  final Map<String, bool> _errorStates = {};

  String name = 'Select Name';
  String phoneNumber = 'Select Number';
  String userId = 'Select UserId';

  @override
  void initState() {
    super.initState();
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
          if (field['widgetType'] == 'text') {
            _errorStates[title] = _textControllers[title]!.text.isEmpty;
          } else if (field['widgetType'] == 'dropdown') {
            switch (title) {
              case 'Name':
                _errorStates[title] = name == 'Select Name';
                break;
              case 'Phone Number':
                _errorStates[title] = phoneNumber == 'Select Number';
                break;
              case 'User Id':
                _errorStates[title] = userId == 'Select UserId';
                break;
            }
          }
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
                  _buildSectionHeader('Add Speech'),
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

    // First Row: Dropdowns (Name, Phone Number, User Id)
    rows.add(
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: DropdownSelector(
              title: 'Name',
              value: name,
              onChanged: (newValue) {
                setState(() {
                  name = newValue!;
                  _errorStates['Name'] = false; // Clear error state
                });
              },
              ItemList: ['Select Name', "Demo", "John", 'Ravi', "Sam", 'Peter'],
              // Highlight error
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: DropdownSelector(
              title: 'Phone Number',
              value: phoneNumber,
              onChanged: (newValue) {
                setState(() {
                  phoneNumber = newValue!;
                  _errorStates['Phone Number'] = false; // Clear error state
                });
              },
              ItemList: ["Select Number", "754895578622", '254569874556', '7862476247895', '745874512254'],

            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: DropdownSelector(
              title: 'User Id',
              value: userId,
              onChanged: (newValue) {
                setState(() {
                  userId = newValue!;
                  _errorStates['User Id'] = false; // Clear error state
                });
              },
              ItemList: ["Select UserId", "754895578622", '254569874556', '7862476247895', '745874512254'],
            ),
          ),
        ],
      ),
    );
    rows.add(const SizedBox(height: 15));

    // Second Row: Date + Pin Code
    rows.add(
      Row(
        children: [
          Expanded(
            child: CalendarApp(
              onDateSelected: (DateTime date) {},
              defaultDate: DateTime.now(),
              title: 'Date',
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Textfieldforms(
              title: 'Pin Code',
              hint: 'Enter pin code',
              isBlocked: false,
              isController: _textControllers['Pin Code']!,
              isErrorText: _errorStates['Pin Code'] ?? false, // Highlight error
            ),
          ),
        ],
      ),
    );
    rows.add(const SizedBox(height: 15));

    // Third Row: Subject (Multiline)
    rows.add(
      Textfieldforms(
        title: 'Subject *',
        hint: 'Enter Subject',
        isBlocked: false,
        isMultiline: true,
        isController: _textControllers['Subject *']!,
        isErrorText: _errorStates['Subject *'] ?? false, // Highlight error
      ),
    );

    return rows;
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