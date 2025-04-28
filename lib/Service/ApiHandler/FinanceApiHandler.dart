import 'package:church_admin/Service/FinanceService.dart';

Future<List<Map<String, dynamic>>>
    fetchFinanceFundManagamentDataFromApi() async {
  try {
    final responseData =
        await Financeservice().fetchFinanceFundManagementData();
    print("Data returned successfully From Api");
    return responseData;
  } catch (e) {
    print("Error while Fetching the data from Api in Api handler file : $e");
  }
  return [];
}

Future<List<Map<String, dynamic>>> fetchFinanceDonationsDataFromApi() async {
  try {
    final responseData = await Financeservice().fetchFinanceDonationsData();
    print("Data returned successfully From Api");
    return responseData;
  } catch (e) {
    print("Error while Fetching the data from Api in Api handler file : $e");
  }
  return [];
}

Future<List<Map<String, dynamic>>> fetchFinanceAssetManagementDataFromApi() async {
  try {
    final responseData = await Financeservice().fetchFinanceAssetManagementData();
    print("Data returned successfully From Api");
    return responseData;
  } catch (e) {
    print("Error while Fetching the data from Api in Api handler file : $e");
  }
  return [];
}


