import 'package:church_admin/CustomColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Widgets/AddProductPhotoWidget.dart';
import '../../../Widgets/Calendar.dart';
import '../../../Widgets/CustomButtons.dart';
import '../../../Widgets/DropDown.dart';
import '../../../Widgets/TextFieldForms.dart';
import '../../../Widgets/TitleRow.dart';



import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserFormCreation extends StatefulWidget {
  
  final Function? onPressed;
  const UserFormCreation({super.key,required this.onPressed});


  @override
  State<UserFormCreation> createState() => _UserFormCreationState();
}

class _UserFormCreationState extends State<UserFormCreation> {
  // Define fieldsData dynamically
  final List<Map<String, dynamic>> fieldsData = [
    // Personal Information
    {'title': 'Prefix', 'hint': 'Mr/Ms/Dr', 'type': 'text'},
    {'title': 'First Name *', 'hint': 'Enter first name', 'type': 'text'},
    {'title': 'Middle Name', 'hint': 'Enter middle name', 'type': 'text'},
    {'title': 'Last Name *', 'hint': 'Enter last name', 'type': 'text'},
    {'title': 'Gender *', 'hint': '', 'type': 'dropdown', 'options': ["Male", "Female", "Others"]},
    {'title': 'Date of Birth *', 'hint': 'Select date', 'type': 'date'},
    {'title': 'Aadhaar Number *', 'hint': 'Enter Aadhaar', 'type': 'text'},
    {'title': 'Phone *', 'hint': 'Enter phone number', 'type': 'text'},
    {'title': 'Alternative Phone', 'hint': 'Enter alternative phone', 'type': 'text'},
    {'title': 'Email *', 'hint': 'Enter email', 'type': 'text'},
    {'title': 'Alternative Email', 'hint': 'Enter alternative email', 'type': 'text'},
    {'title': 'Blood Group *', 'hint': '', 'type': 'dropdown', 'options': ["O-", "O+", "A-", "A+", "B-", "B+", "AB-", "AB+"]},
    {'title': 'Last Donated Date', 'hint': 'Select last donated date', 'type': 'date'},
    {'title': 'Hobbies', 'hint': 'Enter your hobbies', 'type': 'text'},

    // Family Information
    {'title': 'Marital Status *', 'hint': '', 'type': 'dropdown', 'options': ["Single", "Married", "Engaged", "Separated", "Divorced", "Widow"]},
    {'title': 'Spouse', 'hint': 'Enter spouse name', 'type': 'text'},
    {'title': 'Anniversary Date', 'hint': 'Select date', 'type': 'date'},
    {'title': 'Family Group ID *', 'hint': '', 'type': 'dropdown', 'options': []},
    {'title': 'Relation to Family Head *', 'hint': '', 'type': 'dropdown', 'options': ["Head", "Spouse", "Child", "Parent", "Sibling", "Other"]},
    {'title': 'Zone ID *', 'hint': '', 'type': 'dropdown', 'options': []},

    // Address Information
    
    {'title': 'Residential Address *', 'hint': 'Residential address', 'type': 'multiline'},
    {'title': 'Permanent Address *', 'hint': 'Permanent address', 'type': 'multiline'},
    {'title': 'City', 'hint': 'City', 'type': 'text'},
    {'title': 'State', 'hint': 'State', 'type': 'text'},
    {'title': 'Country', 'hint': 'Country', 'type': 'text'},
    {'title': 'Pin Code', 'hint': 'Pin code', 'type': 'text'},
    {'title': 'Landmark', 'hint': 'Enter landmark', 'type': 'text'},
    {'title': 'Latitude', 'hint': 'Enter Latitude', 'type': 'text'},
    {'title': 'Longitude', 'hint': 'Enter Longitude', 'type': 'text'},

    // Professional Information
    {'title': 'Profession', 'hint': 'Enter profession', 'type': 'text'},
    {'title': 'Years of Experience', 'hint': 'Enter years of experience', 'type': 'text'},
    {'title': 'Qualifications', 'hint': 'Enter qualifications', 'type': 'text'},
    {'title': 'Company Name', 'hint': 'Enter company name', 'type': 'text'},
    {'title': 'Designation', 'hint': 'Enter designation', 'type': 'text'},
    {'title': 'Department', 'hint': 'Enter department', 'type': 'text'},
    {'title': 'Category', 'hint': '', 'type': 'dropdown', 'options': ["IT", "Education"]},
    {'title': 'Type', 'hint': '', 'type': 'dropdown', 'options': ["Student", "Self Employed", "Entrepreneur"]},

    // Church Information
    {'title': 'Joined Date *', 'hint': 'Select date', 'type': 'date'},
    {'title': 'Last Church', 'hint': 'Enter Last Church', 'type': 'text'},
    {'title': 'Service Language', 'hint': 'Enter service language', 'type': 'text'},
    {'title': 'Baptism Date *', 'hint': 'Select date', 'type': 'date'},
    {'title': 'Active Status *', 'hint': '', 'type': 'dropdown', 'options': ["Active", "Inactive", "Suspended", "Banned"]},
    {'title': 'Attending Time', 'hint': '', 'type': 'dropdown', 'options': ["Morning", "Evening"]},
    {'title': 'House Type', 'hint': 'Owned/Rented', 'type': 'dropdown', 'options': ["Owned", "Rented"]},
  ];

