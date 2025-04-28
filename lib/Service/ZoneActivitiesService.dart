import 'dart:convert';

import 'package:http/http.dart' as http;

class Zoneactivitiesservice {
  String baseUrl = "http://147.93.97.78:5030/";
  Future<List<Map<String, dynamic>>> fetchZoneActivitiesZoneAresData() async {
    List<Map<String, dynamic>> responseDataTable = [];

    try {
      final response = await http.get(Uri.parse("${baseUrl}zones/"));
      if (response.statusCode == 200) {
        
        final List<dynamic> data = jsonDecode(response.body);
        responseDataTable = data.map((data) {
          return {
            "No": data['id'],
            "Place": data['name'],
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
        "header": ['No', 'Place', 'Action'],
        "dataType": ['Text', 'Text', 'Action'],
        "data": responseDataTable
      }
    ];
  }

  Future<List<Map<String, dynamic>>> fetchZoneActivitiesZoneListData() async {
    List<Map<String, dynamic>> responseDataTable = [];

    try {
      final response = await http.get(Uri.parse("${baseUrl}zone-area/"));
      if (response.statusCode == 200) {
        
        final List<dynamic> data = jsonDecode(response.body);
        responseDataTable = data.map((data) {
          return {
            "No": data['id'],
            "Zone Name": data['zone_name'] ?? 'No Data',
            "Total Area": data['total_area'] ?? 'No Data',
            "Zone Leader": data['zone_leader'] ?? 'No Data',
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
        "header": ['No', 'Zone Name', 'Total Area', 'Zone Leader', 'Action'],
        "dataType": ['Text', 'icon', 'Text', 'Text', 'Action'],
        "data": responseDataTable
      }
    ];
  }

  Future<List<Map<String, dynamic>>> fetchZoneActivitiesZoneReportData() async {
    List<Map<String, dynamic>> responseDataTable = [];

    try {
      final response = await http.get(Uri.parse("${baseUrl}zone-task/"));
      if (response.statusCode == 200) {
        
        final List<dynamic> data = jsonDecode(response.body);
        responseDataTable = data.map((data) {
          return {
            "No": data['id'],
            "Zone Name": data['task_name'],
            "Zone Leader": data['zone_leader'] ?? 'No Data',
            "Assigned Date/Time":
                data['created_at'].toString().split('T').last.split('.').first,
            "Status": data['status'].toString().replaceFirst(
                data['status'][0], data['status'][0].toUpperCase()),
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
        "header": [
          'No',
          'Zone Name',
          'Zone Leader',
          'Assigned Date/Time',
          'Status'
        ],
        "dataType": ['Text', 'Text', 'Text', 'date', 'Status'],
        "data": responseDataTable
      }
    ];
  }

  Future<bool> createZone({
    required String name,
    required String headUser,
    required String headMobileNumber,
    required String createdBy,
  }) async {
    final url = Uri.parse("${baseUrl}zones/");
    final payload = {
      "name": name,
      "head_user": headUser,
      "head_mobile_number": headMobileNumber,
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
        print(
            'Failed to create zone. Status code: ${response.statusCode}, Response: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error creating zone: $e');
      return false;
    }
  }

  Future<bool> createZoneList({
    required String zone,
    required String name,
    required String createdBy,
  }) async {
    final url = Uri.parse("${baseUrl}zone-area/");
    final payload = {
      "zone": zone,
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
        print('Zone area created successfully! Response: ${response.body}');
        return true;
      } else {
        print(
            'Failed to create zone area. Status code: ${response.statusCode}, Response: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error creating zone area: $e');
      return false;
    }
  }

  Future<bool> createZoneTask({
    required String zone,
    required String zoneArea,
    required String taskName,
    required String taskDescription,
    required String dueDate, // Changed to required, default to "" in form
    required String status,
    required String report,
    required String createdBy,
  }) async {
    final url = Uri.parse("${baseUrl}zone-task/");
    final payload = {
      "zone": zone,
      "zone_area": zoneArea,
      "task_name": taskName,
      "task_description": taskDescription,
      "due_date": dueDate, // Will be "" if no date selected
      "status": status,
      "report": report,
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
        print('Zone task created successfully! Response: ${response.body}');
        return true;
      } else {
        print('Failed to create zone task. Status code: ${response.statusCode}, Response: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error creating zone task: $e');
      return false;
    }
  }
}
