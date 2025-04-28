import 'package:church_admin/Widgets/TableWidget.dart';
import 'package:flutter/material.dart';


import '../../Widgets/AddProductListWidget.dart';
import '../Header/DashBoardHeader.dart';


class MembershipReportsTable extends StatefulWidget {
  final  List<Map<String, dynamic>>? mainTableData;
  final String? name;
  const MembershipReportsTable({super.key,  this.mainTableData,  this.name});

  @override
  State<MembershipReportsTable> createState() => _MembershipReportsTableState();
}

class _MembershipReportsTableState extends State<MembershipReportsTable> {
  
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
                  AddProductTittleBar(titleName: widget.name ?? 'Default Title'),
                  const SizedBox(height: 30),
                  Flexible(
                    child: TableWidget(
                      testData: widget.mainTableData ?? [],
                      name: widget.name ?? 'Default Name',
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
