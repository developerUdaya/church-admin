import 'package:church_admin/Service/LittleFlocksService.dart';

Future<List<Map<String, dynamic>>> fetchLittleFlocksDataFromApi() async {
  try {
    final responseData = await Littleflocksservice().fetchLittleFlocksData();
    print("Data returned successfully From Api");
    return responseData;
  } catch (e) {
    print("Error while Fetching the data from Api in Api handler file : $e");
  }
  return [];
}
