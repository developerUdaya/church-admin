import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

/*class GradientLineChart extends StatelessWidget {
  final List<FlSpot> dataPoints;
  final List<Color> gradientColors;

  const GradientLineChart({
    Key? key,
    required this.dataPoints,
    required this.gradientColors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.5, // Responsive height
      color: Colors.white, // Plain background color
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false), // Remove grid lines
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 5,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toInt().toString(),
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 12,
                    ),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  switch (value.toInt()) {
                    case 0:
                      return const Text('Feb');
                    case 2:
                      return const Text('Apr');
                    case 4:
                      return const Text('Jun');
                    case 6:
                      return const Text('Aug');
                    case 8:
                      return const Text('Oct');
                    case 10:
                      return const Text('Dec');
                    default:
                      return const Text('');
                  }
                },
              ),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          borderData: FlBorderData(show: false), // Remove borders
          minX: 0,
          maxX: dataPoints.isNotEmpty ? dataPoints.last.x : 10,
          minY: 0,
          maxY: 40,
          lineBarsData: [
            LineChartBarData(
              spots: dataPoints,
              isCurved: true,
              gradient: LinearGradient(
                colors: gradientColors,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              barWidth: 4,
              belowBarData: BarAreaData(show: false),
              dotData:  FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) {
                  return FlDotCirclePainter(
                    radius: 6,
                    color: Colors.white,
                    strokeWidth: 2,
                    strokeColor: gradientColors.first,
                  );
                },
              ),
            ),
          ],
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              tooltipRoundedRadius: 8,
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((spot) {
                  return LineTooltipItem(
                    'X: ${spot.x.toInt()}\nY: ${spot.y.toInt()}',
                    const TextStyle(
                      color: Colors.black87,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }).toList();
              },
            ),
            handleBuiltInTouches: true,
          ),
        ),
      ),
    );
  }
}*/


class GradientLineChart extends StatefulWidget {
  final List<FlSpot> dataPoints;
  final List<Color> gradientColors;

  const GradientLineChart({
    super.key,
    required this.dataPoints,
    required this.gradientColors,
  });

  @override
  State<GradientLineChart> createState() => _GradientLineChartState();
}

class _GradientLineChartState extends State<GradientLineChart> {
  bool _isTouched = false;
  FlSpot? _touchedSpot;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.6,
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Member Ship Reports",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Stack(
              children: [
                LineChart(
                  LineChartData(
                    gridData: FlGridData(show: false),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 5,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              value.toInt().toString(),
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 12,
                              ),
                            );
                          },
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 1,
                          getTitlesWidget: (value, meta) {
                            switch (value.toInt()) {
                              case 0:
                                return const Text('Feb');
                              case 2:
                                return const Text('Apr');
                              case 4:
                                return const Text('Jun');
                              case 6:
                                return const Text('Aug');
                              case 8:
                                return const Text('Oct');
                              case 10:
                                return const Text('Dec');
                              default:
                                return const Text('');
                            }
                          },
                        ),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    minX: 0,
                    maxX: widget.dataPoints.isNotEmpty ? widget.dataPoints.last.x : 10,
                    minY: 0,
                    maxY: 60,
                    lineBarsData: [
                      LineChartBarData(
                        spots: widget.dataPoints,
                        isCurved: true,
                        gradient: LinearGradient(
                          colors: widget.gradientColors,
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        barWidth: 4,
                        belowBarData: BarAreaData(show: false),
                        dotData: FlDotData(
                          show: true,
                          getDotPainter: (spot, percent, barData, index) {
                            if (_isTouched && _touchedSpot != null && _touchedSpot == spot) {
                              return FlDotCirclePainter(
                                radius: 8,
                                color: Colors.white,
                                strokeWidth: 1,
                                strokeColor: widget.gradientColors.first,
                              );
                            } else {
                              return FlDotCirclePainter(
                                radius: 4,
                                color: Colors.white,
                                strokeWidth: 1,
                                strokeColor: widget.gradientColors.first,
                              );
                            }
                          },
                        ),
                        shadow: Shadow(
                          color: Colors.black.withOpacity(0.3),
                          offset: const Offset(4, 4),
                          blurRadius: 8,
                        ),
                      ),
                    ],
                    lineTouchData: LineTouchData(
                      touchTooltipData: LineTouchTooltipData(
                        tooltipRoundedRadius: 8,
                        getTooltipItems: (touchedSpots) {
                          return touchedSpots.map((spot) {
                            return LineTooltipItem(
                              'X: ${spot.x.toInt()}\nY: ${spot.y.toInt()}',
                              const TextStyle(
                                color: Colors.black87,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }).toList();
                        },
                      ),
                      handleBuiltInTouches: true,
                      touchCallback: (FlTouchEvent event, LineTouchResponse? touchResponse) {
                        if (touchResponse != null &&
                            touchResponse.lineBarSpots != null &&
                            touchResponse.lineBarSpots!.isNotEmpty) {
                          setState(() {
                            _isTouched = true;
                            _touchedSpot = touchResponse.lineBarSpots!.first;
                          });
                        } else {
                          setState(() {
                            _isTouched = false;
                            _touchedSpot = null;
                          });
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}









