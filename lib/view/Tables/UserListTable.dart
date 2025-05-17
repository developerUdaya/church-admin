import 'package:church_admin/Service/UserServices.dart';
import 'package:church_admin/Widgets/TitleRow.dart';
import 'package:church_admin/view/Tables/TableForms/AddNewUser.dart';
import 'package:church_admin/view/Tables/TableForms/EditUser.dart';
import 'package:church_admin/view/Tables/TableForms/UserFormCreation.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../Widgets/AddProductListWidget.dart';
import '../../Widgets/TableWidget.dart';
import '../Header/DashBoardHeader.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class userList_table extends StatefulWidget {
  List<Map<String, dynamic>>? testData;
  String? name;

  userList_table({super.key,  this.testData,  this.name});

  @override
  State<userList_table> createState() => _userList_tableState();
}
class _userList_tableState extends State<userList_table> {
  bool isChange = false;
  String? selectedUserId; // Variable to store the selected user ID

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final fetchedData = await fetchUserDetailsWithContext(context, updateUserList);
      setState(() {
        widget.testData = fetchedData;
      });
    });
  }

  void updateUserList() async {
    final fetchedData = await fetchUserDetailsWithContext(context, updateUserList);
    setState(() {
      widget.testData = fetchedData;
    });
  }

  Future<List<Map<String, dynamic>>> fetchUserDetailsWithContext(BuildContext context, Function updateUserListCallback) async {
    // Your existing fetch logic
    List<Map<String, dynamic>> userList_Table = [];
    final response = await http.get(Uri.parse('http://147.93.97.78:5030/user_with_other_details_by_role/user/'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['users'];
      userList_Table = data.map((user) {
        return {
          "No": user['user']['id'],
          "Name": {
            "name": user['user']['name'],
            "profilePictures": user['user']['profile_image']
          },
          'Phone': user['user']['contact_number'],
          'Pin Code': user['addresses'] != null && user['addresses'].isNotEmpty
              ? user['addresses'][0]['postal_code']
              : '',
          "Status": user['user']['active_status'].toString().replaceFirstMapped(
              RegExp(r'^\w'), (match) => match.group(0)!.toUpperCase()),
          "Action": [
            {
              'label': 'View',
              'icon': HugeIcons.strokeRoundedView,
              'onPressed': () {
                setState(() {
                  selectedUserId = user['user']['id'].toString(); // Set the selected user ID
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
      content: Text('Are you sure you want to delete this user?'),
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
                Uri.parse('http://147.93.97.78:5030/users/${user['user']['id']}/'),
                headers: {'Content-Type': 'application/json'},
                body: jsonEncode({'deleted_by': 'admin'}),
                );

              Navigator.of(context).pop(); // Close the loading dialog

              if (response.statusCode == 200) {
                updateUserListCallback(); // Refresh the user list
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('User deleted successfully')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to delete user')),
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

      // Sort the userList_Table by 'No' (user['user']['id'])
      userList_Table.sort((a, b) => a["No"].compareTo(b["No"]));
    } else {
      throw Exception('Failed to load user details');
    }

    return [
      {
        "header": ['No', 'Name', 'Phone', 'Pin Code', 'Status', 'Action'],
        "dataType": [
          "Text",
          "UserNameWithProfile",
          "Text",
          "Text",
          "Status",
          "Action"
        ],
        "data": userList_Table
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
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    isChange
                        ? TitleRow(
                            title: widget.name ?? 'Default Title',
                            onPressed: () {
                              setState(() {
                                isChange = false;
                                selectedUserId = null; // Reset the selected user ID
                              });
                            },
                          )
                        : AddProductTittleBar(
                            titleName: widget.name ?? '',
                            onPressed: () {
                              setState(() {
                                isChange = true;
                              });
                            },
                          ),
                    SizedBox(height: isChange ? 20 : 30),
                    Expanded(
                      child: isChange
                          ? EditUser(userId: selectedUserId) // Pass the selected user ID
                          : TableWidget(
                              testData: widget.testData ?? [],
                              name: widget.name ?? '',
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
