import 'package:church_admin/Service/UserServices.dart';
import 'package:church_admin/Service/ChurchStaffService.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Widgets/AddProductListWidget.dart';
import '../../Widgets/CustomButtons.dart';
import '../../Widgets/DropDown.dart';
import '../../Widgets/TableWidget.dart';
import '../Header/DashBoardHeader.dart';

class ChurchStaffTable extends StatefulWidget {
  final List<Map<String, dynamic>>? testData;
  final String? name;

  const ChurchStaffTable({super.key, this.testData, this.name});

  @override
  State<ChurchStaffTable> createState() => _ChurchStaffTableState();
}

class _ChurchStaffTableState extends State<ChurchStaffTable> {
  bool isChange = false;
  String? selectedUserId;
  List<String> userIds = [];
  Map<String, String> userIdToNameMap = {};
  bool isLoading = true;

  final Churchstaffservice _staffService = Churchstaffservice();

  @override
  void initState() {
    super.initState();
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
                    child: TableWidget(
                      testData: widget.testData ?? [],
                      name: widget.name ?? "",
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
        return StatefulBuilder(
          builder: (context, setState) {
            return Align(
              alignment: Alignment.centerRight,
              child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.60,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 4,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'ADD CHURCH STAFF',
                            style: GoogleFonts.manrope(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          IconButton(
                            icon:
                                const Icon(Icons.close, color: Colors.black54),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                      const Divider(),
                      const SizedBox(height: 20),
                      if (isLoading)
                        const Center(child: CircularProgressIndicator())
                      else ...[
                        DropdownSelector(
                          title: 'Select User',
                          value: selectedUserId ?? '',
                          onChanged: (newValue) {
                            setState(() {
                              selectedUserId = newValue!;
                            });
                          },
                          ItemList: userIds,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Selected User: ${userIdToNameMap[selectedUserId] ?? 'None'}',
                          style: GoogleFonts.manrope(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomButton(
                            text: "Add",
                            color: Colors.blue,
                            textColor: Colors.white,
                            onPressed: () {
                              if (selectedUserId == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Please select a user')),
                                );
                                return;
                              }
                              _showConfirmationDialog(context, selectedUserId!);
                            },
                          ),
                          const SizedBox(width: 10),
                          CustomButton(
                            text: "Clear",
                            color: Colors.red,
                            textColor: Colors.white,
                            onPressed: () {
                              setState(() {
                                selectedUserId =
                                    userIds.isNotEmpty ? userIds[0] : null;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showConfirmationDialog(BuildContext context, String userId) {
    final userName = userIdToNameMap[userId] ?? 'Unknown';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Confirm Addition',
            style: GoogleFonts.manrope(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Are you sure you want to add $userName as church staff?',
            style: GoogleFonts.manrope(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close confirmation dialog
              },
              child: Text(
                'Cancel',
                style: GoogleFonts.manrope(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Close confirmation dialog
                Navigator.of(context).pop(); // Close the main popup
                bool success = await _staffService.updateUserRoleToPastor(
                  userId: userId,
                  updatedBy: "admin_user",
                );
                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Staff added successfully')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Failed to add staff')),
                  );
                }
              },
              child: Text(
                'Confirm',
                style: GoogleFonts.manrope(color: Colors.blue),
              ),
            ),
          ],
        );
      },
    );
  }
}
