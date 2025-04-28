
import 'package:flutter/material.dart';

import '../../Widgets/AddProductListWidget.dart';
import '../../Widgets/TableWidget.dart';
import '../Header/DashBoardHeader.dart';


class OrdersTable extends StatefulWidget {


  final List<Map<String, dynamic>>? testData;
  final String? name;

  const OrdersTable({super.key,  this.testData,  this.name});

  @override
  State<OrdersTable> createState() => _OrdersTableState();
}

class _OrdersTableState extends State<OrdersTable> {


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
                  const SizedBox(height: 20),
                  Flexible(
                    child: TableWidget(
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