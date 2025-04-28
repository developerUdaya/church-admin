import 'package:church_admin/Service/EngagementService.dart';

Future<List<Map<String, dynamic>>>
    fetchEngagementSMSCommunicationDataFromApi() async {
  try {
    final responseData =
        await Engagementservice().fetchEngagementSMSCommunicationData();
    print("Data returned successfully From Api");
    return responseData;
  } catch (e) {
    print("Error while Fetching the data from Api in Api handler file : $e");
  }
  return [];
}

Future<List<Map<String, dynamic>>>
    fetchEngagementEmailCommunicationDataFromApi() async {
  try {
    final responseData =
        await Engagementservice().fetchEngagementEmailCommunicationData();
    print("Data returned successfully From Api");
    return responseData;
  } catch (e) {
    print("Error while Fetching the data from Api in Api handler file : $e");
  }
  return [];
}

Future<List<Map<String, dynamic>>>
    fetchEngagementNotificationDataFromApi() async {
  try {
    final responseData =
        await Engagementservice().fetchEngagementNotificationData();
    print("Data returned successfully From Api");
    return responseData;
  } catch (e) {
    print("Error while Fetching the data from Api in Api handler file : $e");
  }
  return [];
}

Future<List<Map<String, dynamic>>> fetchEngagementBlogDataFromApi() async {
  try {
    final responseData = await Engagementservice().fetchEngagementBlogData();
    print("Data returned successfully From Api");
    return responseData;
  } catch (e) {
    print("Error while Fetching the data from Api in Api handler file : $e");
  }
  return [];
}
