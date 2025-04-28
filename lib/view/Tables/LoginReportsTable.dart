import 'package:church_admin/Service/ApiHandler/SecurityApiHandler.dart';
import 'package:flutter/material.dart';

import '../../Widgets/AddProductListWidget.dart';
import '../../Widgets/TableWidget.dart';
import '../Header/DashBoardHeader.dart';

class LoginReportsTable extends StatefulWidget {

  final List<Map<String, dynamic>>? testData;
  final String? name;
  const LoginReportsTable({super.key,  this.testData,  this.name});

  @override
  State<LoginReportsTable> createState() => _LoginReportsTableState();
}

class _LoginReportsTableState extends State<LoginReportsTable> {
  late Future<List<Map<String, dynamic>>> futureLoginReportData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureLoginReportData = fetchsecurityLoginReportDataFromApi();
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
                  AddProductTittleBar(titleName: widget.name ?? ''),
                  const SizedBox(height: 30),
                    Flexible(
                    child: FutureBuilder<List<Map<String, dynamic>>>(
                      future: futureLoginReportData,
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
