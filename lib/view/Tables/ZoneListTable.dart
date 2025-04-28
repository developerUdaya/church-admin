import 'package:church_admin/Widgets/TitleRow.dart';
import 'package:church_admin/view/Tables/TableForms/ZoneListFormCreation.dart';
import 'package:flutter/material.dart';

import '../../Widgets/AddProductListWidget.dart';
import '../../Widgets/TableWidget.dart';
import '../Header/DashBoardHeader.dart';

class ZoneList_table extends StatefulWidget {
  final List<Map<String, dynamic>>? testData;
  final String? name;

  const ZoneList_table({super.key,  this.testData,  this.name});

  @override
  State<ZoneList_table> createState() => _ZoneList_tableState();
}

class _ZoneList_tableState extends State<ZoneList_table> {
  bool isChange = false;
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
                          })
                      : AddProductTittleBar(
                          titleName: widget.name ?? '',
                          onPressed: () {
                            setState(() {
                              isChange = true;
                              debugPrint('Value $isChange');
                            });
                            debugPrint('Value $isChange');
                          },
                        ),
                  const SizedBox(height: 30),
                  Flexible(
                    child: isChange
                        ? ZoneListFormCreation()
                        : TableWidget(
                            testData: widget.testData ?? [],
                            name: widget.name ?? '',
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
