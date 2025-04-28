import 'package:church_admin/Service/UserServices.dart';
import 'package:church_admin/Service/ChurchToolsServices.dart'; // Import the new service
import 'package:church_admin/Widgets/Calendar.dart';
import 'package:church_admin/Widgets/CustomButtons.dart';
import 'package:church_admin/Widgets/DropDown.dart';
import 'package:church_admin/Widgets/TextFieldForms.dart';
import 'package:church_admin/Widgets/TimePickerWidget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; // For date formatting

class FunctionHallForms extends StatefulWidget {
  const FunctionHallForms({super.key});

  @override
  State<FunctionHallForms> createState() => _FunctionHallFormsState();
}

class _FunctionHallFormsState extends State<FunctionHallForms> {
  final List<Map<String, dynamic>> fields = [
    {'title': 'From Date *', 'hint': 'Select date', 'type': 'date'},
    {'title': 'To Date *', 'hint': 'Select date', 'type': 'date'},
    {'title': 'From Time *', 'hint': '', 'type': 'time'},
    {'title': 'To Time *', 'hint': '', 'type': 'time'},
    {'title': 'User *', 'hint': 'Select user', 'type': 'dropdown'},
    {'title': 'Location *', 'hint': 'Enter location', 'type': 'text'},
    {'title': 'Booking For *', 'hint': 'Enter reason', 'type': 'text'},
    {'title': 'Function Name *', 'hint': 'Enter name', 'type': 'text'},
    {'title': 'Phone *', 'hint': 'Enter number', 'type': 'text'},
    {'title': 'Address *', 'hint': 'Enter address', 'type': 'multiline'},
  ];

  final List<Map<String, dynamic>> fields1 = [
    {'title': 'Member Name *', 'hint': 'Enter member name', 'type': 'text'},
  ];

  final Map<String, TextEditingController> _textControllers = {};
  final Map<String, bool> _errorStates = {};
  final Churchtoolsservices _bookingService = Churchtoolsservices();

