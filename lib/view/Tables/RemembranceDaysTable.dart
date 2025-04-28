import 'package:church_admin/CustomColors.dart';
import 'package:church_admin/Service/ApiHandler/ChurchToolsApiHandler.dart';
import 'package:church_admin/Widgets/TableWidget.dart';
import 'package:church_admin/Widgets/TitleRow.dart';
import 'package:church_admin/view/Tables/TableForms/RemembranceDaysForms.dart';
import 'package:flutter/material.dart';
import '../../Widgets/AddProductListWidget.dart';
import '../Header/DashBoardHeader.dart';

class RemembranceDaysTable extends StatefulWidget {
  final String? name;
  const RemembranceDaysTable({super.key,  this.name});

  @override
  State<RemembranceDaysTable> createState() => _RemembranceDaysTableState();
}

class _RemembranceDaysTableState extends State<RemembranceDaysTable> {
  bool isChange = false;
  late Future<List<Map<String, dynamic>>> futureRemembranceDaysData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureRemembranceDaysData = fetchChurchToolsRemembranceDataFromApi();
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
                  const SizedBox(height: 30),
                  Flexible(
                      child: isChange
                          ? RemembranceDaysForms()
                          : FutureBuilder<List<Map<String, dynamic>>>(
                              future: futureRemembranceDaysData,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return Center(
                                      child: Text('Error: ${snapshot.error}'));
                                } else if (!snapshot.hasData ||
                                    snapshot.data!.isEmpty) {
                                  return Center(
                                      child: Text('No data available'));
                                } else {
                                  final remembranceDaysList = snapshot.data!;
                                  return TableWidget(
                                    testData: remembranceDaysList,
                                    name: widget.name ?? '',
                                  );
                                }
                              },
                            )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
