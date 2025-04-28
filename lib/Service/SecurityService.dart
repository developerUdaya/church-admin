import 'dart:convert';

import 'package:http/http.dart' as http;

class Securityservice {
  String baseUrl = "http://147.93.97.78:5030/";

  Future<List<Map<String, dynamic>>> fetchSecurityLoginReportData() async {
    List<Map<String, dynamic>> responseDataTable = [];

    try {
      final response = await http.get(Uri.parse("${baseUrl}login-logs/"));
      if (response.statusCode == 200) {
        
        final List<dynamic> data = jsonDecode(response.body);
        responseDataTable = data.map((data) {
          return {
            "No": data['id'],
            "Device Os": data['platform'],
            "Device ID": data['device_id'],
            "IP Address": data['ip_address'],
            "Location": data['location'],
            "Date": data['datetime'].toString().split('T').first,
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
          'Device Os',
          'Device ID',
          'IP Address',
          'Location',
          'Date'
        ],
        "dataType": ['Text', 'Text', 'Text', 'Text', 'Text', 'Text'],
        "data": responseDataTable
      }
    ];
  }
}