  // Controllers and Error States
  final Map<String, TextEditingController> _textControllers = {};
  final Map<String, bool> _errorStates = {};
  late Future<List<String>> _familyGroupIds;
  late Future<List<String>> _zoneIds;

@override
void initState() {
  super.initState();
  // Initialize controllers and error states
  for (var field in fieldsData) {
    _textControllers[field['title']] = TextEditingController();
    _errorStates[field['title']] = false;
  }
  // Fetch family group IDs
  _familyGroupIds = _fetchFamilyGroupIds();
  _familyGroupIds.then((ids) {
    setState(() {
      fieldsData.firstWhere((field) => field['title'] == 'Family Group ID *')['options'] = ids;
    });
  });

  // Fetch zone IDs
  _zoneIds = _fetchZoneIds();
  _zoneIds.then((ids) {
    setState(() {
      fieldsData.firstWhere((field) => field['title'] == 'Zone ID *')['options'] = ids;
    });
  });
}

Future<List<String>> _fetchZoneIds() async {
  final url = Uri.parse("http://147.93.97.78:5030/zones/");
  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map<String>((zone) => zone['id'].toString()).toList();
    } else {
      throw Exception("Failed to load zone IDs");
    }
  } catch (e) {
    print("Error: $e");
    return [];
  }
}


