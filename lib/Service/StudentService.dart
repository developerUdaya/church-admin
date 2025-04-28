import 'dart:convert';
import 'package:http/http.dart' as http;

class Studentservice {
  String baseUrl = "http://147.93.97.78:5030/";

  Future<Map<String, dynamic>> fetchstudentData() async {
    List<Map<String, dynamic>> responseDataTable = [];

    try {
      final response = await http
          .get(Uri.parse("${baseUrl}user_with_other_details_by_role/student/"));
      if (response.statusCode == 200) {
        
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final List<dynamic> users = responseData["users"];

        responseDataTable = users.map((user) {
          final userData = user["user"];
          final address = (user["addresses"] as List).isNotEmpty
              ? user["addresses"][0]
              : null;

          return {
            "No": userData["id"],
            "Name": {
              "name": userData["name"] ?? "N/A",
              "profilePictures": userData["profile_image"] != null &&
                      userData["profile_image"].toString().startsWith("http")
                  ? userData["profile_image"]
                  : "assets/avatar1.png",
            },
            "class": userData["role"] ?? "N/A",
            "Phone": userData["contact_number"] ?? "N/A",
            "Country": address?["country"] ?? "N/A",
            "Action": "Action",
          };
        }).toList();
      } else {
        print("Error fetching data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching data: $e");
    }

    return {
      "header": ['No', 'Name', 'class', 'Phone', 'Country', 'Action'],
      "dataType": [
        "Text",
        "UserNameWithProfile",
        "Text",
        "Text",
        "Text",
        "Action"
      ],
      "data": responseDataTable
    };
  }
}
