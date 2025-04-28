import 'package:church_admin/Service/ApiHandler/FinanceApiHandler.dart';
import 'package:church_admin/Widgets/TableWidget.dart';
import 'package:church_admin/Widgets/TitleRow.dart';
import 'package:church_admin/view/Tables/TableForms/DonationsForms.dart';
import 'package:flutter/material.dart';
import '../../Widgets/AddProductListWidget.dart';
import '../Header/DashBoardHeader.dart';

class DonationsTable extends StatefulWidget {
  final List<Map<String, dynamic>>? mainTableData;
  final String? name;
  const DonationsTable(
      {super.key,  this.mainTableData,  this.name});

  @override
  State<DonationsTable> createState() => _DonationsTableState();
}

class _DonationsTableState extends State<DonationsTable> {
  bool isChange = false;
  late Future<List<Map<String, dynamic>>> futureDonationData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureDonationData = fetchFinanceDonationsDataFromApi();
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
                      future: futureDonationData,
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
                              ? DonationsForms()
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