Future<List<String>> _fetchFamilyGroupIds() async {
  final url = Uri.parse("http://147.93.97.78:5030/groups/");
  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map<String>((group) => group['id'].toString()).toList();
    } else {
      throw Exception("Failed to load family group IDs");
    }
  } catch (e) {
    print("Error: $e");
    return [];
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
      for (var field in fieldsData) {
        String title = field['title'];
        if (title.endsWith('*')) {
          _errorStates[title] = _textControllers[title]!.text.trim().isEmpty;
          if (_errorStates[title]!) {
            // Log the error state
            debugPrint('Error: $title is empty ${_textControllers[title]!.text.trim()}');
          }
        }
      }
    });

    // Check if the form is valid
    bool isValid = !_errorStates.values.contains(true);
    if (isValid) {
      print("Form submitted successfully!");

      
      _submitForm();
    } else {
      print("Form contains errors.");
    }
  }

  void _submitForm() async {
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.MultipartRequest('POST', Uri.parse('http://147.93.97.78:5030/users-with-other-details/'));
    
    final userData = {
      "name": "${_textControllers['First Name *']!.text} ${_textControllers['Middle Name']!.text} ${_textControllers['Last Name *']!.text}",
      "email": _textControllers['Email *']!.text,
      "password": _textControllers['Date of Birth *']!.text,
      "role": "user",
      "group": _textControllers['Family Group ID *']!.text,
      "contact_number": _textControllers['Phone *']!.text,
      "created_by": "admin",
      "dob": _textControllers['Date of Birth *']!.text,
      "permissions_role": 2,
      "joined_date": _textControllers['Joined Date *']!.text,
      "additional_mobile_number": _textControllers['Alternative Phone']!.text,
      "additional_info_data": {
        "baptism_date": _textControllers['Baptism Date *']!.text,
        "social_status": _textControllers['Marital Status *']!.text.toLowerCase(),
        "previous_church": _textControllers['Last Church']!.text,
        "service_language": _textControllers['Service Language']!.text,
        "gender": _textControllers['Gender *']!.text.toString().toLowerCase(),
        "spouse": _textControllers['Spouse']!.text,
        "marital_status": _textControllers['Marital Status *']!.text.toLowerCase(),
        "aadhar_number": _textControllers['Aadhaar Number *']!.text,
        "anniversary_date": _textControllers['Anniversary Date']!.text,
        "house_type": _textControllers['House Type']!.text,
        "attending_time": _textControllers['Attending Time']!.text,
        "hobbies": _textControllers['Hobbies']!.text,
        "zone": _textControllers['Zone ID *']!.text,
        "out_station": false,
        "nationality": _textControllers['Country']!.text,
        "relation_to_family": 1,
        "created_by": "hema"
      },
      "address": {
        "address_type": "home",
        "address_line_1": _textControllers['Residential Address *']!.text,
        "address_line_2": _textControllers['Permanent Address *']!.text,
        "city": _textControllers['City']!.text,
        "state": _textControllers['State']!.text,
        "postal_code": _textControllers['Pin Code']!.text,
        "country": _textControllers['Country']!.text,
        "landmark": _textControllers['Landmark']!.text,
        "latitude": _textControllers['Latitude']!.text,
        "longitude": _textControllers['Longitude']!.text,
        "is_primary": true,
        "created_by": "system"
      },
      "blood_group": {
        "last_donated_date": _textControllers['Last Donated Date']!.text,
        "blood_group_name": _textControllers['Blood Group *']!.text,
        "created_by": "system"
      },
      "professional_details": {
        "profession_name": _textControllers['Profession']!.text,
        "category": _textControllers['Category']!.text,
        "years_of_experience": _textControllers['Years of Experience']!.text,
        "qualification": _textControllers['Qualifications']!.text,
        "type": _textControllers['Type']!.text,
        "designation": _textControllers['Designation']!.text,
        "company_name": _textControllers['Company Name']!.text,
        "department": _textControllers['Department']!.text,
        "created_by": "admin_user"
      }
    };

    request.fields.addAll({
      'user_data': jsonEncode(userData)
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.74,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      margin: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xfff4f7fc),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
          _buildSectionHeader('Personal Details'),
          const Divider(),
          const SizedBox(height: 10),
          ..._buildFormRows(),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  text: "ADD NOW",
                  color: primaryBlue,
                  textColor: Colors.white,
                  // onPressed: _validateForm,
                  onPressed: () {
                    //show snack bar with message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                      content: Text('Error occurred while submitting the form.'),
                      backgroundColor: Colors.red,
                      ),
                    );
                    
                    // _validateForm();


                  },
                ),
                const SizedBox(width: 15),
                CustomButton(
                  text: "CANCEL",
                  color: Colors.grey,
                  textColor: Colors.white,
                  onPressed: () {
                    widget.onPressed!();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Dynamically Build Form Rows
  List<Widget> _buildFormRows() {
    List<Widget> rows = [];
    int i = 0;
    rows.add(const SizedBox(height: 10));

    // Add section header for Personal Information
    rows.add(_buildSectionHeader('Personal Information', fontSize: 18));
    rows.add(const SizedBox(height: 10));

    // Add fields for Personal Information
    while (i < 4) {
      List<Widget> rowChildren = [];
      int count = 0;
      for (; i < 4 && count < 4; i++, count++) {
      rowChildren.add(
        Expanded(
        child: _buildField(fieldsData[i]),
        ),
      );
      if (count < 3) {
        rowChildren.add(const SizedBox(width: 15)); // Add spacing between fields
      }
      }
      if (rowChildren.isNotEmpty) {
      rows.add(
        Row(
        children: rowChildren,
        ),
      );
      rows.add(const SizedBox(height: 15)); // Add spacing after each row
      }
    }

    while (i < 14) {
      List<Widget> rowChildren = [];
      int count = 0;
      for (; i < 14 && count < 3; i++, count++) {
      rowChildren.add(
        Expanded(
        child: _buildField(fieldsData[i]),
        ),
      );
      if (count < 2) {
        rowChildren.add(const SizedBox(width: 15)); // Add spacing between fields
      }
      }
      if (rowChildren.isNotEmpty) {
      rows.add(
        Row(
        children: rowChildren,
        ),
      );
      rows.add(const SizedBox(height: 15)); // Add spacing after each row
      }
    }
    rows.add(const SizedBox(height: 20));

    // Add section header for Family Information
    rows.add(_buildSectionHeader('Family Information', fontSize: 18));
    rows.add(const SizedBox(height: 10));

    // Add fields for Family Information
    while (i < 20) {
      List<Widget> rowChildren = [];
      int count = 0;
      for (; i < 20 && count < 3; i++, count++) {
        rowChildren.add(
          Expanded(
            child: _buildField(fieldsData[i]),
          ),
        );
        if (count < 2) {
          rowChildren.add(const SizedBox(width: 15)); // Add spacing between fields
        }
      }
      if (rowChildren.isNotEmpty) {
        rows.add(
          Row(
            children: rowChildren,
          ),
        );
        rows.add(const SizedBox(height: 15)); // Add spacing after each row
      }
    }
    rows.add(const SizedBox(height: 20));

    // Add section header for Address Information
    rows.add(_buildSectionHeader('Address Information', fontSize: 18));
    rows.add(const SizedBox(height: 10));

    // Add fields for Address Information
    while (i < 29) {
      List<Widget> rowChildren = [];
      int count = 0;
      for (; i < 29 && count < 3; i++, count++) {
        rowChildren.add(
          Expanded(
            child: _buildField(fieldsData[i]),
          ),
        );
        if (count < 2) {
          rowChildren.add(const SizedBox(width: 15)); // Add spacing between fields
        }
      }
      if (rowChildren.isNotEmpty) {
        rows.add(
          Row(
            children: rowChildren,
          ),
        );
        rows.add(const SizedBox(height: 15)); // Add spacing after each row
      }
    }
    rows.add(const SizedBox(height: 20));

    // Add section header for Professional Information
    rows.add(_buildSectionHeader('Professional Information', fontSize: 18));
    rows.add(const SizedBox(height: 10));

    // Add fields for Professional Information
    while (i < 36) {
      List<Widget> rowChildren = [];
      int count = 0;
      for (; i < 36 && count < 3; i++, count++) {
        rowChildren.add(
          Expanded(
            child: _buildField(fieldsData[i]),
          ),
        );
        if (count < 2) {
          rowChildren.add(const SizedBox(width: 15)); // Add spacing between fields
        }
      }
      if (rowChildren.isNotEmpty) {
        rows.add(
          Row(
            children: rowChildren,
          ),
        );
        rows.add(const SizedBox(height: 15)); // Add spacing after each row
      }
    }
    rows.add(const SizedBox(height: 20));

    // Add section header for Church Information
    rows.add(_buildSectionHeader('Church Information', fontSize: 18));
    rows.add(const SizedBox(height: 10));

    // Add fields for Church Information
    while (i < fieldsData.length) {
      List<Widget> rowChildren = [];
      int count = 0;
      for (; i < fieldsData.length && count < 3; i++, count++) {
        rowChildren.add(
          Expanded(
            child: _buildField(fieldsData[i]),
          ),
        );
        if (count < 2) {
          rowChildren.add(const SizedBox(width: 15)); // Add spacing between fields
        }
      }
      if (rowChildren.isNotEmpty) {
        rows.add(
          Row(
            children: rowChildren,
          ),
        );
        rows.add(const SizedBox(height: 15)); // Add spacing after each row
      }
    }

    return rows;
  }


  Widget _buildField(Map<String, dynamic> field) {
    if (field['type'] == 'date') {
      return CalendarApp(
        onDateSelected: (DateTime date) {
          setState(() {
            _textControllers[field['title']]!.text = '${date.year}-${date.month}-${date.day}';
          });
          print("Date ");
          print(_textControllers[field['title']]!.text );
        },
        defaultDate: DateTime.now(),
        title: field['title'],
      );
    } else if (field['type'] == 'dropdown') {
      return DropdownSelector(
        title: field['title'],
        value: _textControllers[field['title']]!.text.isNotEmpty
            ? _textControllers[field['title']]!.text
            : field['options']?.first,
        onChanged: (newValue) {
          setState(() {
            _textControllers[field['title']]!.text = newValue!;
          });
        },
        ItemList: field['options'],
      );
    } else {
      return Textfieldforms(
        title: field['title'],
        hint: field['hint'],
        isBlocked: false,
        isMultiline: field['type'] == 'multiline',
        isController: _textControllers[field['title']]!,
        isErrorText: _errorStates[field['title']]!,
      );
    }
  }

  // Section Header Styling
  Widget _buildSectionHeader(String title,{double fontSize = 18}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: GoogleFonts.manrope(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }
}
