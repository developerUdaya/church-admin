import 'package:church_admin/Service/UserServices.dart';
import 'package:church_admin/Widgets/CustomButtons.dart';
import 'package:church_admin/Widgets/DropDown.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http; // Add http package
import 'dart:convert'; // For JSON encoding

class Studentspopform extends StatefulWidget {
  const Studentspopform({super.key});

  @override
  State<Studentspopform> createState() => _StudentspopformState();
}

class _StudentspopformState extends State<Studentspopform> {
  final List<Map<String, dynamic>> fields = [
    {'title': 'User ID *', 'type': 'dropdown'},
    {'title': 'Name', 'type': 'text'},
  ];

  final Map<String, bool> _errorStates = {};
  String? selectedUserId;
  List<String> userIds = [];
  Map<String, String> userIdToNameMap = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    for (var field in fields) {
      _errorStates[field['title']] = false;
    }
    _fetchUserDetails();
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
      _errorStates['User ID *'] = selectedUserId == null;
    });

    bool isValid = !_errorStates.values.contains(true);
    if (isValid) {
      submitForm(); // Call submitForm instead of just printing
    } else {
      print("Form contains errors.");
    }
  }

  Future<void> submitForm() async {
    if (selectedUserId == null) {
      print('No User ID selected');
      return;
    }
    final url = Uri.parse(
        'http://147.93.97.78:5030/users/update_role/$selectedUserId/student/');
    final payload = {"updated_by": "admin_user"};
    try {
      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(payload),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Member role updated successfully'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Failed to update role: ${response.statusCode}')),
        );
      }
    } catch (e) {
      print('Error submitting form: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error occurred while updating role')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
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
      width: MediaQuery.of(context).size.width * 0.80,
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
          _buildSectionHeader('Student Details'),
          const Divider(),
          const SizedBox(height: 10),
          if (isLoading)
            const Center(child: CircularProgressIndicator())
          else if (userIds.isEmpty)
            const Center(child: Text('No user data available'))
          else
            ..._buildFormRows(),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.bottomRight,
            child: Row(
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
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
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
        rows.add(
          Row(
            children: rowChildren,
          ),
        );
        rows.add(const SizedBox(height: 15));
      }

      i += rowChildren.length ~/ 2 + 1;
    }

    return rows;
  }

  Widget _buildField(Map<String, dynamic> field) {
    if (field['title'] == 'User ID *') {
      return DropdownSelector(
        title: field['title'],
        value: selectedUserId ?? '',
        onChanged: (newValue) {
          setState(() {
            selectedUserId = newValue;
          });
        },
        ItemList: userIds,
      );
    } else if (field['title'] == 'Name') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            field['title'],
            style: GoogleFonts.manrope(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            selectedUserId != null &&
                    userIdToNameMap.containsKey(selectedUserId)
                ? userIdToNameMap[selectedUserId]!
                : 'Select a User ID',
            style: GoogleFonts.manrope(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
        ],
      );
    } else {
      return const SizedBox();
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
