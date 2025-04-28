import 'package:church_admin/Service/ApiHandler/FinanceApiHandler.dart';
import 'package:church_admin/Widgets/TableWidget.dart';
import 'package:church_admin/view/Tables/TableForms/FundManagementFormsWidget.dart';
import 'package:flutter/material.dart';

import '../../Widgets/AddProductListWidget.dart';
import '../../Widgets/TitleRow.dart';

import '../Header/DashBoardHeader.dart';

class FundManagementTables extends StatefulWidget {
  final List<Map<String, dynamic>>? mainTableData;
  final String? name;
  const FundManagementTables(
      {super.key,  this.mainTableData,  this.name});

  @override
  State<FundManagementTables> createState() => _FundManagementTablesState();
}

class _FundManagementTablesState extends State<FundManagementTables> {
  bool isChange = false;
  late Future<List<Map<String, dynamic>>> futureFundData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureFundData = fetchFinanceFundManagamentDataFromApi();
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
                    child: FutureBuilder<List<Map<String, dynamic>>>(
                      future: futureFundData,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Center(child: Text('No data available'));
                        } else {
                          return isChange
                              ? FundFormsWidget()
                              : TableWidget(
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
