import 'dart:convert';

import 'package:http/http.dart' as http;

class Churchstaffservice {
  String baseUrl = "http://147.93.97.78:5030/";
  Future<List<Map<String, dynamic>>> fetchChurchStaffData() async {
    List<Map<String, dynamic>> responseDataTable = [];

    try {
      final response = await http.get(Uri.parse("${baseUrl}membership/"));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final List<dynamic> users = responseData["users"];

        responseDataTable = users.map((user) {
          final userData = user["user"];

          return {
            "No": userData["id"],
            "Name": {
              "name": userData["name"] ?? "N/A",
              "profilePictures": userData["profile_image"] != null &&
                      userData["profile_image"].toString().startsWith("http")
                  ? userData["profile_image"]
                  : "assets/avatar1.png",
            },
            "Position": userData["role"] ?? "N/A",
            "Phone": userData["contact_number"] ?? "N/A",
            "Gender": userData['gender'],
            "Action": "Action",
          };
        }).toList();
      } else {
        print("Error fetching data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching data: $e");
    }

    return [
      {
        "header": ['No', 'Name', 'Position', 'phone', 'Gender', 'Action'],
        "dataType": [
          'Text',
          'UserNameWithProfile',
          'Text',
          'Text',
          'Text',
          'Action'
        ],
        "data": responseDataTable
      }
    ];
  }

  Future<bool> updateUserRoleToPastor({
    required String userId,
    required String updatedBy,
  }) async {
    final url = Uri.parse("${baseUrl}users/update_role/$userId/pastor/");
    final payload = {
      "updated_by": updatedBy,
    };

    try {
      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200) {

        return true;
      } else {
        print(
            'Failed to update user role. Status code: ${response.statusCode}, Response: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error updating user role: $e');
      return false;
    }
  }
  Future<bool> createMeeting({
    required String location,
    required String datetime,
    required String hostUser,
    required String title,
    required String agenda,
    required String createdBy,
  }) async {
    final url = Uri.parse("${baseUrl}meetings/");
    final payload = {
      "location": location,
      "datetime": datetime,
      "host_user": hostUser,
      "title": title,
      "agenda": agenda,
      "created_by": createdBy,
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        print('Failed to create meeting. Status code: ${response.statusCode}, Response: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error creating meeting: $e');
      return false;
    }
  }
}
