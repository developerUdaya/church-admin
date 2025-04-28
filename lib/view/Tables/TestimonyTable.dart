import 'package:church_admin/Service/ApiHandler/ChurchToolsApiHandler.dart';
import 'package:church_admin/Widgets/TableWidget.dart';
import 'package:church_admin/Widgets/TitleRow.dart';
import 'package:church_admin/view/Tables/TableForms/TestimonyForms.dart';
import 'package:flutter/material.dart';
import '../../Widgets/AddProductListWidget.dart';
import '../Header/DashBoardHeader.dart';

class TestimonyTable extends StatefulWidget {
  final String? name;
  const TestimonyTable({super.key,  this.name});

  @override
  State<TestimonyTable> createState() => _TestimonyTableState();
}

class _TestimonyTableState extends State<TestimonyTable> {
  late Future<List<Map<String, dynamic>>> futureTestimonyData;
  bool isChange = false;

  @override
  void initState() {
    super.initState();
    futureTestimonyData = fetchChurchTools5ColumnTabelDataFromApi("testimonials");
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
                        ? TestimonyForms()
                        : FutureBuilder<List<Map<String, dynamic>>>(
                            future: futureTestimonyData,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else if (!snapshot.hasData ||
                                  snapshot.data!.isEmpty) {
                                return Text('No data available');
                              } else {
                                return TableWidget(
                                  testData:
                                      snapshot.data!, // Corrected this line
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
