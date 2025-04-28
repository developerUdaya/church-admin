import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../model/ChartModel.dart';

class ChartUtils {
  static Color lightenColor(Color color, double factor) {
    int r = color.red;
    int g = color.green;
    int b = color.blue;

    r = (r + (255 - r) * factor).toInt();
    g = (g + (255 - g) * factor).toInt();
    b = (b + (255 - b) * factor).toInt();

    return Color.fromRGBO(r, g, b, 1);
  }

  static List<PieChartSectionData> showingSections(
      List<ChartData> chartData, int hoveredIndex) {
    return List.generate(chartData.length, (i) {
      final isHovered = i == hoveredIndex;
      final fontSize = isHovered ? 12.0 : 12.0;
      final radius = isHovered ? 50.0 : 50.0;

      final data = chartData[i];
      final color = isHovered ? lightenColor(data.color, 0.5) : data.color;

      return PieChartSectionData(
        color: color,
        value: data.value,
        title: '${data.value}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    });
  }
}