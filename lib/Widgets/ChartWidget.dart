import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../model/ChartModel.dart';
import '../view/Charts/ChartUiMethod.dart';

class ChartWidget extends StatefulWidget {
  final List<ChartData> chartData;

  const ChartWidget({required this.chartData, super.key});

  @override
  _ChartWidgetState createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {
  int hoveredIndex = -1;
  Offset tooltipPosition = Offset.zero;
  OverlayEntry? _overlayEntry;

  void _showTooltip(BuildContext context, Offset position, int index) {
    _removeTooltip();

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: position.dx,
        top: position.dy - 40,
        child: Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(8),
          color: Colors.black87,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Text(
              '${widget.chartData[index].label}: ${widget.chartData[index].value}%',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context)?.insert(_overlayEntry!);
  }

  void _removeTooltip() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    _removeTooltip();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Donut Chart',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            MouseRegion(
              onHover: (event) {
                final RenderBox box = context.findRenderObject() as RenderBox;
                final localPosition = box.globalToLocal(event.position);

                final center = Offset(box.size.width / 2, box.size.height / 2);
                final dx = localPosition.dx - center.dx;
                final dy = localPosition.dy - center.dy;
                final angle = (atan2(dy, dx) * 180 / pi + 360) % 360;

                double totalValue = widget.chartData.fold(
                    0, (sum, item) => sum + item.value);

                double currentAngle = 0;

                for (int i = 0; i < widget.chartData.length; i++) {
                  final sectionAngle =
                      (widget.chartData[i].value / totalValue) * 360;
                  if (angle >= currentAngle &&
                      angle < currentAngle + sectionAngle) {
                    setState(() {
                      hoveredIndex = i;
                      tooltipPosition = event.position;
                    });
                    _showTooltip(context, event.position, i);
                    break;
                  }
                  currentAngle += sectionAngle;
                }
              },
              onExit: (event) {
                setState(() {
                  hoveredIndex = -1;
                });
                _removeTooltip();
              },
              child: SizedBox(
                height: 200,
                width: 150,
                child: PieChart(
                  PieChartData(
                    borderData: FlBorderData(show: false),
                    sectionsSpace: 0,
                    centerSpaceRadius: 60,
                    sections: ChartUtils.showingSections(
                        widget.chartData, hoveredIndex),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChartLegendWidget extends StatelessWidget {
  final List<ChartData> chartData;

  const ChartLegendWidget({required this.chartData, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: chartData.map((data) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      color: data.color,
                    ),
                    const SizedBox(width: 8),
                    Text(data.label),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
