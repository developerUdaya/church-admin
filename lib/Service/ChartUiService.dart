import '../model/ChartModel.dart';
import 'package:flutter/material.dart';

class ChartService {
  List<ChartData> getChartData() {
    return [
      ChartData(value: 25, label: 'student', color: Colors.purpleAccent),
      ChartData(value: 5, label: 'ladies', color: Colors.lightGreen),
      ChartData(value: 15, label: 'gents', color: Colors.pinkAccent),
      ChartData(value: 20, label: 'childrens', color: Colors.greenAccent),
      ChartData(value: 10, label: 'members', color: Colors.brown),
    ];
  }
}