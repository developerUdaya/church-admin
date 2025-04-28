import 'package:church_admin/Service/UserServices.dart';
import 'package:church_admin/Service/ChurchToolsServices.dart'; // Adjust import as needed
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; // For date formatting
import '../../../Widgets/Calendar.dart';
import '../../../Widgets/CheckBoxe.dart';
import '../../../Widgets/CustomButtons.dart';
import '../../../Widgets/DropDown.dart';
import '../../../Widgets/TextFieldForms.dart';

class RemembranceDaysForms extends StatefulWidget {
  const RemembranceDaysForms({super.key});

  @override
  State<RemembranceDaysForms> createState() => _RemembranceDaysFormsState();
}

class _RemembranceDaysFormsState extends State<RemembranceDaysForms> {
  final List<Map<String, dynamic>> fields = [
    {'title': 'If Member', 'hint': '', 'isMultiline': false, 'widgetType': 'checkbox'},
    {'title': 'Name *', 'hint': 'Enter name', 'isMultiline': false, 'widgetType': 'text'},
    {'title': 'User *', 'hint': 'Select user', 'isMultiline': false, 'widgetType': 'dropdown'},
    {'title': 'Gender *', 'hint': '', 'isMultiline': false, 'widgetType': 'dropdown'},
    {'title': 'Age *', 'hint': 'Enter age', 'isMultiline': false, 'widgetType': 'text'},
    {'title': 'Date of Birth *', 'hint': '', 'isMultiline': false, 'widgetType': 'calendar'},
    {'title': 'Date of Death *', 'hint': '', 'isMultiline': false, 'widgetType': 'calendar'},
    {'title': 'Family *', 'hint': 'Enter family ID', 'isMultiline': false, 'widgetType': 'text'},
    {'title': 'Description', 'hint': 'Enter description', 'isMultiline': true, 'widgetType': 'text'},
  ];

  final Map<String, TextEditingController> _textControllers = {};
  final Map<String, bool> _errorStates = {};
  final Churchtoolsservices _remembranceService = Churchtoolsservices();

  String? selectedGender;
  String? selectedUserId;
  DateTime? dob = DateTime.now(); // Default to today
  DateTime? dod = DateTime.now(); // Default to today
  List<bool> boxChecker = List.generate(1, (index) => false);
  bool isAnyChecked = false;
  List<String> userIds = [];
  Map<String, String> userIdToNameMap = {};
  bool isLoading = true;

  static const List<String> genderOptions = ['male', 'female', 'other'];

  void onChangedCheckBox(bool value, int index) {
    setState(() {
      boxChecker[index] = value;
      isAnyChecked = boxChecker.contains(true);
    });
  }

  @override
  void initState() {
    super.initState();
    for (var field in fields) {
      if (field['widgetType'] == 'text') {
        _textControllers[field['title']] = TextEditingController();
        _errorStates[field['title']] = false;
      }
    }
    selectedGender = genderOptions[0]; // Default to 'male'
    _fetchUserDetails();
  }

