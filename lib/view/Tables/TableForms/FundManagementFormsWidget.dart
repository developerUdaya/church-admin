import 'dart:io';
import 'dart:typed_data';

import 'package:church_admin/Service/UserServices.dart';
import 'package:church_admin/Service/FinanceService.dart';
import 'package:church_admin/Widgets/AddProductPhotoWidget.dart';
import 'package:church_admin/Widgets/Calendar.dart';
import 'package:church_admin/Widgets/CustomButtons.dart';
import 'package:church_admin/Widgets/DropDown.dart';
import 'package:church_admin/Widgets/TextFieldForms.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class FundFormsWidget extends StatefulWidget {
  const FundFormsWidget({super.key});

  @override
  State<FundFormsWidget> createState() => _FundFormsWidgetState();
}

class _FundFormsWidgetState extends State<FundFormsWidget> {
  final List<Map<String, dynamic>> fields = [
    {'title': 'Amount *', 'hint': 'Enter your amount', 'type': 'text'},
    {'title': 'Verifier *', 'type': 'dropdown'},
    {'title': 'Source *', 'hint': 'Enter source', 'type': 'text'},
    {'title': 'Remarks', 'hint': 'Enter remarks', 'type': 'multiline'},
  ];

  String recordType = 'Receivable';
  DateTime? selectedDate = DateTime.now(); // Default to today
  String? selectedVerifier;
  List<String> userIds = [];
  Map<String, String> userIdToNameMap = {};
  bool isLoading = true;
  File? selectedImageFile;
  Uint8List? selectedImageBytes;
  final Map<String, TextEditingController> _textControllers = {};
  final Map<String, bool> _errorStates = {};
  final Financeservice _fundService = Financeservice();

  @override
  void initState() {
    super.initState();
    for (var field in fields) {
      if (field['type'] == 'text' || field['type'] == 'multiline') {
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

        selectedVerifier = userIds.isNotEmpty ? userIds[0] : null;
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
          } else if (title == 'Verifier *') {
            _errorStates[title] = selectedVerifier == null;
          }
        }
      }
    });

    bool isDateValid = selectedDate != null;
    bool isValid = !_errorStates.values.contains(true) && isDateValid;

    if (isValid) {
      _submitForm();
    } else {
      if (!isDateValid) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a date')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill all required fields')),
        );
      }
      print("Form contains errors. Date: $selectedDate, Errors: $_errorStates");
    }
  }

  Future<void> _submitForm() async {
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate!);
    bool success = await _fundService.createFundRecord(
      date: formattedDate,
      amount: _textControllers['Amount *']!.text,
      recordType: recordType,
      verifier: selectedVerifier ?? '',
      source: _textControllers['Source *']!.text,
      remarks: _textControllers['Remarks']!.text,
      createdBy: "admin_user",
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Fund record created successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to create fund record')),
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
          _buildSectionHeader('Fund Information'),
          const Divider(thickness: 1, color: Color(0xFFE4E6E8)),
          const SizedBox(height: 15),
          Center(
            child: AddproductphotoWidget(
              titleName: 'Add Photo/Document',
              onImageSelected: (File? file, Uint8List? bytes) {
                setState(() {
                  selectedImageFile = file;
                  selectedImageBytes = bytes;
                });
              },
            ),
          ),
          const SizedBox(height: 15),
          if (isLoading)
            const Center(child: CircularProgressIndicator())
          else ...[
            Row(
              children: [
                Expanded(
                  child: CalendarApp(
                    onDateSelected: (DateTime date) {
                      setState(() {
                        selectedDate = date;
                        print("Date selected: $selectedDate"); // Debug log
                      });
                    },
                    defaultDate: selectedDate ?? DateTime.now(),
                    title: 'Select Date *',
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                    child: _buildField(
                        fields.firstWhere((f) => f['title'] == 'Amount *'))),
                const SizedBox(width: 15),
                Expanded(
                  child: DropdownSelector(
                    title: 'Record Type *',
                    value: recordType,
                    onChanged: (newValue) {
                      setState(() {
                        recordType = newValue!;
                      });
                    },
                    ItemList: ["Receivable", "Expense"],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                    child: _buildField(
                        fields.firstWhere((f) => f['title'] == 'Verifier *'))),
                const SizedBox(width: 15),
                Expanded(
                    child: _buildField(
                        fields.firstWhere((f) => f['title'] == 'Source *'))),
              ],
            ),
            const SizedBox(height: 15),
            _buildField(fields.firstWhere((f) => f['title'] == 'Remarks')),
            const SizedBox(height: 15),
            Align(
              alignment: Alignment.bottomRight,
              child: CustomButton(
                text: "Submit",
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
    if (field['type'] == 'text' || field['type'] == 'multiline') {
      return Textfieldforms(
        title: field['title'],
        hint: field['hint'],
        isBlocked: false,
        isMultiline: field['type'] == 'multiline',
        isController: _textControllers[field['title']]!,
        isErrorText: _errorStates[field['title']]!,
      );
    } else if (field['title'] == 'Verifier *') {
      return DropdownSelector(
        title: field['title'],
        value: selectedVerifier ?? '',
        onChanged: (newValue) {
          setState(() {
            selectedVerifier = newValue;
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
