import 'package:church_admin/Service/UserServices.dart';
import 'package:church_admin/Service/ChurchToolsServices.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../Widgets/Calendar.dart';
import '../../../Widgets/CustomButtons.dart';
import '../../../Widgets/DropDown.dart';
import '../../../Widgets/TextFieldForms.dart';

class PrayersForms extends StatefulWidget {
  const PrayersForms({super.key});

  @override
  State<PrayersForms> createState() => _PrayersFormsState();
}

class _PrayersFormsState extends State<PrayersForms> {
  final List<Map<String, dynamic>> fields = [
    {'title': 'Date *', 'hint': '', 'isMultiline': false, 'widgetType': 'calendar'},
    {'title': 'Time *', 'hint': 'Select time', 'isMultiline': false, 'widgetType': 'timepicker'},
    {'title': 'User *', 'hint': 'Select user', 'isMultiline': false, 'widgetType': 'dropdown'},
    {'title': 'Title *', 'hint': 'Enter title', 'isMultiline': false, 'widgetType': 'text'},
    {'title': 'Description *', 'hint': 'Enter description', 'isMultiline': true, 'widgetType': 'text'},
  ];

  final Map<String, TextEditingController> _textControllers = {};
  final Map<String, bool> _errorStates = {};
  final Churchtoolsservices _prayerService = Churchtoolsservices();

  DateTime? selectedDate = DateTime.now();
  TimeOfDay? selectedTime;
  late TextEditingController _timeController; // For time picker display
  String? selectedUserId;
  List<String> userIds = [];
  Map<String, String> userIdToNameMap = {};
  bool isLoading = true;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _timeController = TextEditingController();
    for (var field in fields) {
      if (field['widgetType'] == 'text') {
        _textControllers[field['title']] = TextEditingController();
      }
      if (field['title'].endsWith('*')) {
        _errorStates[field['title']] = false; // Initialize all required fields
      }
    }
    _fetchUserDetails();
  }

  @override
  void dispose() {
    _timeController.dispose();
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

      if (response.isEmpty || response[0]['data'] == null) {
        setState(() {
          userIds = [];
          userIdToNameMap = {};
          selectedUserId = null;
          isLoading = false;
        });
        return;
      }

      final userDetails = response[0]['data'] as List<dynamic>;

      setState(() {
        userIds = userDetails
            .where((user) => user['No'] != null && user['Name'] != null && user['Name']['name'] != null)
            .map((user) => user['No'].toString())
            .toList();

        userIdToNameMap = {
          for (var user in userDetails)
            if (user['No'] != null && user['Name'] != null && user['Name']['name'] != null)
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
      _errorStates['Date *'] = selectedDate == null;
      _errorStates['Time *'] = selectedTime == null;
      _errorStates['User *'] = selectedUserId == null;
      for (var field in fields) {
        String title = field['title'];
        if (title.endsWith('*') && field['widgetType'] == 'text') {
          _errorStates[title] = _textControllers[title]!.text.isEmpty;
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
      print("Form contains errors: $_errorStates");
    }
  }

  Future<void> _submitForm() async {
    setState(() {
      _isSubmitting = true;
    });

    if (selectedDate == null || selectedTime == null || selectedUserId == null) {
      setState(() {
        _isSubmitting = false;
      });
      return;
    }

    final datetime = DateTime(
      selectedDate!.year,
      selectedDate!.month,
      selectedDate!.day,
      selectedTime!.hour,
      selectedTime!.minute,
    );
    String fullDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(datetime);

    bool success = await _prayerService.createPrayerRequest(
      user: selectedUserId!,
      title: _textControllers['Title *']!.text,
      description: _textControllers['Description *']!.text,
      date: fullDateTime,
      createdBy: "admin",
    );

    setState(() {
      _isSubmitting = false;
    });

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Prayer request added successfully')),
      );
      for (var controller in _textControllers.values) {
        controller.clear();
      }
      setState(() {
        selectedDate = DateTime.now();
        selectedTime = null;
        _timeController.clear();
        selectedUserId = userIds.isNotEmpty ? userIds.first : null;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to add prayer request')),
      );
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        _timeController.text = picked.format(context);
        _errorStates['Time *'] = false;
      });
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
              child: _isSubmitting
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionHeader('Add Prayer Request'),
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

    if (fields.length >= 3) {
      rows.add(
        Row(
          children: [
            Expanded(
              child: _buildField(fields[0]['title'], widgetType: fields[0]['widgetType']),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: _buildField(fields[1]['title'], hint: fields[1]['hint'], widgetType: fields[1]['widgetType']),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: _buildField(fields[2]['title'], widgetType: fields[2]['widgetType']),
            ),
          ],
        ),
      );
      rows.add(const SizedBox(height: 15));
    }

    for (int i = 3; i < fields.length; i++) {
      rows.add(
        _buildField(fields[i]['title'], hint: fields[i]['hint'], widgetType: fields[i]['widgetType']),
      );
      rows.add(const SizedBox(height: 15));
    }

    return rows;
  }

  Widget _buildField(String fieldName, {String? hint, String? widgetType}) {
    final hasError = _errorStates[fieldName] ?? false;

    if (widgetType == 'calendar') {
      return CalendarApp(
        title: fieldName,
        defaultDate: selectedDate ?? DateTime.now(),
        onDateSelected: (date) {
          setState(() {
            selectedDate = date;
            _errorStates[fieldName] = false;
          });
        },
      );
    } else if (widgetType == 'timepicker') {
      return GestureDetector(
        onTap: () => _selectTime(context),
        child: AbsorbPointer(
          child: Textfieldforms(
            title: fieldName,
            hint: hint ?? 'Select time',
            isBlocked: false,
            isMultiline: false,
            isController: _timeController,
            isErrorText: hasError,
          ),
        ),
      );
    } else if (widgetType == 'dropdown') {
      if (userIds.isEmpty) {
        return const Text('No users available');
      }
      return DropdownSelector(
        title: fieldName,
        value: selectedUserId ?? '',
        onChanged: (newValue) {
          setState(() {
            selectedUserId = newValue;
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
        isErrorText: hasError,
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