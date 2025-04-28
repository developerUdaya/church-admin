import 'dart:convert';
import 'package:http/http.dart' as http;

class MembersService {
  String baseUrl = "http://147.93.97.78:5030/";

  Future<List<Map<String, dynamic>>> fetchMembersData() async {
    List<Map<String, dynamic>> responseDataTable = [];

    try {
      final response = await http
          .get(Uri.parse("${baseUrl}user_with_other_details_by_role/member/"));
      if (response.statusCode == 200) {
        
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final List<dynamic> users = responseData["users"];

        responseDataTable = users.map((user) {
          final userData = user["user"];
          return {
            "No": userData["id"],
            "Member ID": 'IKIA0${userData["id"]}',
            "Name": {
              "name": userData["name"] ?? "N/A",
              "profilePictures": userData["profile_image"] ??
                  "https://cdn-icons-png.flaticon.com/512/3135/3135715.png", // Default if null
            },
            "Phone": userData["contact_number"] ?? "N/A",
            "Pin Code": "6000300", // Static placeholder
            "Status": (userData["active_status"] ?? "inactive")
                .toString()
                .replaceFirstMapped(
                    RegExp(r'^\w'), (match) => match.group(0)!.toUpperCase()),
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
        "header": [
          "No",
          "Member ID",
          "Name",
          "Phone",
          "Pin Code",
          "Status",
          "Action"
        ],
        "dataType": [
          "Text",
          "Text",
          "UserNameWithProfile",
          "Text",
          "Text",
          "Status",
          "Action",
        ],
        "data": responseDataTable
      }
    ];
  }


  
}
