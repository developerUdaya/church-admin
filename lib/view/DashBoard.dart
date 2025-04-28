import 'package:church_admin/view/Header/DashBoardHeader.dart';
import 'package:church_admin/view/SideBar/SidebarUI.dart';
import 'package:church_admin/view/Tables/FundManagementTable.dart';
import 'package:church_admin/view/Tables/MeetingTables.dart';
import 'package:church_admin/view/Tables/SmsCommunicationTable.dart';
import 'package:church_admin/view/Tables/WishesProfiles.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import '../CustomColors.dart';
import 'Tables/AssetManagementTable.dart';
import 'Tables/AudioPodcastTable.dart';
import 'Tables/BlogTable.dart';
import 'Tables/BloodRequirementTable.dart';
import 'Tables/ChurchStaffTable.dart';
import 'Tables/CommitteeTable.dart';
import 'Tables/DashBoardTab.dart';
import 'Tables/DepartmentTable.dart';
import 'Tables/DonationsTable.dart';
import 'Tables/EmailCommunicationTable.dart';
import 'Tables/EventManagementTable.dart';
import 'Tables/FamiliesTable.dart';
import 'Tables/FlocksTable.dart';
import 'Tables/FunctionHallTable.dart';
import 'Tables/GalleryTab.dart';
import 'Tables/LoginReportsTable.dart';
import 'Tables/ManageRoleTable.dart';
import 'Tables/MembersTable.dart';
import 'Tables/MembershipReportsTable.dart';
import 'Tables/NewsLetterTab.dart';
import 'Tables/NoticesTable.dart';
import 'Tables/NotificationTable.dart';
import 'Tables/OrdersTable.dart';
import 'Tables/PastorsProfileGrid.dart';
import 'Tables/PastorsTable.dart';
import 'Tables/PrayersTable.dart';
import 'Tables/ProductsTable.dart';
import 'Tables/RemembranceDaysTable.dart';
import 'Tables/ReportsTab.dart';
import 'Tables/SpeechProfileGrid.dart';
import 'Tables/StudentTable.dart';
import 'Tables/TestimonyTable.dart';
import 'Tables/UserListTable.dart';
import 'Tables/WhatsappTab.dart';
import 'Tables/ZoneAreasTable.dart';
import 'Tables/ZoneListTable.dart';
import 'Tables/ZoneReportsTable.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final List<Widget> pages = [
    DashboardTab(),
    ReportsTab(),
    userList_table(
      testData: userList_Table,
      name: 'UserList',
    ),
    MembersTable(
      testData: memberList_Table,
      name: 'Members List',
    ),
    FamiliesTable(testData: famlies_Table, name: 'Families'),
    FlocksTable(testData: flocks, name: 'Little Flocks'),
    StudentTable(testData: students_Table, name: 'Student'),
    CommitteeTable(
      testData: committee,
      name: 'Committee',
    ),
    /*PastorsTable(testData: pastors, name: 'Pastors',),*/
    PastorsProfileGrid(),
    ChurchStaffTable(testData: churchStaff, name: 'Church Staff'),
    DepartmentTable(testData: department, name: 'Department'),
    MembershipReportsTable(
      mainTableData: MembershipData,
      name: 'MemberShip Report',
    ),
    FundManagementTables(
      mainTableData: FundRecordsData,
      name: 'Fund Management',
    ),
    DonationsTable(
      mainTableData: DonationsData,
      name: 'Donations',
    ),
    AssetManagementTable(
      name: 'Asset',
      mainTableData: AssetData,
    ),
    EmailCommunicationTable(
      name: 'Email Communication',
    ),
    NotificationTable(
      name: 'Notification',
    ),
    BloodRequirementTable(
      mainTableData: BloodData,
      name: 'Blood Requirement',
    ),
    BlogTable(
      name: 'Blog',
    ),
    TestimonyTable(
      name: 'Testimony',
    ),
    PrayersTable(
      name: 'Prayers',
    ),
    MeetingTable(
      name: 'Meeting',
    ),
    EventManagementTable(
      name: 'Event Management',
    ),
    RemembranceDaysTable(
      name: 'Remembrance',
    ),
    NoticesTable(
      name: 'Notices',
    ),
    FunctionHallTable(
      name: 'Function Hall',
    ),
    AudioPodcastTable(
      name: 'Audio Podcast',
    ),
    GalleryPage(),
    ManageRoleTable(
      mainTableData: mainTableData,
      name: 'Manage Roles',
    ),
    LoginReportsTable(
      testData: Login_Reports,
      name: 'Login Reports',
    ),
    zoneAreas_table(
      name: 'Zone Areas',
    ),
    ZoneList_table(
      testData: zoneList,
      name: 'Zone List',
    ),
    ZoneReportsTable(testData: zoneReports, name: 'Zone Reports'),
    Products_table(
      testData: products,
      name: 'Products',
    ),
    OrdersTable(testData: orders, name: 'Orders'),
    NewsLetterTab(),
    Whatsappui(testData: Login_Reports, name: 'WhatsApp'),
    SpeechProfileGrid(
      name: 'SpeechProfile',
    ),
    SmsCommunicationTable(name: 'SMS Communication'),
    WishesProfile()

  ];

  int currentPage = 0;

  void updatePage(int index) {
    setState(() {
      currentPage = index;
    });
  }

  bool isSidebarVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F7FB),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 1150) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isSidebarVisible)
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: SidebarUi(onItemSelected: updatePage),
                  ),
                // Text('khkkk'),
                Expanded(child: pages[currentPage]),
                // Expanded(
                //   child: Stack(
                //     children: [
                //       Flexible(
                //         child:
                //       ),

                //       DashboardHeader(onMenuPressed: (){
                //         setState(() {
                //         isSidebarVisible = !isSidebarVisible;
                //       });},),
                //     ],
                //   ),
                // ),
              ],
            );
          } else {
            return Stack(
              children: [
                pages[currentPage],
                DashboardHeader(
                  onMenuPressed: () {
                    setState(() {
                      isSidebarVisible = !isSidebarVisible;
                    });
                  },
                ),
                if (isSidebarVisible)
                  Row(
                    children: [
                      SidebarUi(onItemSelected: updatePage),
                      Expanded(
                          child: InkWell(
                              onTap: () =>
                                  setState(() => isSidebarVisible = false),
                              child: Container(
                                color: Colors.grey.withOpacity(0.5),
                              )))
                    ],
                  ),
              ],
            );
          }
        },
      ),
    );
  }
}