  @override
  void dispose() {
    for (var controller in _textControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _fetchUserDetails() async {
    try {
      setState(() {
        isLoading = true;
      });
      final response = await UserServices.fetchUserDetails();

      if (response.isEmpty) {
        setState(() {
          userIds = [];
          userIdToNameMap = {};
          isLoading = false;
        });
        return;
      }

      final userDetails = response[0]['data'] as List<dynamic>;

      setState(() {
        userIds = userDetails
            .where((user) =>
                user['No'] != null &&
                user['Name'] != null &&
                user['Name']['name'] != null)
            .map((user) => user['No'].toString())
            .toList();

        userIdToNameMap = {
          for (var user in userDetails)
            if (user['No'] != null &&
                user['Name'] != null &&
                user['Name']['name'] != null)
              user['No'].toString(): user['Name']['name'].toString()
        };

        selectedUserId = userIds.isNotEmpty ? userIds[0] : null;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching user details: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void _validateForm() {
    setState(() {
      for (var field in fields) {
        String title = field['title'];
        if (title.endsWith('*')) {
          if (field['widgetType'] == 'text') {
            _errorStates[title] = _textControllers[title]!.text.isEmpty;
          } else if (field['widgetType'] == 'dropdown' && title == 'Gender *') {
            _errorStates[title] = selectedGender == null;
          } else if (field['widgetType'] == 'dropdown' && title == 'User *') {
            _errorStates[title] = selectedUserId == null;
          } else if (field['widgetType'] == 'calendar' && title == 'Date of Birth *') {
            _errorStates[title] = dob == null;
          } else if (field['widgetType'] == 'calendar' && title == 'Date of Death *') {
            _errorStates[title] = dod == null;
          }
        }
      }
    });

    bool isValid = !_errorStates.values.contains(true);
    if (isValid) {
      _submitForm();
    } else {
      if (_errorStates['Date of Birth *'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a date of birth')),
        );
      } else if (_errorStates['Date of Death *'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a date of death')),
        );
      } else if (_errorStates['User *'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a user')),
        );
      } else if (_errorStates['Gender *'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a gender')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill all required fields')),
        );
      }
      print("Form errors: $_errorStates");
    }
  }

  Future<void> _submitForm() async {
    String formattedDob = DateFormat('yyyy-MM-dd').format(dob!);
    String formattedDod = DateFormat('yyyy-MM-dd').format(dod!);

    bool success = await _remembranceService.createRemembrance(
      user: selectedUserId!,
      name: _textControllers['Name *']!.text,
      gender: selectedGender!,
      age: _textControllers['Age *']!.text,
      dob: formattedDob,
      dod: formattedDod,
      description: _textControllers['Description']!.text,
      family: _textControllers['Family *']!.text,
      createdBy: "admin",
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Remembrance added successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to add remembrance')),
      );
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
                  _buildSectionHeader('Add New Remembrance Days'),
                  const Divider(thickness: 1, color: Color(0xFFE4E6E8)),
                  const SizedBox(height: 15),
                  if (isLoading)
                    const Center(child: CircularProgressIndicator())
                  else ...[
                    ..._buildFormRows(),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildFormRows() {
    List<Widget> rows = [];

    rows.add(
      Align(
        alignment: Alignment.centerLeft,
        child: CheckBoxes(
          checker: boxChecker,
          text: ["If Member"],
          onChangedCheckBox: onChangedCheckBox,
        ),
      ),
    );
    rows.add(const SizedBox(height: 15));

    rows.add(
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: _buildField('Name *', hint: 'Enter name', widgetType: 'text'),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: _buildField('User *', widgetType: 'dropdown'),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: _buildField('Gender *', widgetType: 'dropdown'),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: _buildField('Age *', hint: 'Enter age', widgetType: 'text'),
          ),
        ],
      ),
    );
    rows.add(const SizedBox(height: 15));

    rows.add(
      Row(
        children: [
          Expanded(
            child: _buildField('Date of Birth *', widgetType: 'calendar'),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: _buildField('Date of Death *', widgetType: 'calendar'),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: _buildField('Family *', hint: 'Enter family ID', widgetType: 'text'),
          ),
        ],
      ),
    );
    rows.add(const SizedBox(height: 15));

    rows.add(
      _buildField('Description', hint: 'Enter description', widgetType: 'text', isMultiline: true),
    );

    return rows;
  }

  Widget _buildField(String fieldName, {String? hint, String? widgetType, bool isMultiline = false}) {
    if (widgetType == 'calendar' && fieldName == 'Date of Birth *') {
      return CalendarApp(
        title: fieldName,
        defaultDate: dob!,
        onDateSelected: (DateTime date) {
          setState(() {
            dob = date;
            _errorStates[fieldName] = false;
          });
        },
      );
    } else if (widgetType == 'calendar' && fieldName == 'Date of Death *') {
      return CalendarApp(
        title: fieldName,
        defaultDate: dod!,
        onDateSelected: (DateTime date) {
          setState(() {
            dod = date;
            _errorStates[fieldName] = false;
          });
        },
      );
    } else if (widgetType == 'dropdown' && fieldName == 'Gender *') {
      return DropdownSelector(
        title: fieldName,
        value: selectedGender ?? '',
        onChanged: (newValue) {
          setState(() {
            selectedGender = newValue!;
            _errorStates[fieldName] = false;
          });
        },
        ItemList: genderOptions,
      );
    } else if (widgetType == 'dropdown' && fieldName == 'User *') {
      return DropdownSelector(
        title: fieldName,
        value: selectedUserId ?? '',
        onChanged: (newValue) {
          setState(() {
            selectedUserId = newValue!;
            _errorStates[fieldName] = false;
          });
        },
        ItemList: userIds,
      );
    } else if (widgetType == 'text') {
      return Textfieldforms(
        title: fieldName,
        hint: hint ?? '',
        isBlocked: false,
        isMultiline: isMultiline,
        isController: _textControllers[fieldName]!,
        isErrorText: _errorStates[fieldName]!,
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
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