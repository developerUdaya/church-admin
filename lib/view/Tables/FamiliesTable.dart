import 'package:church_admin/Service/ApiHandler/FamiliesApiHandler.dart';
import 'package:church_admin/view/Tables/TableForms/FamiliesFromCreation.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../Widgets/AddProductListWidget.dart';
import '../../Widgets/TableWidget.dart';
import '../../Widgets/TitleRow.dart';
import '../Header/DashBoardHeader.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Church Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  FamiliesTable(testData: [],),
    );
  }
}

class FamiliesTable extends StatefulWidget {
   List<Map<String, dynamic>>? testData;
  final String? name;

   FamiliesTable({super.key, this.testData, this.name});

  @override
  State<FamiliesTable> createState() => _FamiliesTableState();
}

class _FamiliesTableState extends State<FamiliesTable> {
  bool isChange = false;
  late Future<List<Map<String, dynamic>>> futureFamiliesData;
  String? selectedUserId; // Variable to store the selected family ID

  @override
  void initState() {
    super.initState();
    futureFamiliesData = fetchFamiliesDataFromApi();
  
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final fetchedData = await fetchFamiliesData( );
      setState(() {
        widget.testData = fetchedData;
      });
    });
  }

 void updateUserList() async {
    final fetchedData = await fetchFamiliesData( );
    setState(() {
      widget.testData = fetchedData;
    });
  }

    Future<List<Map<String, dynamic>>> fetchFamiliesData() async {
    List<Map<String, dynamic>> responseDataTable = [];

    try {
      final response = await http.get(Uri.parse("http://147.93.97.78:5030/fetch_all_family_with_other_details/"));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        responseDataTable = data.map((data) {
          return {
            "No": data['family_id'],
            "Title": data['title'],
            "FamilyLeader": data['family_head'],
            "Family Count": {"profilePictures":[data['family_members_imageUrls'][0].toString() ],
            "count": data['family_count']??0},
            "Phone": data['head_mobile_number'] ?? '',
            // "Status": 'Active', // Assuming status is always 'Active'
            "Active": [
            {
              'label': 'View',
              'icon': HugeIcons.strokeRoundedView,
              'onPressed': () {
                setState(() {
                  selectedUserId =data['family_id'].toString(); // Set the selected family ID
                  isChange = true; // Switch to the EditUser view
                });
              },
            },
            {
              'label': 'Delete',
              'icon': HugeIcons.strokeRoundedDelete01,
              'onPressed': () {
                // Your existing delete logic
                //
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Confirm Deletion'),
                      content: Text('Are you sure you want to delete this family?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () async {
                            Navigator.of(context).pop(); // Close the dialog
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            );

                            try {
                                final response = await http.delete(
                                Uri.parse('http://147.93.97.78:5030/users/${data['family_id']}/'),
                                headers: {'Content-Type': 'application/json'},
                                body: jsonEncode({'deleted_by': 'admin'}),
                                );

                              Navigator.of(context).pop(); // Close the loading dialog

                              if (response.statusCode == 200) {
                                updateUserList(); // Refresh the family list
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Family deleted successfully')),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Failed to delete family')),
                                );
                              }
                            } catch (e) {
                              Navigator.of(context).pop(); // Close the loading dialog
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('An error occurred: $e')),
                              );
                            }
                          },
                          child: Text('Delete'),
                        ),
                      ],
                    );
                  },
                );


                //
              },
            }
          ]
          };
        }).toList();
      } else {
        print("Error fetching data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching data: $e");
    }

    return [
      {
    "header": [
      'No',
      'Title',
      'FamilyLeader',
      'Family Count',
      'Phone',
      // 'Status',
      'Action'
    ],
    "dataType": [
      "Text",
      "Text",
      "Text",
      "UserList",
      "Text",
      // "Status",
      "Action"
    ],
        "data": responseDataTable
      }
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F7FB),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          DashboardHeader(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  isChange
                      ? TitleRow(
                          title: widget.name ?? 'Default Name',
                          onPressed: () {
                            setState(() {
                              isChange = false;
                            });
                          },
                        )
                      : AddProductTittleBar(
                          titleName: widget.name ?? 'Default Name',
                          onPressed: () {
                            setState(() {
                              isChange = true;
                            });
                          }),
                  SizedBox(height: isChange ? 20 : 30),
                  Expanded(
                    child: isChange
                        ? FamiliesFormCreation()
                        : FutureBuilder<List<Map<String, dynamic>>>(
                            future: futureFamiliesData,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Center(child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Center(child: Text('Error: ${snapshot.error}'));
                              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                return Center(child: Text('No data available'));
                              } else {
                                return TableWidget(
                                  testData: snapshot.data!,
                                  name: widget.name ?? 'Default Name',
                                );
                              }
                            },
                          ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
