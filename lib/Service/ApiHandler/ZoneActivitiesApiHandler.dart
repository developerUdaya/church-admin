import 'dart:async';

import 'package:church_admin/Service/ZoneActivitiesService.dart';

Future<List<Map<String, dynamic>>> fetchZoneAreaDataFromApi() async {
  try {
    final responseData =
        await Zoneactivitiesservice().fetchZoneActivitiesZoneAresData();
    print("Data returned successfully From Api");
    return responseData;
  } catch (e) {
    print("Error while Fetching the data from Api in Api handler file : $e");
  }
  return [];
}

Future<List<Map<String, dynamic>>> fetchZoneListFromApi() async {
  try {
    final responseData =
        await Zoneactivitiesservice().fetchZoneActivitiesZoneListData();
    print("Data returned successfully From Api");
    return responseData;
  } catch (e) {
    print("Error while Fetching the data from Api in Api handler file : $e");
  }
  return [];
}

Future<List<Map<String, dynamic>>> fetchZoneReportFromApi() async {
  try {
    final responseData =
        await Zoneactivitiesservice().fetchZoneActivitiesZoneReportData();
    print("Data returned successfully From Api");
    return responseData;
  } catch (e) {
    print("Error while Fetching the data from Api in Api handler file : $e");
  }
  return [];
}
