import 'package:flutter/material.dart';
import '../../Widgets/ChartWidget.dart';
import '../../model/ChartModel.dart';
import '../../Service/ChartUiService.dart';

class DonutChart extends StatefulWidget {
  const DonutChart({super.key});

  @override
  State<DonutChart> createState() => _DonutChartState();
}

class _DonutChartState extends State<DonutChart> {
  late ChartService chartService;
   List<ChartData> chartData=[
      ChartData(value: 25, label: 'student', color: Colors.purpleAccent),
      ChartData(value: 5, label: 'ladies', color: Colors.lightGreen),
      ChartData(value: 15, label: 'gents', color: Colors.pinkAccent),
      ChartData(value: 20, label: 'childrens', color: Colors.greenAccent),
      ChartData(value: 10, label: 'members', color: Colors.brown),
    ];

  @override
  void initState() {
    super.initState();
    chartService = ChartService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F7FB),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.45,
            height: MediaQuery.of(context).size.height * 0.56,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                /* BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 2),
                    blurRadius: 6,
                  ),*/
              ],
            ),
            child: Column(
              children: [
                ChartWidget(chartData: chartData,),
                const SizedBox(height: 16),
                ChartLegendWidget(chartData: chartData),

              ],
            ),

          ),
        ],
      ),
    );
  }
}