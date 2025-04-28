import 'package:church_admin/Service/ZoneActivitiesService.dart';
import 'package:church_admin/Widgets/Calendar.dart';
import 'package:church_admin/Widgets/CustomButtons.dart';
import 'package:church_admin/Widgets/DropDown.dart';
import 'package:church_admin/Widgets/TextFieldForms.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ZoneReportsFrom extends StatefulWidget {
  const ZoneReportsFrom({super.key});

  @override
  State<ZoneReportsFrom> createState() => _ZoneReportsFromState();
}

class _ZoneReportsFromState extends State<ZoneReportsFrom> {
  final Zoneactivitiesservice _zoneTaskService = Zoneactivitiesservice();

  final List<Map<String, dynamic>> fields = [
    {
      'title': 'Zone ID *',
      'hint': 'Enter Zone ID',
      'isMultiline': false,
      'widgetType': 'text'
    },
    {
      'title': 'Zone Area *',
      'hint': 'Enter Zone Area ID',
      'isMultiline': false,
      'widgetType': 'text'
    },
    {
      'title': 'Task Name',
      'hint': 'Enter Task Name',
      'isMultiline': false,
      'widgetType': 'text'
    },
    {
      'title': 'Task Description',
      'hint': 'Enter Task Description',
      'isMultiline': true,
      'widgetType': 'text'
    },
    {
      'title': 'Task Due Date (if applicable)',
      'hint': '',
      'isMultiline': false,
      'widgetType': 'calendar'
    },
    {
      'title': 'Status *',
      'hint': '',
      'isMultiline': false,
      'widgetType': 'dropdown',
      'options': ['pending', 'completed']
    },
    {
      'title': 'Report *',
      'hint': 'Enter Report Content',
      'isMultiline': true,
      'widgetType': 'text'
    },
  ];

  final Map<String, TextEditingController> _textControllers = {};
  final Map<String, bool> _errorStates = {};
  String selectedStatus = 'pending';
  DateTime? selectedDueDate = DateTime.now();
  bool _isLoading = false;

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
    for (var controller in _textControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _validateAndSubmit() {
    setState(() {
      for (var field in fields) {
        String title = field['title'];
        if (title.endsWith('*')) {
          if (field['widgetType'] == 'text') {
            _errorStates[title] = _textControllers[title]!.text.isEmpty;
          } else if (field['widgetType'] == 'dropdown') {
            _errorStates[title] = selectedStatus.isEmpty;
          }
        }
      }
    });
    bool isDateValid = selectedDueDate != null;

    bool isValid = !_errorStates.values.contains(true) && isDateValid;
    if (isValid) {
      _submitForm();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
      print("Form errors: $_errorStates");
    }
  }

  Future<void> _submitForm() async {
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDueDate!);

    setState(() {
      _isLoading = true;
    });
    // selectedDueDate

    bool success = await _zoneTaskService.createZoneTask(
      zone: _textControllers['Zone ID *']!.text,
      zoneArea: _textControllers['Zone Area *']!.text,
      taskName: _textControllers['Task Name']!.text,
      taskDescription: _textControllers['Task Description']!.text,
      dueDate: formattedDate, // Send "" instead of null
      status: selectedStatus,
      report: _textControllers['Report *']!.text,
      createdBy: "admin",
    );

    setState(() {
      _isLoading = false;
    });

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Task assigned successfully')),
      );
      for (var controller in _textControllers.values) {
        controller.clear();
      }
      setState(() {
        selectedDueDate = null;
        selectedStatus = 'pending';
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to assign task')),
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
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionHeader('Add Task Details'),
                        const Divider(thickness: 1, color: Color(0xFFE4E6E8)),
                        const SizedBox(height: 15),
                        ..._buildFormRows(),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: CustomButton(
                            text: "ASSIGN TASK",
                            color: Colors.blue,
                            textColor: Colors.white,
                            onPressed: _validateAndSubmit,
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

  List<Widget> _buildFormRows() {
    List<Widget> rows = [];

    rows.add(
      Row(
        children: [
          Expanded(
            child: _buildTextField('Zone ID *',
                hint: 'Enter Zone ID', isMultiline: false),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: _buildTextField('Zone Area *',
                hint: 'Enter Zone Area ID', isMultiline: false),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: _buildTextField('Task Name',
                hint: 'Enter Task Name', isMultiline: false),
          ),
        ],
      ),
    );
    rows.add(const SizedBox(height: 15));

    rows.add(
      _buildTextField('Task Description',
          hint: 'Enter Task Description', isMultiline: true),
    );
    rows.add(const SizedBox(height: 15));

    rows.add(
      Row(
        children: [
          Expanded(
            child: CalendarApp(
              title: 'Task Due Date (if applicable)',
              onDateSelected: (DateTime date) {
                setState(() {
                  selectedDueDate = date;
                  print("Selected Due Date: $selectedDueDate"); // Debug print
                });
              },
              defaultDate: selectedDueDate ?? DateTime.now(),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: DropdownSelector(
              title: 'Status *',
              value: selectedStatus,
              onChanged: (newValue) {
                setState(() {
                  selectedStatus = newValue!;
                  _errorStates['Status *'] = false;
                });
              },
              ItemList: const ['pending', 'completed'],
            ),
          ),
        ],
      ),
    );
    rows.add(const SizedBox(height: 15));

    rows.add(
      _buildTextField('Report *',
          hint: 'Enter Report Content', isMultiline: true),
    );

    return rows;
  }

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
