import 'package:church_admin/Service/UserServices.dart';
import 'package:church_admin/Service/ChurchToolsServices.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../Widgets/Calendar.dart';
import '../../../Widgets/CustomButtons.dart';
import '../../../Widgets/DropDown.dart';
import '../../../Widgets/TextFieldForms.dart';
import '../../../Widgets/TimePickerWidget.dart'; // Import TimePickerWidget

class NoticesForms extends StatefulWidget {
  const NoticesForms({super.key});

  @override
  State<NoticesForms> createState() => _NoticesFormsState();
}

class _NoticesFormsState extends State<NoticesForms> {
  final List<Map<String, dynamic>> fields = [
    {'title': 'Date *', 'hint': '', 'isMultiline': false, 'widgetType': 'calendar'},
    {'title': 'Time *', 'hint': '', 'isMultiline': false, 'widgetType': 'timepicker'},
    {'title': 'User *', 'hint': 'Select user', 'isMultiline': false, 'widgetType': 'dropdown'},
    {'title': 'Title *', 'hint': 'Enter title', 'isMultiline': false, 'widgetType': 'text'},
    {'title': 'Description *', 'hint': 'Enter description', 'isMultiline': true, 'widgetType': 'text'},
  ];

  final Map<String, TextEditingController> _textControllers = {};
  final Map<String, bool> _errorStates = {};
  final Churchtoolsservices _noticeService = Churchtoolsservices();

  DateTime? selectedDate = DateTime.now();
  TimeOfDay? selectedTime = const TimeOfDay(hour: 0, minute: 0); // Default to midnight
  String? selectedUserId;
  List<String> userIds = [];
  Map<String, String> userIdToNameMap = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    for (var field in fields) {
      if (field['widgetType'] == 'text') {
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
          if (field['widgetType'] == 'text') {
            _errorStates[title] = _textControllers[title]!.text.isEmpty;
          } else if (field['widgetType'] == 'calendar') {
            _errorStates[title] = selectedDate == null;
          } else if (field['widgetType'] == 'timepicker') {
            _errorStates[title] = selectedTime == null;
          } else if (field['widgetType'] == 'dropdown') {
            _errorStates[title] = selectedUserId == null;
          }
        }
      }
    });

    bool isValid = !_errorStates.values.contains(true);
    if (isValid) {
      _submitForm();
    } else {
      if (_errorStates['Date *'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a date')),
        );
      } else if (_errorStates['Time *'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a time')),
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
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate!);
    String formattedTime = '${selectedTime!.hour.toString().padLeft(2, '0')}:${selectedTime!.minute.toString().padLeft(2, '0')}';
    DateTime combinedDateTime = DateFormat('yyyy-MM-dd HH:mm').parse('$formattedDate $formattedTime');
    String isoDateTime = combinedDateTime.toUtc().toIso8601String(); // e.g., "2025-01-27T15:30:00.000Z"

    bool success = await _noticeService.createNotice(
      user: selectedUserId!,
      datetime: isoDateTime,
      title: _textControllers['Title *']!.text,
      description: _textControllers['Description *']!.text,
      createdBy: "admin",
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Notice added successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to add notice')),
      );
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
                  _buildSectionHeader('Add Notices'),
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
                        text: "ADD NOW",
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
      Row(
        children: [
          Expanded(
            child: _buildField(fields[0]['title'], widgetType: fields[0]['widgetType']),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: _buildField(fields[1]['title'], widgetType: fields[1]['widgetType']),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: _buildField(fields[2]['title'], widgetType: fields[2]['widgetType']),
          ),
        ],
      ),
    );
    rows.add(const SizedBox(height: 15));

    rows.add(
      _buildField(fields[3]['title'], hint: fields[3]['hint'], widgetType: fields[3]['widgetType']),
    );
    rows.add(const SizedBox(height: 15));

    rows.add(
      _buildField(fields[4]['title'], hint: fields[4]['hint'], widgetType: fields[4]['widgetType']),
    );

    return rows;
  }

  Widget _buildField(String fieldName, {String? hint, String? widgetType}) {
    if (widgetType == 'calendar') {
      return CalendarApp(
        title: fieldName,
        defaultDate: selectedDate!,
        onDateSelected: (date) {
          setState(() {
            selectedDate = date;
            _errorStates[fieldName] = false;
          });
        },
      );
    } else if (widgetType == 'timepicker') {
      return TimePickerWidget(
        title: fieldName,
        onTimeSelected: (TimeOfDay value) {
          setState(() {
            selectedTime = value;
            _errorStates[fieldName] = false;
          });
        },
      );
    } else if (widgetType == 'dropdown') {
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
    } else {
      return Textfieldforms(
        title: fieldName,
        hint: hint ?? '',
        isBlocked: false,
        isMultiline: fields.firstWhere((field) => field['title'] == fieldName)['isMultiline'],
        isController: _textControllers[fieldName]!,
        isErrorText: _errorStates[fieldName]!,
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