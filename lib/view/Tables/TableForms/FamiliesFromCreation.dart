import 'dart:io';
import 'dart:typed_data';

import 'package:church_admin/Service/UserServices.dart';
import 'package:church_admin/Service/Familiesservice.dart';
import 'package:church_admin/Widgets/AddProductPhotoWidget.dart';
import 'package:church_admin/Widgets/CustomButtons.dart';
import 'package:church_admin/Widgets/DropDown.dart';
import 'package:church_admin/Widgets/TextFieldForms.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FamiliesFormCreation extends StatefulWidget {
  const FamiliesFormCreation({super.key});

  @override
  State<FamiliesFormCreation> createState() => _FamiliesFormCreationState();
}

class _FamiliesFormCreationState extends State<FamiliesFormCreation> {
  final List<Map<String, dynamic>> fields = [
    {
      'title': 'Family Name/Title *',
      'hint': 'Enter Title',
      'type': 'text',
      'isMultiline': false
    },
    {'title': 'Head User *', 'type': 'dropdown'},
  ];

  final Map<String, TextEditingController> _textControllers = {};
  final Map<String, bool> _errorStates = {};
  String? selectedHeadUserId;
  List<String> userIds = [];
  Map<String, String> userIdToNameMap = {};
  bool isLoading = true;
  final Familiesservice _familiesService = Familiesservice();
  File? selectedImageFile;
  Uint8List? selectedImageBytes;
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

        selectedHeadUserId = userIds.isNotEmpty ? userIds[0] : null;
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
          } else if (title == 'Head User *') {
            _errorStates[title] = selectedHeadUserId == null;
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
    bool success = await _familiesService.createFamilyGroup(
      groupName: _textControllers['Family Name/Title *']!.text,
      headUser: selectedHeadUserId ?? '',
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Family group created successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to create family group')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.73,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Family Details'),
            const Divider(),
            const SizedBox(height: 10),
            _buildPhotoWidget(),
            const SizedBox(height: 20),
            if (isLoading)
              const Center(child: CircularProgressIndicator())
            else
              ..._buildFormRows(),
            const SizedBox(height: 20),
            _buildButtons(),
          ],
        ),
      ),
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

  Widget _buildPhotoWidget() {
    return Center(
      child: AddproductphotoWidget(
        titleName: 'Add Family Photo',
        outerHeight: 0.30,
        onImageSelected: (File? file, Uint8List? bytes) {
          setState(() {
            selectedImageFile = file;
            selectedImageBytes = bytes;
          });
        },
      ),
    );
  }

  List<Widget> _buildFormRows() {
    List<Widget> rows = [];
    int i = 0;

    while (i < fields.length) {
      List<Widget> rowChildren = [];
      for (int j = 0; j < 2 && i + j < fields.length; j++) {
        rowChildren.add(
          Expanded(
            child: _buildField(fields[i + j]),
          ),
        );
        if (j < 1 && i + j + 1 < fields.length) {
          rowChildren.add(const SizedBox(width: 15));
        }
      }

      if (rowChildren.isNotEmpty) {
        rows.add(Row(children: rowChildren));
        rows.add(const SizedBox(height: 15));
      }
      i += 2;
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
    } else if (field['title'] == 'Head User *') {
      return DropdownSelector(
        title: field['title'],
        value: selectedHeadUserId ?? '',
        onChanged: (newValue) {
          setState(() {
            selectedHeadUserId = newValue;
          });
        },
        ItemList: userIds,
      );
    }
    return const SizedBox();
  }

  Widget _buildButtons() {
    return Row(
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
    );
  }
}
