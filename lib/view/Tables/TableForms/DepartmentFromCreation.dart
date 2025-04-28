import 'package:church_admin/Service/UserServices.dart';
import 'package:church_admin/Service/DepartmentService.dart'; // Import the new service
import 'package:church_admin/Widgets/CustomButtons.dart';
import 'package:church_admin/Widgets/DropDown.dart';
import 'package:church_admin/Widgets/TextFieldForms.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DepartmentFormCreation extends StatefulWidget {
  const DepartmentFormCreation({super.key});

  @override
  State<DepartmentFormCreation> createState() => _DepartmentFormCreationState();
}

class _DepartmentFormCreationState extends State<DepartmentFormCreation> {
  final List<Map<String, dynamic>> fields = [
    {'title': 'Department Name/Title *', 'hint': 'Enter Department Name', 'type': 'text', 'isMultiline': false},
    {'title': 'Department Leader *', 'type': 'dropdown'},
    {'title': 'Department Contact *', 'hint': 'Enter Department Contact', 'type': 'text', 'isMultiline': false},
    {'title': 'Department Zone/Area/Location *', 'hint': 'Enter Department Zone/Area/Location', 'type': 'text', 'isMultiline': false},
    {'title': 'City', 'hint': 'Enter City', 'type': 'text', 'isMultiline': false},
    {'title': 'Country', 'hint': 'Enter Country', 'type': 'text', 'isMultiline': false},
    {'title': 'Pincode *', 'hint': 'Enter Pincode', 'type': 'text', 'isMultiline': false},
    {'title': 'Description', 'hint': 'Enter Description', 'type': 'text', 'isMultiline': true},
  ];

  final Map<String, TextEditingController> _textControllers = {};
  final Map<String, bool> _errorStates = {};
  String? selectedDepartmentLeader;
  List<String> userIds = [];
  Map<String, String> userIdToNameMap = {};
  bool isLoading = true;
  final Departmentservice departmentservice = Departmentservice();
  @override
  void initState() {
    super.initState();
    for (var field in fields) {
      if (field['type'] == 'text') {
        _textControllers[field['title']] = TextEditingController();
      }
      _errorStates[field['title']] = false;
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

        selectedDepartmentLeader = userIds.isNotEmpty ? userIds[0] : null;
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
          if (field['type'] == 'text') {
            _errorStates[title] = _textControllers[title]!.text.isEmpty;
          } else if (title == 'Department Leader *') {
            _errorStates[title] = selectedDepartmentLeader == null;
          }
        }
      }
    });

    bool isValid = !_errorStates.values.contains(true);
    if (isValid) {
      _submitForm();
    } else {
      print("Form contains errors.");
    }
  }

  Future<void> _submitForm() async {
    bool success = await departmentservice.createDepartment(
      name: _textControllers['Department Name/Title *']!.text,
      departmentLeader: selectedDepartmentLeader ?? '',
      contact: _textControllers['Department Contact *']!.text,
      location: _textControllers['Department Zone/Area/Location *']!.text,
      createdBy: "admin",
      description: _textControllers['Description']!.text,
      city: _textControllers['City']!.text,
      country: _textControllers['Country']!.text,
      pincode: _textControllers['Pincode *']!.text,
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Department created successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to create department')),
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
          _buildSectionHeader('Add Department Details'),
          const Divider(thickness: 1, color: Color(0xFFE4E6E8)),
          const SizedBox(height: 15),
          if (isLoading)
            const Center(child: CircularProgressIndicator())
          else
            ..._buildFormRows(),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                text: "ADD NOW",
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: _validateForm,
              ),
              const SizedBox(width: 15),
              CustomButton(
                text: "CANCEL",
                color: Colors.grey,
                textColor: Colors.white,
                onPressed: () {
                  print("Form canceled!");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildFormRows() {
    List<Widget> rows = [];

    // First Row: 4 Fields
    if (fields.length >= 4) {
      rows.add(
        Row(
          children: [
            Expanded(child: _buildField(fields[0])),
            const SizedBox(width: 15),
            Expanded(child: _buildField(fields[1])),
            const SizedBox(width: 15),
            Expanded(child: _buildField(fields[2])),
            const SizedBox(width: 15),
            Expanded(child: _buildField(fields[3])),
          ],
        ),
      );
      rows.add(const SizedBox(height: 15));
    }

    // Second Row: 3 Fields
    if (fields.length >= 7) {
      rows.add(
        Row(
          children: [
            Expanded(child: _buildField(fields[4])),
            const SizedBox(width: 15),
            Expanded(child: _buildField(fields[5])),
            const SizedBox(width: 15),
            Expanded(child: _buildField(fields[6])),
          ],
        ),
      );
      rows.add(const SizedBox(height: 15));
    }

    // Remaining Fields
    for (int i = 7; i < fields.length; i++) {
      rows.add(_buildField(fields[i]));
      rows.add(const SizedBox(height: 15));
    }

    return rows;
  }

  Widget _buildField(Map<String, dynamic> field) {
    if (field['type'] == 'text') {
      return Textfieldforms(
        title: field['title'],
        hint: field['hint'],
        isBlocked: false,
        isMultiline: field['isMultiline'] ?? false,
        isController: _textControllers[field['title']]!,
        isErrorText: _errorStates[field['title']]!,
      );
    } else if (field['title'] == 'Department Leader *') {
      return DropdownSelector(
        title: field['title'],
        value: selectedDepartmentLeader ?? '',
        onChanged: (newValue) {
          setState(() {
            selectedDepartmentLeader = newValue;
          });
        },
        ItemList: userIds,
      );
    }
    return const SizedBox();
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