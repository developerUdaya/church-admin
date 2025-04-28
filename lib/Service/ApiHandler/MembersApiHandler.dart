import 'package:church_admin/Service/MembersService.dart';

Future<List<Map<String, dynamic>>> fetchMembersDataFromApi() async {
  try {
    final responseData = await MembersService().fetchMembersData();
    print("Data returned successfully From Api");
    return responseData;
  } catch (e) {
    print("Error while Fetching the data from Api in Api handler file : $e");
  }
  return [];
}