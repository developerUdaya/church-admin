import 'package:church_admin/CustomColors.dart';
import 'package:church_admin/Service/UserServices.dart';
import 'package:church_admin/Widgets/Calendar.dart';
import 'package:church_admin/Widgets/AddProductListWidget.dart';
import 'package:church_admin/Widgets/LineChartWidget.dart';
import 'package:church_admin/Widgets/TitleRow.dart';
import 'package:church_admin/view/Header/DashBoardHeader.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class DashboardTab extends StatefulWidget {
  final String name;

  const DashboardTab({super.key, this.name = "Dashboard"});

  @override
  State<DashboardTab> createState() => _DashboardTabState();
}

class _DashboardTabState extends State<DashboardTab> {
  bool isChange = false;
  String usersCount = "0";
  String studentsCount = "0";
  String familiesCount = "0";
  String pastorsCount = "0";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchDashboardData();
  }

  Future<void> _fetchDashboardData() async {
    try {
      final fetchedData = await UserServices.fetchUsersCount();
      if (fetchedData.isNotEmpty && fetchedData[0]['data'] != null) {
        final userList = fetchedData[0]['data'] as List<dynamic>;

        setState(() {
          print(userList);
          usersCount = userList
              .where((user) => user['role'] == 'user')
              .length
              .toString();
          studentsCount = userList
              .where((user) => user['role'] == 'student')
              .length
              .toString();
          familiesCount = userList
              .where((user) => user['role'] == 'family')
              .length
              .toString();
          pastorsCount = userList
              .where((user) => user['role'] == 'pastor')
              .length
              .toString();
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching dashboard data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      body: ListView(
        children: [
          DashboardHeader(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                isChange
                    ? TitleRow(
                        title: widget.name,
                        onPressed: () {
                          setState(() {
                            isChange = false;
                          });
                        },
                        withSized: 0.69,
                      )
                    : AddProductTittleBar(
                        isHideAddButton: true,
                        titleName: "Welcome to IKIA",
                        onPressed: () {
                          setState(() {
                            isChange = true;
                          });
                        },
                      ),
                SizedBox(height: isChange ? 20 : 30),
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Container(
                        margin: const EdgeInsets.symmetric(horizontal: 95),
                        width: MediaQuery.of(context).size.width > 1205
                            ? 1205
                            : MediaQuery.of(context).size.width < 605
                                ? 605
                                : MediaQuery.of(context).size.width,
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            double itemWidth = (constraints.maxWidth - 60) / 4;
                            double iconSize =
                                constraints.maxWidth > 1200 ? 54.0 : 40.0;
                            double titleFontSize =
                                constraints.maxWidth > 1200 ? 15.0 : 14.0;
                            double countFontSize =
                                constraints.maxWidth > 1200 ? 24.0 : 20.0;

                            final dashboardItems = [
                              {
                                'icon': HugeIcons.strokeRoundedUser,
                                'title': 'Total Users',
                                'count': usersCount,
                              },
                              {
                                'icon': HugeIcons.strokeRoundedStudent,
                                'title': 'Total Students',
                                'count': studentsCount,
                              },
                              {
                                'icon': HugeIcons.strokeRoundedUserGroup,
                                'title': 'Total Families',
                                'count': familiesCount,
                              },
                              {
                                'icon': HugeIcons.strokeRoundedChurch,
                                'title': 'Total Pastors',
                                'count': pastorsCount,
                              },
                            ];

                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: dashboardItems.map((item) {
                                return _buildDashboardItem(
                                  icon: item['icon'] as IconData,
                                  title: item['title'] as String,
                                  count: item['count'] as String,
                                  itemWidth: itemWidth,
                                  iconSize: iconSize,
                                  titleFontSize: titleFontSize,
                                  countFontSize: countFontSize,
                                );
                              }).toList(),
                            );
                          },
                        ),
                      ),
                const SizedBox(height: 35),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 100),
                  width: MediaQuery.of(context).size.width > 1205
                      ? 1205
                      : MediaQuery.of(context).size.width < 605
                          ? 605
                          : MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: const LineChartWidget(
                      isData1Hover: true, isData2Hover: true),
                ),
                const SizedBox(height: 35),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 100),
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
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 36.0, left: 56.0),
                                child: Text(
                                  "Upcoming Events",
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CalendarDialog(
                                    initialDate: DateTime.now(),
                                    onDateSelected: (selectedDate) {},
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: 1,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          leading: HugeIcon(
                                              icon: HugeIcons
                                                  .strokeRoundedCalendar04,
                                              color: primaryBlue),
                                          title: const Text(' '),
                                          subtitle: const Text(' '),
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
                      const SizedBox(width: 35),
                      Expanded(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text(
                                  "Task List",
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                height: 350.0,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: 1,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      leading: HugeIcon(
                                          icon: HugeIcons.strokeRoundedTask02,
                                          color: primaryBlue),
                                      title: const Text(''),
                                      subtitle: const Text(' '),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardItem({
    required IconData icon,
    required String title,
    required String count,
    required double itemWidth,
    required double iconSize,
    required double titleFontSize,
    required double countFontSize,
  }) {
    return Container(
      width: itemWidth,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Center(
        child: Row(
          children: [
            HugeIcon(
              icon: icon,
              color: secondaryBlue,
              size: iconSize,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: titleFontSize,
                      color: secondaryBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    count,
                    style: TextStyle(
                      fontSize: countFontSize,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
