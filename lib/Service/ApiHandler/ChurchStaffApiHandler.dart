import 'package:church_admin/Service/ChurchStaffService.dart';

Future<List<Map<String, dynamic>>> fetchChurchStaffDataFromApi(
    String endPoint) async {
  try {
    final responseData = await Churchstaffservice().fetchChurchStaffData();
    print("Data returned successfully");
    return responseData;
  } catch (e) {
    print("Error while Fetching the data from Api in Api handler file : $e");
  }
  return [];
}
