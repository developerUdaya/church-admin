import 'package:church_admin/Service/SecurityService.dart';

Future<List<Map<String, dynamic>>> fetchsecurityLoginReportDataFromApi() async {
  try {
    final responseData = await Securityservice().fetchSecurityLoginReportData();
    print("Data returned successfully From Api");
    return responseData;
  } catch (e) {
    print("Error while Fetching the data from Api in Api handler file : $e");
  }
  return [];
}
