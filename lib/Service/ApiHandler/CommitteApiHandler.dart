import 'package:church_admin/Service/CommitteService.dart';

Future<List<Map<String, dynamic>>> fetchCommitteeDataFromApi() async {
  try {
    final responseData = await Committeservice().fetchCommitteData();
    print("Data returned successfully From Api");
    return responseData;
  } catch (e) {
    print("Error while Fetching the data from Api in Api handler file : $e");
  }
  return [];
}
