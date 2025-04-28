import 'package:church_admin/Service/ApiHandler/EngagementApiHandler.dart';
import 'package:church_admin/Widgets/TableWidget.dart';
import 'package:church_admin/Widgets/TitleRow.dart';
import 'package:church_admin/view/Tables/TableForms/SmsCommunicationForms.dart';
import 'package:flutter/material.dart';
import '../../Widgets/AddProductListWidget.dart';
import '../Header/DashBoardHeader.dart';

class SmsCommunicationTable extends StatefulWidget {
  final String? name;
  const SmsCommunicationTable({super.key, this.name});

  @override
  State<SmsCommunicationTable> createState() => _SmsCommunicationTableState();
}

class _SmsCommunicationTableState extends State<SmsCommunicationTable> {
  late Future<List<Map<String, dynamic>>> futureSmsCommunicationData;
  bool isChange = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureSmsCommunicationData = fetchEngagementSMSCommunicationDataFromApi();
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
                        ? SmsCommunicationForms()
                        : FutureBuilder<List<Map<String, dynamic>>>(
                            future: futureSmsCommunicationData,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return TableWidget(
                                testData: snapshot.data!,
                                name: widget.name ?? '',
                              );
                            }),
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
