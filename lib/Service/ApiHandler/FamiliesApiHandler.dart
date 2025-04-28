import 'package:church_admin/Service/FamiliesService.dart';

Future<List<Map<String, dynamic>>> fetchFamiliesDataFromApi() async {
  try {
    final responseData = await Familiesservice().fetchFamiliesData();
    print("Data returned successfully From Api");
    return responseData;
  } catch (e) {
    print("Error while Fetching the data from Api in Api handler file : $e");
  }
  return [];
}
