import 'package:church_admin/Service/UserServices.dart';
import 'package:church_admin/Service/ChurchStaffService.dart'; // Import the service
import 'package:church_admin/Widgets/Calendar.dart';
import 'package:church_admin/Widgets/CustomButtons.dart';
import 'package:church_admin/Widgets/DropDown.dart';
import 'package:church_admin/Widgets/TextFieldForms.dart';
import 'package:church_admin/Widgets/TimePickerWidget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; // For date formatting

class MeetingForms extends StatefulWidget {
  const MeetingForms({super.key});

  @override
  State<MeetingForms> createState() => _MeetingFormsState();
}

class _MeetingFormsState extends State<MeetingForms> {
  final List<Map<String, dynamic>> fields = [
    {'title': 'Date *', 'hint': 'Select date', 'type': 'date'},
    {'title': 'Time *', 'hint': 'Select time', 'type': 'time'},
    {'title': 'Host User *', 'hint': 'Select host', 'type': 'dropdown'},
    {'title': 'Location *', 'hint': 'Enter location', 'type': 'text'},
    {'title': 'Title *', 'hint': 'Enter title', 'type': 'text'},
    {'title': 'Agenda', 'hint': 'Enter agenda', 'type': 'multiline'},
  ];

  final Map<String, TextEditingController> _textControllers = {};
  final Map<String, bool> _errorStates = {};
  final Churchstaffservice _staffService = Churchstaffservice();

  DateTime? selectedDate = DateTime.now(); // Default to today
  TimeOfDay? selectedTime;
  String? selectedHostUserId;
  List<String> userIds = [];
  Map<String, String> userIdToNameMap = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    for (var field in fields) {
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

        selectedHostUserId = userIds.isNotEmpty ? userIds[0] : null;
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
          } else if (field['type'] == 'date') {
            _errorStates[title] = selectedDate == null;
          } else if (field['type'] == 'time') {
            _errorStates[title] = selectedTime == null;
          } else if (field['type'] == 'dropdown') {
            _errorStates[title] = selectedHostUserId == null;
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
      } else if (_errorStates['Host User *'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a host user')),
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
    String formattedTime = selectedTime!.format(context); // e.g., "2:00 PM"
    DateTime combinedDateTime =
        DateFormat('yyyy-MM-dd h:mm a').parse('$formattedDate $formattedTime');
    String isoDateTime = combinedDateTime
        .toUtc()
        .toIso8601String(); // e.g., "2025-02-10T14:00:00Z"

    bool success = await _staffService.createMeeting(
      location: _textControllers['Location *']!.text,
      datetime: isoDateTime,
      hostUser: selectedHostUserId!,
      title: _textControllers['Title *']!.text,
      agenda: _textControllers['Agenda']!.text,
      createdBy: "admin_user",
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Meeting added successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to add meeting')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.73,
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
          _buildSectionHeader('Add New Meeting'),
          const Divider(thickness: 1, color: Color(0xFFE4E6E8)),
          const SizedBox(height: 15),
          if (isLoading)
            const Center(child: CircularProgressIndicator())
          else ...[
            Row(
              children: [
                Expanded(
                    child: _buildField(
                        fields.firstWhere((f) => f['title'] == 'Date *'))),
                const SizedBox(width: 15),
                Expanded(
                    child: _buildField(
                        fields.firstWhere((f) => f['title'] == 'Time *'))),
                const SizedBox(width: 15),
                Expanded(
                    child: _buildField(
                        fields.firstWhere((f) => f['title'] == 'Host User *'))),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                    child: _buildField(
                        fields.firstWhere((f) => f['title'] == 'Location *'))),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: _buildField(
                        fields.firstWhere((f) => f['title'] == 'Title *'))),
              ],
            ),
           
            const SizedBox(height: 15),
            _buildField(fields.firstWhere((f) => f['title'] == 'Agenda')),
            const SizedBox(height: 15),
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

  Widget _buildField(Map<String, dynamic> field) {
    if (field['type'] == 'date') {
      return CalendarApp(
        onDateSelected: (DateTime date) {
          setState(() {
            selectedDate = date;
            _errorStates[field['title']] = false;
          });
        },
        defaultDate: selectedDate ?? DateTime.now(),
        title: field['title'],
      );
    } else if (field['type'] == 'time') {
      return TimePickerWidget(
        title: field['title'],
        onTimeSelected: (TimeOfDay value) {
          setState(() {
            selectedTime = value;
            _errorStates[field['title']] = false;
          });
        },
      );
    } else if (field['type'] == 'dropdown') {
      return DropdownSelector(
        title: field['title'],
        value: selectedHostUserId ?? '',
        onChanged: (newValue) {
          setState(() {
            selectedHostUserId = newValue!;
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
