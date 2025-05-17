import 'dart:convert';
import 'package:http/http.dart' as http;

class Familiesservice {
  String baseUrl = "http://147.93.97.78:5030/";

  Future<List<Map<String, dynamic>>> fetchFamiliesData() async {
    List<Map<String, dynamic>> responseDataTable = [];

    try {
      final response = await http.get(Uri.parse("${baseUrl}fetch_all_family_with_other_details/"));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        responseDataTable = data.map((data) {
          return {
            "No": data['family_id'],
            "Title": data['title'],
            "FamilyLeader": data['family_head'],
            "Family Count": {"profilePictures":[data['family_members_imageUrls'][0].toString() ],
            "count": data['family_count']??0},
            "Phone": data['head_mobile_number'] ?? '',
            "Status": 'Active', // Assuming status is always 'Active'
            "Family Members Images": [data['family_members_imageUrls'][0] ]?? [],
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
      'No',
      'Title',
      'FamilyLeader',
      'Family Count',
      'Phone',
      'Status',
      // 'Action'
    ],
    "dataType": [
      "Text",
      "Text",
      "Text",
      "UserList",
      "Text",
      "Status",
      // "Action"
    ],
        "data": responseDataTable
      }
    ];
  }

  Future<bool> createFamilyGroup({
    required String groupName,
    required String headUser,
  }) async {
    final url = Uri.parse("${baseUrl}groups/");
    final payload = {
      "group_name": groupName,
      "description": "Updated family group description",
      "type": "family",
      "head_user": headUser,
      "created_by": "admin_user",
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
        print('Failed to create family group. Status code: ${response.statusCode}, Response: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error creating family group: $e');
      return false;
    }
  }
}
