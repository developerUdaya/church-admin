import 'package:church_admin/Service/ApiHandler/FamiliesApiHandler.dart';
import 'package:church_admin/view/Tables/TableForms/FamiliesFromCreation.dart';
import 'package:flutter/material.dart';

import '../../Widgets/AddProductListWidget.dart';
import '../../Widgets/TableWidget.dart';
import '../../Widgets/TitleRow.dart';
import '../Header/DashBoardHeader.dart';

class FamiliesTable extends StatefulWidget {
  final List<Map<String, dynamic>>? testData;
  final String? name;

  const FamiliesTable({super.key, this.testData, this.name});

  @override
  State<FamiliesTable> createState() => _FamiliesTableState();
}

class _FamiliesTableState extends State<FamiliesTable> {
  bool isChange = false;
  late Future<List<Map<String, dynamic>>> futureFamiliesData;

  @override
  void initState() {
    super.initState();
    futureFamiliesData = fetchFamiliesDataFromApi();
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
                  Flexible(
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
