import 'package:church_admin/view/DashBoard.dart';
import 'package:church_admin/view/IKIAAdminPanel.dart';
import 'package:church_admin/view/LoginScreen.dart';
import 'package:church_admin/view/Tables/AssetManagementTable.dart';
import 'package:church_admin/view/Tables/AudioPodcastTable.dart';
import 'package:church_admin/view/Tables/BlogTable.dart';
import 'package:church_admin/view/Tables/BloodRequirementTable.dart';
import 'package:church_admin/view/Tables/ChurchStaffTable.dart';
import 'package:church_admin/view/Tables/CommitteeTable.dart';
import 'package:church_admin/view/Tables/DepartmentTable.dart';
import 'package:church_admin/view/Tables/DonationsTable.dart';
import 'package:church_admin/view/Tables/EmailCommunicationTable.dart';
import 'package:church_admin/view/Tables/EventManagementTable.dart';
import 'package:church_admin/view/Tables/FamiliesTable.dart';
import 'package:church_admin/view/Tables/FlocksTable.dart';
import 'package:church_admin/view/Tables/FunctionHallTable.dart';
import 'package:church_admin/view/Tables/FundManagementTable.dart';
import 'package:church_admin/view/Tables/GalleryTab.dart';
import 'package:church_admin/view/Tables/LoginReportsTable.dart';
import 'package:church_admin/view/Tables/ManageRoleTable.dart';
import 'package:church_admin/view/Tables/MeetingTables.dart';
import 'package:church_admin/view/Tables/MembersTable.dart';
import 'package:church_admin/view/Tables/MembershipReportsTable.dart';
import 'package:church_admin/view/Tables/NewsLetterTab.dart';
import 'package:church_admin/view/Tables/NoticesTable.dart';
import 'package:church_admin/view/Tables/NotificationTable.dart';
import 'package:church_admin/view/Tables/OrdersTable.dart';
import 'package:church_admin/view/Tables/PastorsProfileGrid.dart';
import 'package:church_admin/view/Tables/PrayersTable.dart';
import 'package:church_admin/view/Tables/ProductsTable.dart';
import 'package:church_admin/view/Tables/RemembranceDaysTable.dart';
import 'package:church_admin/view/Tables/SmsCommunicationTable.dart';
import 'package:church_admin/view/Tables/SpeechProfileGrid.dart';
import 'package:church_admin/view/Tables/StudentTable.dart';
import 'package:church_admin/view/Tables/TestimonyTable.dart';
import 'package:church_admin/view/Tables/UserListTable.dart';
import 'package:church_admin/view/Tables/WhatsappTab.dart';
import 'package:church_admin/view/Tables/ZoneAreasTable.dart';
import 'package:church_admin/view/Tables/ZoneListTable.dart';
import 'package:church_admin/view/Tables/ZoneReportsTable.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.manrope().fontFamily,
      ),
      initialRoute: '/ikiaAdminPanel',
      routes: {
        '/': (context) => LoginScreen(),
        '/ikiaAdminPanel': (context) => IkiaAdminPanel(),
        '/dashboard': (context) => Dashboard(),
        '/userlist': (context) => userList_table(),
        '/memberslist': (context) => MembersTable(),
        '/families': (context) => FamiliesTable(),
        '/littleflocks': (context) => FlocksTable(),
        '/students': (context) => StudentTable(),
        '/committee': (context) => CommitteeTable(),
        '/pastorsProfile': (context) => PastorsProfileGrid(),
        '/churchStaff': (context) => ChurchStaffTable(),
        '/department': (context) => DepartmentTable(),
        '/membershipReports': (context) => MembershipReportsTable(),
        '/fundManagement': (context) => FundManagementTables(),
        '/donations': (context) => DonationsTable(),
        '/assetManagement': (context) => AssetManagementTable(),
        '/emailCommunication': (context) => EmailCommunicationTable(),
        '/notification': (context) => NotificationTable(),
        '/bloodRequirement': (context) => BloodRequirementTable(),
        '/blog': (context) => BlogTable(),
        '/testimony': (context) => TestimonyTable(),
        '/prayers': (context) => PrayersTable(),
        '/meeting': (context) => MeetingTable(),
        '/eventManagement': (context) => EventManagementTable(),
        '/remembranceDays': (context) => RemembranceDaysTable(),
        '/notices': (context) => NoticesTable(),
        '/functionHall': (context) => FunctionHallTable(),
        '/audioPodcast': (context) => AudioPodcastTable(),
        '/gallery': (context) => GalleryPage(),
        '/manageRoles': (context) => ManageRoleTable(),
        '/loginReports': (context) => LoginReportsTable(),
        '/zoneAreas': (context) => zoneAreas_table(),
        '/zoneList': (context) => ZoneList_table(),
        '/zoneReports': (context) => ZoneReportsTable(),
        '/products': (context) => Products_table(),
        '/orders': (context) => OrdersTable(),
        '/newsletter': (context) => NewsLetterTab(),
        '/whatsapp': (context) => Whatsappui(),
        '/speechProfile': (context) => SpeechProfileGrid(),
        '/smsCommunication': (context) => SmsCommunicationTable(),
      },
    );
  }
}
