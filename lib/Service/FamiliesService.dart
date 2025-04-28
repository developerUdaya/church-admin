import 'dart:convert';
import 'package:http/http.dart' as http;

class Familiesservice {
  String baseUrl = "http://147.93.97.78:5030/";

  Future<List<Map<String, dynamic>>> fetchFamiliesData() async {
    List<Map<String, dynamic>> responseDataTable = [];

    try {
      final response = await http.get(Uri.parse("${baseUrl}groups/"));
      if (response.statusCode == 200) {
        
        final List<dynamic> data = jsonDecode(response.body);
        responseDataTable = data.map((data) {
          return {
            "No": data['id'],
            "Title": data['group_name'],
            "FamilyLeader": data['type'], // Note: Should this be head_user?
            "Family Count": data['ip_address'], // Note: Adjust if needed
            "Phone": data['contact_number'] ?? '',
            "Status": data['status'] ?? 'Active',
            "Action": 'Action'
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
          'Action'
        ],
        "dataType": [
          "Text",
          "Text",
          "Text",
          "UserList",
          "Text",
          "Status",
          "Action"
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