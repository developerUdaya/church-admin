/*
import 'dart:math';

import 'package:flutter/material.dart';

class Tabbarwidget extends StatefulWidget {
  final List<Map<String, dynamic>> testData;
  final String name;
  final double heightSize;

  const Tabbarwidget({super.key,required this.testData,
    required this.name,
    this.heightSize = 0.52,});

  @override
  State<Tabbarwidget> createState() => _TabbarwidgetState();
}

class _TabbarwidgetState extends State<Tabbarwidget> {

  late TabController _tabController;

  @override
  Widget build(BuildContext context) {

    if (widget.testData.isEmpty) {
      return const Center(child: Text("No data available."));
    }

    final tableData = widget.testData.first;
    final headers = tableData['header'] as List<String>? ?? [];
    final dataTypes = tableData['dataType'] as List<String>? ?? [];
    final dataRows = tableData['data'] as List<dynamic>? ?? [];
    final tabBarHeader = tableData['tabBarHeader'] as List<dynamic>? ?? [];

    if (headers.isEmpty || dataTypes.isEmpty || dataRows.isEmpty) {
      return const Center(child: Text("No data available."));
    }

    final double calculatedHeight = max(widget.heightSize, tableData['data'].length * 0.1);
    final double screenHeight = MediaQuery.of(context).size.height;
    print('Data ${dataRows.length}');
    print('Height Size$calculatedHeight');
    print('ScreenHeight$screenHeight');
    print('Container Height ${screenHeight*calculatedHeight}');



    return Padding(
        padding:EdgeInsets.all(8),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.61,
        height: screenHeight * calculatedHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: const Color(0xFFEEF1F4), width: 1.0),
        ),
        child: Column(
          children: [
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:20),
              child: Text(
                widget.name,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF2C3442),
                ),
              ),
            ),
            const Divider(thickness: 1, color: Color(0xFFE4E6E8)),
            const SizedBox(height: 2.0),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade300),
                ),
              ),
              child: TabBar(
                controller: _tabController,
                indicatorColor: Colors.blue,
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.grey,
                tabs:tabBarHeader.map(item){
                  return Tab(
                     item,
                  );
              }
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
