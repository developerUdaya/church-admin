import 'package:church_admin/Service/PastorsService.dart';

Future<List<Map<String, dynamic>>> fetchChurchTools5ColumnTabelDataFromApi(
    String endPoint) async {
  try {
    final responseData = await Pastorsservice().fetchChurchToolsSpeechData();
    print("Data returned successfully");
    return responseData;
  } catch (e) {
    print("Error while Fetching the data from Api in Api handler file : $e");
  }
  return [];
}
