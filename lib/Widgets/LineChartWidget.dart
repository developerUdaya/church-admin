import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:google_fonts/google_fonts.dart';

class LineChartWidget extends StatefulWidget {
  final bool isData1Hover;
  final bool isData2Hover;
  const LineChartWidget({Key? key,required this.isData1Hover, required this.isData2Hover}) : super(key: key);

  @override
  State<LineChartWidget> createState() => _ChartState();
}

class _ChartState extends State<LineChartWidget> {
  final List<double> Data1 = [30, 32, 35, 38, 28, 45, 42, 0, 0];
  // final List<double> Data2 = [10, 25, 30, 35, 45, 35, 32, 50, 40];
  Offset? tooltipPosition;
  int? tooltipIndex;
  bool tooltipVisible = false;

  void updateTooltip(Offset position, Size size) {
    final double width = size.width - 30;
    final int index = ((position.dx / width) * (Data1.length - 1)).round();

    if (index >= 0 && index < Data1.length) {
      setState(() {
        tooltipPosition = position;
        tooltipIndex = index;
        tooltipVisible = true;
      });
    }
  }

  void hideTooltip() {
    setState(() {
      tooltipVisible = false;
      tooltipPosition = null;
      tooltipIndex = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        final RenderBox box = context.findRenderObject() as RenderBox;
        final localPosition = box.globalToLocal(event.position);
        updateTooltip(localPosition, box.size);
      },
      onExit: (_) => hideTooltip(),
      child: Container(
        padding: const EdgeInsets.all(16),
        height: 300,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 30,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(11, (index) {
                      return Text(
                        '${110 - (index * 10)}',
                        style: GoogleFonts.manrope(
                          color: Color(0xff98a4ae),
                          fontSize: 11,
                        ),
                      );
                    }),
                  ),
                ),
                Positioned(
                  left: 30,
                  right: 0,
                  top: 0,
                  bottom: 30,
                  child: CustomPaint(
                    painter: ChartPainter(
                      isData1Hover: widget.isData1Hover,
                      isData2Hover: widget.isData2Hover,
                      Data1: Data1,
                      // Data2: Data2,
                      tooltipIndex: tooltipIndex,
                    ),
                  ),
                ),
                Positioned(
                  left: 30,
                  right: 0,
                  bottom: 20,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 1,
                        color: Color(0xff98a4ae),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: List.generate(6, (index) {
                          return Container(
                            width: 1,
                            height: 5,
                            color: Color(0xff98a4ae),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 30,
                  right: 0,
                  bottom: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '14 Sep',
                        style: GoogleFonts.manrope(
                            color: Color(0xff98a4ae), fontSize: 12),
                      ),
                      Text(
                        '15 Sep',
                        style: GoogleFonts.manrope(
                            color: Color(0xff98a4ae), fontSize: 12),
                      ),
                      Text(
                        '16 Sep',
                        style: GoogleFonts.manrope(
                            color: Color(0xff98a4ae), fontSize: 12),
                      ),
                      Text(
                        '17 Sep',
                        style: GoogleFonts.manrope(
                            color: Color(0xff98a4ae), fontSize: 12),
                      ),
                      Text(
                        '18 Sep',
                        style: GoogleFonts.manrope(
                            color: Color(0xff98a4ae), fontSize: 12),
                      ),
                      Text(
                        '19 Sep',
                        style: GoogleFonts.manrope(
                            color: Color(0xff98a4ae), fontSize: 12),
                      ),
                    ],
                  ),
                ),
                if (tooltipVisible &&
                    tooltipPosition != null &&
                    tooltipIndex != null) ...{
                  Positioned(
                    left: math.max(
                        30,
                        math.min(tooltipPosition!.dx - 85,
                            constraints.maxWidth - 165)),
                    top: math.max(
                        10,
                        math.min(tooltipPosition!.dy - 85,
                            constraints.maxHeight - 150)),
                    child: MouseRegion(
                      onEnter: (_) => setState(() => tooltipVisible = true),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A1F2B),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              child: Text(
                                '19 Sep',
                                style: GoogleFonts.manrope(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 54, 65, 90),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(16),
                                  bottomRight: Radius.circular(16),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 12,
                                        height: 4,
                                        decoration: const BoxDecoration(
                                          color: Color(0xff635bff),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(2)),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Users Count : ${Data1[tooltipIndex!].round()}',
                                        style: GoogleFonts.manrope(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Container(
                                        width: 12,
                                        height: 4,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFF1dcdc9),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(2)),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      // Text(
                                      //   'Sales Summary 2: ${Data2[tooltipIndex!].round()}',
                                      //   style: GoogleFonts.manrope(
                                      //     color: Colors.white,
                                      //     fontSize: 12,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: math.max(
                        30,
                        math.min(tooltipPosition!.dx - 85,
                            constraints.maxWidth - 30)),
                    bottom: 5,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Transform.translate(
                          offset: const Offset(0, 10),
                          child: Icon(
                            Icons.arrow_drop_up,
                            color: const Color(0xFF1A1F2B),
                            size: 25,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A1F2B),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                              child: Text(
                            '19 Sep',
                            style: GoogleFonts.manrope(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          )),
                        )
                      ],
                    ),
                  )
                }
              ],
            );
          },
        ),
      ),
    );
  }
}

