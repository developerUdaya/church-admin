import 'package:church_admin/Service/DepartmentService.dart';

Future<List<Map<String, dynamic>>> fetchDepartmentDataFromApi() async {
  try {
    final responseData = await Departmentservice().fetchAllDepartmentData();
    print("Data returned successfully From Api");
    return responseData;
  } catch (e) {
    print("Error while Fetching the data from Api in Api handler file : $e");
  }
  return [];
}
