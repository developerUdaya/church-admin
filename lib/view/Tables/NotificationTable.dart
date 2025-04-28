import 'package:church_admin/Service/ApiHandler/EngagementApiHandler.dart';
import 'package:church_admin/Widgets/TableWidget.dart';
import 'package:church_admin/Widgets/TitleRow.dart';
import 'package:church_admin/view/Tables/TableForms/NotificationForms.dart';
import 'package:flutter/material.dart';
import '../../Widgets/AddProductListWidget.dart';
import '../Header/DashBoardHeader.dart';

class NotificationTable extends StatefulWidget {
  final String? name;
  const NotificationTable({super.key,  this.name});

  @override
  State<NotificationTable> createState() => _NotificationTableState();
}

class _NotificationTableState extends State<NotificationTable> {
  late Future<List<Map<String, dynamic>>> futureNotificationData;
  bool isChange = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureNotificationData = fetchEngagementNotificationDataFromApi();
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
                        ? NotificationForms()
                        : FutureBuilder<List<Map<String, dynamic>>>(
                            future: futureNotificationData,
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