  DateTime? fromDate = DateTime.now();
  DateTime? toDate = DateTime.now();
  TimeOfDay? fromTime = const TimeOfDay(hour: 0, minute: 0);
  TimeOfDay? toTime = const TimeOfDay(hour: 0, minute: 0);
  String? selectedUserId;
  bool isMemberChecked = false;
  List<String> userIds = [];
  Map<String, String> userIdToNameMap = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    for (var field in [...fields, ...fields1]) {
      if (field['type'] == 'text' || field['type'] == 'multiline') {
        _textControllers[field['title']] = TextEditingController();
        _errorStates[field['title']] = false;
      }
    }
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
          if (field['type'] == 'text' || field['type'] == 'multiline') {
            _errorStates[title] = _textControllers[title]!.text.isEmpty;
          } else if (field['type'] == 'date' && title == 'From Date *') {
            _errorStates[title] = fromDate == null;
          } else if (field['type'] == 'date' && title == 'To Date *') {
            _errorStates[title] = toDate == null;
          } else if (field['type'] == 'time' && title == 'From Time *') {
            _errorStates[title] = fromTime == null;
          } else if (field['type'] == 'time' && title == 'To Time *') {
            _errorStates[title] = toTime == null;
          } else if (field['type'] == 'dropdown') {
            _errorStates[title] = selectedUserId == null;
          }
        }
      }

      if (isMemberChecked) {
        for (var field in fields1) {
          String title = field['title'];
          if (title.endsWith('*')) {
            _errorStates[title] = _textControllers[title]!.text.isEmpty;
          }
        }
      }
    });

    bool isValid = !_errorStates.values.contains(true);
    if (isValid) {
      _submitForm();
    } else {
      if (_errorStates['From Date *'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a from date')),
        );
      } else if (_errorStates['To Date *'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a to date')),
        );
      } else if (_errorStates['From Time *'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a from time')),
        );
      } else if (_errorStates['To Time *'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a to time')),
        );
      } else if (_errorStates['User *'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a user')),
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
    String formattedFromDate = DateFormat('yyyy-MM-dd').format(fromDate!);
    String formattedToDate = DateFormat('yyyy-MM-dd').format(toDate!);
    String formattedFromTime = '${fromTime!.hour.toString().padLeft(2, '0')}:${fromTime!.minute.toString().padLeft(2, '0')}:00';
    String formattedToTime = '${toTime!.hour.toString().padLeft(2, '0')}:${toTime!.minute.toString().padLeft(2, '0')}:00';

    String name = isMemberChecked ? _textControllers['Member Name *']!.text : "Non-Member";

    bool success = await _bookingService.createBooking(
      user: selectedUserId!,
      name: name,
      mobileNumber: _textControllers['Phone *']!.text,
      address: _textControllers['Address *']!.text,
      functionTitle: _textControllers['Function Name *']!.text,
      fromDate: formattedFromDate,
      toDate: formattedToDate,
      fromTime: formattedFromTime,
      toTime: formattedToTime,
      bookingFor: _textControllers['Booking For *']!.text,
      createdBy: "admin",
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Booking added successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to add booking')),
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
            _buildFormContainer(),
          ],
        ),
      ),
    );
  }

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
          _buildSectionHeader('Add Function Hall Booking'),
          const Divider(thickness: 1, color: Color(0xFFE4E6E8)),
          const SizedBox(height: 15),
          if (isLoading)
            const Center(child: CircularProgressIndicator())
          else ...[
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Checkbox(
                    value: isMemberChecked,
                    onChanged: (value) {
                      setState(() {
                        isMemberChecked = value!;
                      });
                    },
                  ),
                  Text(
                    "If Member",
                    style: GoogleFonts.manrope(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            if (isMemberChecked) ...[
              _buildTextField(fields1[0]),
              const SizedBox(height: 15),
            ],
            ..._buildFormRows(),
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
    );
  }

  List<Widget> _buildFormRows() {
    List<Widget> rows = [];

    rows.add(
      Row(
        children: [
          Expanded(child: _buildTextField(fields[0])),
          const SizedBox(width: 15),
          Expanded(child: _buildTextField(fields[1])),
          const SizedBox(width: 15),
          Expanded(child: _buildTextField(fields[2])),
          const SizedBox(width: 15),
          Expanded(child: _buildTextField(fields[3])),
        ],
      ),
    );
    rows.add(const SizedBox(height: 15));

    rows.add(
      Row(
        children: [
          Expanded(child: _buildTextField(fields[4])),
          const SizedBox(width: 15),
          Expanded(child: _buildTextField(fields[5])),
          const SizedBox(width: 15),
          Expanded(child: _buildTextField(fields[6])),
          const SizedBox(width: 15),
          Expanded(child: _buildTextField(fields[7])),
        ],
      ),
    );
    rows.add(const SizedBox(height: 15));

    rows.add(_buildTextField(fields[8]));
    rows.add(const SizedBox(height: 15));

    rows.add(_buildTextField(fields[9]));

    return rows;
  }

  Widget _buildTextField(Map<String, dynamic> field) {
    if (field['type'] == 'date' && field['title'] == 'From Date *') {
      return CalendarApp(
        onDateSelected: (DateTime date) {
          setState(() {
            fromDate = date;
            _errorStates[field['title']] = false;
          });
        },
        defaultDate: fromDate!,
        title: field['title'],
      );
    } else if (field['type'] == 'date' && field['title'] == 'To Date *') {
      return CalendarApp(
        onDateSelected: (DateTime date) {
          setState(() {
            toDate = date;
            _errorStates[field['title']] = false;
          });
        },
        defaultDate: toDate!,
        title: field['title'],
      );
    } else if (field['type'] == 'time' && field['title'] == 'From Time *') {
      return TimePickerWidget(
        title: field['title'],
        onTimeSelected: (TimeOfDay value) {
          setState(() {
            fromTime = value;
            _errorStates[field['title']] = false;
          });
        },
      );
    } else if (field['type'] == 'time' && field['title'] == 'To Time *') {
      return TimePickerWidget(
        title: field['title'],
        onTimeSelected: (TimeOfDay value) {
          setState(() {
            toTime = value;
            _errorStates[field['title']] = false;
          });
        },
      );
    } else if (field['type'] == 'dropdown') {
      return DropdownSelector(
        title: field['title'],
        value: selectedUserId ?? '',
        onChanged: (newValue) {
          setState(() {
            selectedUserId = newValue!;
            _errorStates[field['title']] = false;
          });
        },
        ItemList: userIds,
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