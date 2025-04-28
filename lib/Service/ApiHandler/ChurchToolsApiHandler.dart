import 'package:church_admin/Service/ChurchToolsServices.dart';
import 'package:church_admin/model/SpeechModel.dart';
import 'package:church_admin/model/TestimonyModel.dart';

Future<List<SpeechModel>> fetchChurchToolsSpeechDataFromApi() async {
  try {
    final speechData = await Churchtoolsservices().fetchChurchToolsSpeechData();
    if (speechData != null && speechData is List) {
      print("Data returned successfully");
      return speechData.map((json) => SpeechModel.fromJson(json)).toList();
    } else {
      print("Data returned Failed!");
    }
  } catch (e) {
    print("Error while Fetching the data from Api in Api handler file : $e");
  }
  return [];
}

Future<List<Map<String, dynamic>>> fetchChurchTools5ColumnTabelDataFromApi(
    String endPoint) async {
  try {
    final responseData =
        await Churchtoolsservices().fetchChurchTools5ColumnTableDatas(endPoint);
    print("Data returned successfully");
    return responseData;
  } catch (e) {
    print("Error while Fetching the data from Api in Api handler file : $e");
  }
  return [];
}

Future<List<Map<String, dynamic>>>
    fetchChurchToolsAudioPodcastDataFromApi() async {
  try {
    final responseData =
        await Churchtoolsservices().fetchChurchToolsAudioPodcastData();
    print("Data returned successfully From Api");
    return responseData;
  } catch (e) {
    print("Error while Fetching the data from Api in Api handler file : $e");
  }
  return [];
}

Future<List<Map<String, dynamic>>>
    fetchChurchToolsEventManagementDataFromApi() async {
  try {
    final responseData =
        await Churchtoolsservices().fetchChurchToolsEventManagementData();
    print("Data returned successfully From Api");
    return responseData;
  } catch (e) {
    print("Error while Fetching the data from Api in Api handler file : $e");
  }
  return [];
}

Future<List<Map<String, dynamic>>>
    fetchChurchToolsRemembranceDataFromApi() async {
  try {
    final responseData =
        await Churchtoolsservices().fetchChurchToolsRemembranceData();
    print("Data returned successfully From Api");
    return responseData;
  } catch (e) {
    print("Error while Fetching the data from Api in Api handler file : $e");
  }
  return [];
}

Future<List<Map<String, dynamic>>>
    fetchChurchToolsFunctionHallDataFromApi() async {
  try {
    final responseData =
        await Churchtoolsservices().fetchChurchToolsFunctionHallDatas();
    print("Data returned successfully From Api");
    return responseData;
  } catch (e) {
    print("Error while Fetching the data from Api in Api handler file : $e");
  }
  return [];
}