class ChartPainter extends CustomPainter {
  final List<double> Data1;
  // final List<double> Data2;
  final int? tooltipIndex;
  final bool isData1Hover;
  final bool isData2Hover;

  ChartPainter({
    required this.isData1Hover,
    required this.isData2Hover,
    required this.Data1,
    // required this.Data2,
    this.tooltipIndex,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint line1Paint = Paint()
      ..color = isData1Hover ? Color.fromARGB(255, 200, 198, 253) :Color(0xff635bff)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final Paint line2Paint = Paint()
      ..color = isData2Hover ? Color.fromARGB(255, 182, 213, 236) : Color(0xFF1dcdc9)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final Paint areaPaint1 = Paint()
      ..color = isData1Hover ? Color.fromARGB(255, 210, 209, 240).withOpacity(0.1) : Color(0xffdfdefe).withOpacity(0.5)
      ..style = PaintingStyle.fill;

    final Paint areaPaint2 = Paint()
      ..color = isData2Hover ? Color.fromARGB(255, 182, 210, 231).withOpacity(0.1) : Color(0xffb6daf4).withOpacity(0.5)
      ..style = PaintingStyle.fill;

    drawLine(canvas, size, Data1, line1Paint, areaPaint1);
    // drawLine(canvas, size, Data2, line2Paint, areaPaint2);

    if (tooltipIndex != null) {
      final double xStep = size.width / (Data1.length - 1);
      final double x = tooltipIndex! * xStep;

      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        Paint()
          ..color = Colors.grey.withOpacity(0.3)
          ..strokeWidth = 1,
      );

      final double y1 =
          size.height - (Data1[tooltipIndex!] / 110 * size.height);
      // final double y2 =
      //     size.height - (Data2[tooltipIndex!] / 110 * size.height);

      canvas.drawCircle(
        Offset(x, y1),
        7,
        Paint()..color = Colors.white,
      );
      // canvas.drawCircle(
      //   Offset(x, y2),
      //   7,
      //   Paint()..color = Colors.white,
      // );

      canvas.drawCircle(
        Offset(x, y1),
        5,
        Paint()..color = Color(0xff635bff),
      );
      // canvas.drawCircle(
      //   Offset(x, y2),
      //   5,
      //   Paint()..color = Color(0xFF1dcdc9),
      // );
    }
  }

  void drawLine(Canvas canvas, Size size, List<double> data, Paint linePaint,
      Paint areaPaint) {
    final Path path = Path();
    final Path areaPath = Path();

    final double xStep = size.width / (data.length - 1);

    path.moveTo(0, size.height - (data[0] / 110 * size.height));
    areaPath.moveTo(0, size.height);
    areaPath.lineTo(0, size.height - (data[0] / 110 * size.height));

    for (int i = 1; i < data.length; i++) {
      final double x = i * xStep;
      final double y = size.height - (data[i] / 110 * size.height);

      if (i == 1) {
        path.lineTo(x, y);
        areaPath.lineTo(x, y);
      } else {
        final double prevX = (i - 1) * xStep;
        final double prevY = size.height - (data[i - 1] / 110 * size.height);

        final double controlX1 = prevX + (x - prevX) / 2;
        final double controlX2 = prevX + (x - prevX) / 2;

        path.cubicTo(controlX1, prevY, controlX2, y, x, y);
        areaPath.cubicTo(controlX1, prevY, controlX2, y, x, y);
      }
    }

    areaPath.lineTo(size.width, size.height);
    areaPath.close();

    canvas.drawPath(areaPath, areaPaint);
    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}