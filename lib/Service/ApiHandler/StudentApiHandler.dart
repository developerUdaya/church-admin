import 'package:church_admin/Service/StudentService.dart';

Future<List<Map<String, dynamic>>> fetchStudentDataFromApi() async {
  try {
    final responseData = await Studentservice().fetchstudentData();
    print("Data returned successfully From Api");

    // Wrap the entire response in a list
    return [responseData];
  } catch (e) {
    print("Error while Fetching the data from Api in Api handler file: $e");
  }
  return []; // Return an empty list in case of an error
}
