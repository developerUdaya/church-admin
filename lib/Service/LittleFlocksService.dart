import 'dart:convert';

import 'package:http/http.dart' as http;

class Littleflocksservice {
  String baseUrl = "http://147.93.97.78:5030/";
  Future<List<Map<String, dynamic>>> fetchLittleFlocksData() async {
    List<Map<String, dynamic>> responseDataTable = [];

    try {
      final response = await http.get(Uri.parse("${baseUrl}choir/"));
      if (response.statusCode == 200) {
        
        final List<dynamic> data = jsonDecode(response.body);
        responseDataTable = data.map((data) {
          return {
            "No": data['id'],
            "Name": data['name'],
            "Action": 'Action',
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
        "header": ['No', 'Name', 'Action'],
        "dataType": ['Text', 'Text', 'Action'],
        "data": responseDataTable
      }
    ];
  }

  Future<bool> createFlock({
    required String name,
    required String createdBy,
  }) async {
    final url = Uri.parse("${baseUrl}choir/");
    final payload = {
      "name": name,
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
        print('Failed to create flock. Status code: ${response.statusCode}, Response: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error creating flock: $e');
      return false;
    }
  }
}
