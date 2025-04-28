import 'package:church_admin/Service/ApiHandler/StudentApiHandler.dart';
import 'package:church_admin/Widgets/TitleRow.dart';
import 'package:church_admin/view/Tables/TableForms/StudentsPopForm.dart';
import 'package:flutter/material.dart';

import '../../Widgets/AddProductListWidget.dart';
import '../../Widgets/TableWidget.dart';
import '../Header/DashBoardHeader.dart';

class StudentTable extends StatefulWidget {
  final List<Map<String, dynamic>>? testData;
  final String? name;

  const StudentTable({super.key, this.testData, this.name});

  @override
  State<StudentTable> createState() => _StudentTableState();
}

class _StudentTableState extends State<StudentTable> {
  bool isChange = false;
  String selectedMemberId = 'KIAI0001';
  String selectedMemberName = 'Mark';
  bool isProfileVisible = false;
  late Future<List<Map<String, dynamic>>> futureStudentData;

  @override
  void initState() {
    super.initState();
    futureStudentData = fetchStudentDataFromApi();
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
                          title: 'Add Student',
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
                        ? Studentspopform()
                        : FutureBuilder<List<Map<String, dynamic>>>(
                            future: futureStudentData,
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