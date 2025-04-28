import 'package:church_admin/Service/ApiHandler/EngagementApiHandler.dart';
import 'package:church_admin/Widgets/TableWidget.dart';
import 'package:church_admin/Widgets/TitleRow.dart';
import 'package:church_admin/view/Tables/TableForms/EmailCommunication.dart';
import 'package:flutter/material.dart';

import '../../Widgets/AddProductListWidget.dart';
import '../Header/DashBoardHeader.dart';

class EmailCommunicationTable extends StatefulWidget {
  final String? name;
  const EmailCommunicationTable({super.key,  this.name});

  @override
  State<EmailCommunicationTable> createState() =>
      _EmailCommunicationTableState();
}

class _EmailCommunicationTableState extends State<EmailCommunicationTable> {
  bool isChange = false;
  late Future<List<Map<String, dynamic>>> futureEmailCommunicationData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureEmailCommunicationData =
        fetchEngagementEmailCommunicationDataFromApi();
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
                        ? EmailCommunication()
                        : FutureBuilder<List<Map<String, dynamic>>>(
                            future: futureEmailCommunicationData,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                return TableWidget(
                                  testData: snapshot.data!,
                                  name: widget.name ?? '',
                                );
                              }
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
