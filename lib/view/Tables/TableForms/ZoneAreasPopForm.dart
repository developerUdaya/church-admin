import 'package:church_admin/Service/UserServices.dart';
import 'package:church_admin/Service/ZoneActivitiesService.dart'; // Import the new service
import 'package:church_admin/Widgets/CustomButtons.dart';
import 'package:church_admin/Widgets/DropDown.dart';
import 'package:church_admin/Widgets/TextFieldForms.dart';
import 'package:church_admin/Widgets/TitleRow.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ZoneAreaPopForm extends StatefulWidget {
  const ZoneAreaPopForm({super.key});

  @override
  State<ZoneAreaPopForm> createState() => _ZoneAreaPopFormState();
}

class _ZoneAreaPopFormState extends State<ZoneAreaPopForm> {
  final Zoneactivitiesservice _zoneService = Zoneactivitiesservice();

  // Controllers and error states for the form fields
  final Map<String, TextEditingController> _textControllers = {
    'Area Name *': TextEditingController(),
    'Head Mobile Number *': TextEditingController(),
  };
  final Map<String, bool> _errorStates = {
    'Area Name *': false,
    'Head User *': false,
    'Head Mobile Number *': false,
  };

  String? selectedHeadUserId;
  List<String> userIds = [];
  Map<String, String> userIdToNameMap = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
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

  void _validateAndSubmit() {
    setState(() {
      _errorStates['Area Name *'] = _textControllers['Area Name *']!.text.isEmpty;
      _errorStates['Head User *'] = selectedHeadUserId == null;
      _errorStates['Head Mobile Number *'] = _textControllers['Head Mobile Number *']!.text.isEmpty;
    });

    bool isValid = !_errorStates.values.contains(true);
    if (isValid) {
      _submitForm();
    } else {
      if (_errorStates['Area Name *'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter an area name')),
        );
      } else if (_errorStates['Head User *'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a head user')),
        );
      } else if (_errorStates['Head Mobile Number *'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter a head mobile number')),
        );
      }
    }
  }

  Future<void> _submitForm() async {
    bool success = await _zoneService.createZone(
      name: _textControllers['Area Name *']!.text,
      headUser: selectedHeadUserId!,
      headMobileNumber: _textControllers['Head Mobile Number *']!.text,
      createdBy: "admin_user",
    );

    if (success) {
      Navigator.pop(context); // Close the dialog
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Zone added successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to add zone')),
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
            TitleRow(
              title: 'Add Area',
              onPressed: () {
                _showPopup(context);
              },
            ),
            const SizedBox(height: 30),
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

  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.2),
                  spreadRadius: 4,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            width: MediaQuery.of(context).size.width * 0.30,
            padding: const EdgeInsets.all(20),
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionHeader('Add Area'),
                      const Divider(),
                      const SizedBox(height: 10),
                      Textfieldforms(
                        title: 'Area Name *',
                        hint: 'Enter Area Name',
                        isBlocked: false,
                        isController: _textControllers['Area Name *']!,
                        isErrorText: _errorStates['Area Name *']!,
                      ),
                      const SizedBox(height: 15),
                      DropdownSelector(
                        title: 'Head User *',
                        value: selectedHeadUserId ?? '',
                        onChanged: (newValue) {
                          setState(() {
                            selectedHeadUserId = newValue!;
                            _errorStates['Head User *'] = false;
                          });
                        },
                        ItemList: userIds,
                      ),
                      const SizedBox(height: 15),
                      Textfieldforms(
                        title: 'Head Mobile Number *',
                        hint: 'Enter Head Mobile Number',
                        isBlocked: false,
                        isController: _textControllers['Head Mobile Number *']!,
                        isErrorText: _errorStates['Head Mobile Number *']!,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomButton(
                            text: "Create",
                            color: Colors.green,
                            textColor: Colors.white,
                            onPressed: _validateAndSubmit,
                          ),
                          const SizedBox(width: 10),
                          CustomButton(
                            text: "Cancel",
                            color: Colors.red,
                            textColor: Colors.white,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}