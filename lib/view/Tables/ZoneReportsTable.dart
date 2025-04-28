import 'package:church_admin/Service/ApiHandler/ZoneActivitiesApiHandler.dart';
import 'package:church_admin/Widgets/TitleRow.dart';
import 'package:church_admin/view/Tables/TableForms/ZoneReportsFromCreation.dart';
import 'package:flutter/material.dart';

import '../../Widgets/AddProductListWidget.dart';
import '../../Widgets/TableWidget.dart';
import '../Header/DashBoardHeader.dart';

class ZoneReportsTable extends StatefulWidget {
  final List<Map<String, dynamic>>? testData;
  final String? name;

  const ZoneReportsTable(
      {super.key,  this.testData,  this.name});

  @override
  State<ZoneReportsTable> createState() => _ZoneReportsTableState();
}

class _ZoneReportsTableState extends State<ZoneReportsTable> {
  bool isChange = false;
  late Future<List<Map<String, dynamic>>> futureZoneReportData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureZoneReportData = fetchZoneReportFromApi();
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
                          withSized: 0.69,
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
                  Flexible(
                    child: isChange
                        ? ZoneReportsFrom()
                        : FutureBuilder<List<Map<String, dynamic>>>(
                            future: futureZoneReportData,
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
