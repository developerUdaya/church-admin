import 'package:church_admin/Widgets/ChartWidget.dart';
import 'package:church_admin/Widgets/LineChartWidget.dart';
import 'package:church_admin/Widgets/LineChartWidget2.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../CustomColors.dart';
import '../../Widgets/AddProductListWidget.dart';
import '../../Widgets/Calendar.dart';

import '../Charts/DonutChart.dart';
import '../Charts/GradientLineChart.dart';
import '../Header/DashBoardHeader.dart';

class ReportsTab extends StatefulWidget {
  const ReportsTab({super.key});

  @override
  State<ReportsTab> createState() => _ReportsTabState();
}

class _ReportsTabState extends State<ReportsTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F7FB),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 110),
        child: ListView(
          children: [
              DashboardHeader(),
                       
                      SizedBox(
              height: 35,
            ), 
      AddProductTittleBar(
        titleName: 'Report',
                          isHideAddButton: true,

      ),
      
            SizedBox(
              height: 35,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 100),
              width: MediaQuery.of(context).size.width > 1205
                  ? 1205
                  : MediaQuery.of(context).size.width < 605
                      ? 605
                      : MediaQuery.of(context).size.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      //  margin: EdgeInsets.symmetric(horizontal: 100),
                      // height: MediaQuery.of(context).size.height * 0.07,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      // width: MediaQuery.of(context).size.width > 1205
                      //   ? 1205
                      //   : MediaQuery.of(context).size.width < 605
                      //     ? 605
                      //     : MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              padding: const EdgeInsets.only(
                                  top: 36.0, left: 56.0),
                              child: Text(
                                "Upcoming Events",
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CalendarDialog(
                                initialDate: DateTime.now(),
                                onDateSelected: (selectedDate) {},
                              ),
                              Expanded(
                                flex: 5,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: 5,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      leading: HugeIcon(
                                          icon: HugeIcons
                                              .strokeRoundedCalendar04,
                                          color: primaryBlue),
                                      title: Text('Event ${index + 1}'),
                                      subtitle: Text(
                                          'Event details for event ${index + 1}, Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, ',
                                          overflow: TextOverflow.ellipsis,
                                          ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
                                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                            margin: EdgeInsets.symmetric(horizontal: 100),
              width: MediaQuery.of(context).size.width > 1205
                  ? 1205
                  : MediaQuery.of(context).size.width < 605
                      ? 605
                      : MediaQuery.of(context).size.width,

              child: Stack(
                children:[ 
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 200,
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
                                  'Attendence Report',
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
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                          'Users Count : 1000',
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
                                        Text(
                                          'Regular: 80% (avg : 800 )',
                                          style: GoogleFonts.manrope(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                    
                                    Row(
                                      children: [
                                        Container(
                                          width: 12,
                                          height: 4,
                                          decoration: const BoxDecoration(
                                            color: Color.fromARGB(255, 230, 96, 96),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(2)),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          'Irregular: 20% (avg : 200 )',
                                          style: GoogleFonts.manrope(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                    
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                  ),
                    
                  Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   Container(
                                padding: const EdgeInsets.all(36.0),
                                child: Text(
                                  "Members Attendance Report",
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                    LineChartWidget2(isData1Hover: true, isData2Hover: true,),
                  ],
                ),]
              ),
            ),
      
              SizedBox(
              height: 35,
            ),
      //       Container(
      //           margin: EdgeInsets.symmetric(horizontal: 100),
      //           height: MediaQuery.of(context).size.height * 0.7,
      //           width: MediaQuery.of(context).size.width > 1205
      //             ? 1205
      //             : MediaQuery.of(context).size.width < 605
      //             ? 605
      //             : MediaQuery.of(context).size.width,
      // decoration: BoxDecoration(
      //               borderRadius: BorderRadius.circular(10),
      //               color: Colors.white,
      //               ),
      //           child: ChartWidget(chartData: [],)

      //         ),  
      
              
        SizedBox(
              height: 35,
            ),
      
          ],
        ),
      ),
    );
  }
}
