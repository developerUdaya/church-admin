import 'package:church_admin/Service/ApiHandler/ZoneActivitiesApiHandler.dart';
import 'package:church_admin/Service/UserServices.dart';
import 'package:church_admin/Service/ZoneActivitiesService.dart';
import 'package:church_admin/Widgets/CustomButtons.dart';
import 'package:church_admin/Widgets/DropDown.dart';
import 'package:church_admin/Widgets/TextFieldForms.dart';
import 'package:church_admin/Widgets/AddProductListWidget.dart';
import 'package:church_admin/Widgets/TableWidget.dart';
import 'package:church_admin/view/Header/DashBoardHeader.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class zoneAreas_table extends StatefulWidget {
  final String? name;

  const zoneAreas_table({super.key,  this.name});

  @override
  State<zoneAreas_table> createState() => _zoneAreas_tableState();
}

class _zoneAreas_tableState extends State<zoneAreas_table> {
  bool isChange = false;
  late Future<List<Map<String, dynamic>>> futureZoneAreasData;

  // Form state
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
  bool isLoadingUsers = true;

  @override
  void initState() {
    super.initState();
    futureZoneAreasData = fetchZoneAreaDataFromApi();
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
        isLoadingUsers = true;
      });
      final response = await UserServices.fetchUserDetails();

      if (response.isEmpty) {
        setState(() {
          userIds = [];
          userIdToNameMap = {};
          isLoadingUsers = false;
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
        isLoadingUsers = false;
      });
    } catch (e) {
      print('Error fetching user details: $e');
      setState(() {
        isLoadingUsers = false;
      });
    }
  }

  void _validateAndSubmit() {
    setState(() {
      _errorStates['Area Name *'] =
          _textControllers['Area Name *']!.text.isEmpty;
      _errorStates['Head User *'] = selectedHeadUserId == null;
      _errorStates['Head Mobile Number *'] =
          _textControllers['Head Mobile Number *']!.text.isEmpty;
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
    bool success = await Zoneactivitiesservice().createZone(
      name: _textControllers['Area Name *']!.text,
      headUser: selectedHeadUserId!,
      headMobileNumber: _textControllers['Head Mobile Number *']!.text,
      createdBy: "admin_user",
    );

    if (success) {
      Navigator.pop(context); // Close the dialog
      setState(() {
        isChange = false;
        futureZoneAreasData = fetchZoneAreaDataFromApi(); // Refresh table data
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Zone area added successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to add zone area')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          DashboardHeader(),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  isChange
                      ? AddProductTittleBar(
                          titleName: widget.name ?? '',
                          onPressed: () {
                            setState(() {
                              isChange = false;
                            });
                          },
                        )
                      : AddProductTittleBar(
                          titleName: widget.name ?? '',
                          onPressed: () {
                            setState(() {
                              isChange = true;
                              _showPopup(context);
                            });
                          },
                        ),
                  SizedBox(height: isChange ? 20 : 30),
                  Flexible(
                    child: FutureBuilder<List<Map<String, dynamic>>>(
                      future: futureZoneAreasData,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        } else {
                          return TableWidget(
                            testData: snapshot.data ?? [],
                            name: widget.name ?? '',
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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
            child: isLoadingUsers
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
