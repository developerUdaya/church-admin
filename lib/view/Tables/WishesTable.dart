
import 'package:church_admin/CustomColors.dart';
import 'package:church_admin/view/Tables/TableForms/PrayersForms.dart';
import 'package:flutter/material.dart';

import '../../Widgets/AddProductListWidget.dart';
import '../../Widgets/TableWidget.dart';
import '../Header/DashBoardHeader.dart';


class PastorsTable extends StatefulWidget {

  final List<Map<String, dynamic>> testData;
  final String name;

  const PastorsTable({super.key, required this.testData, required this.name});

  @override
  State<PastorsTable> createState() => _PastorsTableState();
}

class _PastorsTableState extends State<PastorsTable> {
 bool isChange =false;

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
                  AddProductTittleBar(titleName: widget.name),
                  const SizedBox(height: 30),
                  Flexible(
                    child: isChange?
                    PrayersForms()
                        :TableWidget(
                      testData: widget.testData,
                      name: widget.name,
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