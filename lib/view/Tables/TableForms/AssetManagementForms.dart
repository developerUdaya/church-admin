import 'dart:io';
import 'dart:typed_data';

import 'package:church_admin/Service/UserServices.dart';
import 'package:church_admin/Service/FinanceService.dart'; // Import the new service
import 'package:church_admin/Widgets/AddProductPhotoWidget.dart';
import 'package:church_admin/Widgets/Calendar.dart';
import 'package:church_admin/Widgets/CustomButtons.dart';
import 'package:church_admin/Widgets/DropDown.dart';
import 'package:church_admin/Widgets/TextFieldForms.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; // For date formatting

class AssetManagementForms extends StatefulWidget {
  const AssetManagementForms({super.key});

  @override
  State<AssetManagementForms> createState() => _AssetManagementFormsState();
}

class _AssetManagementFormsState extends State<AssetManagementForms> {
  final List<Map<String, dynamic>> fields = [
    {'title': 'Asset Name *', 'hint': 'Enter asset name', 'type': 'text'},
    {'title': 'Approximate Value *', 'hint': 'Enter value', 'type': 'text'},
    {'title': 'Verifier *', 'type': 'dropdown'},
    {'title': 'Quantity', 'hint': 'Enter quantity', 'type': 'text'},
    {'title': 'Location', 'hint': 'Enter location', 'type': 'text'},
    {'title': 'Remarks', 'hint': 'Enter remarks', 'type': 'multiline'},
  ];

  DateTime? date = DateTime.now(); // Default to today
  DateTime? amcDate = DateTime.now(); // Default to today
  DateTime? insuranceDate; // Optional, no default
  String? selectedVerifier;
  List<String> userIds = [];
  Map<String, String> userIdToNameMap = {};
  bool isLoading = true;
  File? selectedImageFile;
  Uint8List? selectedImageBytes;
  final Map<String, TextEditingController> _textControllers = {};
  final Map<String, bool> _errorStates = {};
  final Financeservice _assetService = Financeservice();

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

    bool isDateValid = date != null;
    bool isAmcDateValid = amcDate != null;
    bool isValid =
        !_errorStates.values.contains(true) && isDateValid && isAmcDateValid;

    if (isValid) {
      _submitForm();
    } else {
      if (!isDateValid) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a date')),
        );
      } else if (!isAmcDateValid) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select an AMC date')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill all required fields')),
        );
      }
      print("Form errors: Date: $date, AMC: $amcDate, Errors: $_errorStates");
    }
  }

  Future<void> _submitForm() async {
    String formattedDate = DateFormat('yyyy-MM-dd').format(date!);
    String formattedAmcDate = DateFormat('yyyy-MM-dd').format(amcDate!);
    String? formattedInsuranceDate = insuranceDate != null
        ? DateFormat('yyyy-MM-dd').format(insuranceDate!)
        : null;

    bool success = await _assetService.createAsset(
      assetName: _textControllers['Asset Name *']!.text,
      approximateValue: _textControllers['Approximate Value *']!.text,
      verifier: selectedVerifier ?? '',
      description: _textControllers['Remarks']!.text,
      date: formattedDate,
      location: _textControllers['Location']!.text,
      quantity: _textControllers['Quantity']!.text,
      createdBy: "admin",
      amcDate: formattedAmcDate,
      imageBytes: selectedImageBytes,
      imageFile: selectedImageFile,
      insuranceDate: formattedInsuranceDate,
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Asset created successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to create asset')),
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
          _buildSectionHeader('Add New Record'),
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
            ..._buildFirstRow(),
            ..._buildRemainingRows(),
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

  List<Widget> _buildFirstRow() {
    return [
      Row(
        children: [
          Expanded(
            child: CalendarApp(
              onDateSelected: (DateTime selected) {
                setState(() {
                  date = selected;
                });
              },
              defaultDate: date ?? DateTime.now(),
              title: 'Date *',
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: CalendarApp(
              onDateSelected: (DateTime selected) {
                setState(() {
                  amcDate = selected;
                  print("AMC Date selected: $amcDate");
                });
              },
              defaultDate: amcDate ?? DateTime.now(),
              title: 'AMC Date *',
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: CalendarApp(
              onDateSelected: (DateTime selected) {
                setState(() {
                  insuranceDate = selected;
                });
              },
              defaultDate: insuranceDate ?? DateTime.now(),
              title: 'Insurance Date (If applicable)',
            ),
          ),
          const SizedBox(width: 15),
          Expanded(child: _buildField(fields[0])), // Asset Name *
        ],
      ),
      const SizedBox(height: 15),
    ];
  }

  List<Widget> _buildRemainingRows() {
    List<Widget> rows = [];

    for (int i = 1; i < fields.length - 1; i += 2) {
      rows.add(
        Row(
          children: [
            Expanded(child: _buildField(fields[i])),
            const SizedBox(width: 15),
            if (i + 1 < fields.length - 1)
              Expanded(child: _buildField(fields[i + 1])),
          ],
        ),
      );
      rows.add(const SizedBox(height: 15));
    }

    rows.add(_buildField(fields.last)); // Remarks
    rows.add(const SizedBox(height: 15));

    return rows;
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
