import 'package:church_admin/Service/ApiHandler/DepartmentApiHandler.dart';
import 'package:church_admin/view/Tables/TableForms/DepartmentFromCreation.dart';
import 'package:flutter/material.dart';

import '../../Widgets/AddProductListWidget.dart';
import '../../Widgets/TableWidget.dart';
import '../../Widgets/TitleRow.dart';
import '../Header/DashBoardHeader.dart';

class DepartmentTable extends StatefulWidget {
  final List<Map<String, dynamic>>? testData;
  final String? name;

  const DepartmentTable(
      {super.key,  this.testData,  this.name});

  @override
  State<DepartmentTable> createState() => _DepartmentTableState();
}

class _DepartmentTableState extends State<DepartmentTable> {
  bool isChange = false;
  late Future<List<Map<String, dynamic>>> futureDepartmentData;
  @override
  void initState() {
    super.initState();
    futureDepartmentData = fetchDepartmentDataFromApi();
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
                          title: widget.name ?? '',
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
                        ? DepartmentFormCreation()
                        : FutureBuilder<List<Map<String, dynamic>>>(
                            future: futureDepartmentData,
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
