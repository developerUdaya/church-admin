import 'package:church_admin/Service/ApiHandler/MembersApiHandler.dart';
import 'package:church_admin/view/Tables/TableForms/MemberFromCreation.dart';
import 'package:flutter/material.dart';

import '../../Widgets/AddProductListWidget.dart';
import '../../Widgets/TableWidget.dart';
import '../../Widgets/TitleRow.dart';
import '../Header/DashBoardHeader.dart';

class MembersTable extends StatefulWidget {
  final List<Map<String, dynamic>>? testData;
  final String? name;

  MembersTable({super.key, this.testData, this.name});

  @override
  State<MembersTable> createState() => _MembersTableState();
}

class _MembersTableState extends State<MembersTable> {
  bool isChange = false;
  late Future<List<Map<String, dynamic>>> futureMembersData;
  @override
  void initState() {
    super.initState();
    futureMembersData = fetchMembersDataFromApi();
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
                      ? TitleRow(
                          title: 'Add Member',
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
                            });
                          }),
                  SizedBox(height: isChange ? 20 : 30),
                  Flexible(
                    child: isChange
                        ? MemberFormCreation()
                        : FutureBuilder<List<Map<String, dynamic>>>(
                            future: futureMembersData,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Center(
                                    child: Text('Error: ${snapshot.error}'));
                              } else if (!snapshot.hasData ||
                                  snapshot.data!.isEmpty) {
                                return Center(child: Text('No data available'));
                              } else {
                                return TableWidget(
                                  testData: snapshot.data!,
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
}
