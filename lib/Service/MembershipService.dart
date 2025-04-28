import 'dart:convert';

import 'package:http/http.dart' as http;

class Membershipservice {
  String baseUrl = "http://147.93.97.78:5030/";
  Future<List<Map<String, dynamic>>> fetchMembershipReportData() async {
    List<Map<String, dynamic>> responseDataTable = [];

    try {
      final response = await http.get(Uri.parse("${baseUrl}membership/"));
      if (response.statusCode == 200) {
        
        final List<dynamic> data = jsonDecode(response.body);
        responseDataTable = data.map((data) {
          return {
            "No": data['id'],
            "Time":
                data['datetime'].toString().split('T').last.split('.').first,
            "Subject": data['from_date'] ?? 'No Subject',
            "Message": data['message'],
            "UserCount": data['users_count'],
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
        "header": ["User", "Date", "Amount", 'Month', 'Payment Mode', "Action"],
        "dataType": [
          "UserNameWithProfile",
          "Date",
          "Text",
          'Text',
          'Status',
          "Action",
        ],
        "data": responseDataTable
      }
    ];
  }
}
