import 'package:church_admin/Service/ApiHandler/CommitteApiHandler.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../Widgets/AddProductListWidget.dart';
import '../../Widgets/CustomButtons.dart';
import '../../Widgets/TableWidget.dart';
import '../../Widgets/TextFieldForms.dart';
import '../Header/DashBoardHeader.dart';

class CommitteeTable extends StatefulWidget {
  final List<Map<String, dynamic>>? testData;
  final String? name;

  const CommitteeTable({super.key, this.testData, this.name});

  @override
  State<CommitteeTable> createState() => _CommitteeTableState();
}

class _CommitteeTableState extends State<CommitteeTable> {
  late Future<List<Map<String, dynamic>>> futureCommitteeData;
  bool isChange = false;

  final TextEditingController _committeeNameController =
      TextEditingController();
  final TextEditingController _committeeDescriptionController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    futureCommitteeData = fetchCommitteeDataFromApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F7FB),
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
                          titleName: widget.name ?? 'Committee',
                          onPressed: () {
                            setState(() {
                              isChange = false;
                            });
                          },
                        )
                      : AddProductTittleBar(
                          titleName: widget.name ?? 'Committee',
                          onPressed: () {
                            setState(() {
                              isChange = true;
                              _showPopup(context);
                            });
                          }),
                  SizedBox(height: isChange ? 20 : 30),
                  Flexible(
                    child: FutureBuilder<List<Map<String, dynamic>>>(
                      future: futureCommitteeData,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (snapshot.data == null ||
                            snapshot.data!.isEmpty) {
                          return Center(child: Text('No data available'));
                        } else {
                          return TableWidget(
                            testData: snapshot.data ?? [],
                            name: widget.name ?? 'Committee',
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

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeader('Add Committee'),
                Divider(),
                const SizedBox(height: 10),
                Textfieldforms(
                  title: 'Committee Name *',
                  hint: 'Enter Committee Name',
                  isBlocked: false,
                  isController: _committeeNameController,
                ),
                const SizedBox(height: 10),
                Textfieldforms(
                  title: 'Committee Description',
                  hint: 'Enter Committee Description',
                  isBlocked: false,
                  isController: _committeeDescriptionController,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      text: "Create",
                      color: Colors.green,
                      textColor: Colors.white,
                      onPressed: () {
                        _addCommittee();
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(width: 10),
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

  Future<void> _addCommittee() async {
    final String apiUrl = 'http://147.93.97.78:5030/committee/';

    final Map<String, dynamic> payload = {
      "committee_title": _committeeNameController.text,
      "created_by": "admin",
      "committee_description": _committeeDescriptionController.text,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(payload),
      );

      if (response.statusCode == 201) {
        print("Committee added successfully.");
        setState(() {
          futureCommitteeData = fetchCommitteeDataFromApi();
        });
      } else {
        print("Failed to add committee: ${response.body}");
      }
    } catch (error) {
      print("Error adding committee: $error");
    }
  }
}
