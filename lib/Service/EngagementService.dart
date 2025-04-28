// ignore_for_file: file_names

import 'dart:convert';

import 'package:http/http.dart' as http;

class Engagementservice {
  String baseUrl = "http://147.93.97.78:5030/";
  Future<List<Map<String, dynamic>>>
      fetchEngagementSMSCommunicationData() async {
    List<Map<String, dynamic>> responseDataTable = [];

    try {
      final response = await http.get(Uri.parse("${baseUrl}sms/"));
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
        "header": ["No", "Time", "Subject", 'Message', "UserCount", "Action"],
        "dataType": ["Text", "Text", 'Text', 'Text', "Text", "Action"],
        "data": responseDataTable
      }
    ];
  }

  Future<List<Map<String, dynamic>>>
      fetchEngagementEmailCommunicationData() async {
    List<Map<String, dynamic>> responseDataTable = [];

    try {
      final response = await http.get(Uri.parse("${baseUrl}emails/"));
      if (response.statusCode == 200) {
        
        final List<dynamic> data = jsonDecode(response.body);
        responseDataTable = data.map((data) {
          return {
            "No": data['id'],
            "Date": data['to_list'][0],
            "Subject": data['subject'] ?? 'No Subject',
            "Content": data['content'],
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
        "header": ["No", "Date", "Time", "Subject", 'Content', "View"],
        "dataType": ["Text", "Date", 'Date', 'Text', "Text", "Text"],
        "data": responseDataTable
      }
    ];
  }

  Future<List<Map<String, dynamic>>> fetchEngagementNotificationData() async {
    List<Map<String, dynamic>> responseDataTable = [];

    try {
      final response = await http.get(Uri.parse("${baseUrl}emails/"));
      if (response.statusCode == 200) {
        
        final List<dynamic> data = jsonDecode(response.body);
        responseDataTable = data.map((data) {
          return {
            "No": data['id'],
            "Date": data['datetime'].toString().split('T').first,
            "Time":
                data['datetime'].toString().split('T').last.split('.').first,
            "Subject": data['subject'] ?? 'No Subject',
            "Content": data['content'],
            "View": 'Action',
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
        "header": ["No", "Date", "Time", "Subject", 'Content', "View"],
        "dataType": ["Text", "Date", 'Date', 'Text', "Text", "Text"],
        "data": responseDataTable
      }
    ];
  }

  Future<List<Map<String, dynamic>>> fetchEngagementBlogData() async {
    List<Map<String, dynamic>> responseDataTable = [];

    try {
      final response = await http.get(Uri.parse("${baseUrl}blog/"));
      if (response.statusCode == 200) {
        
        final List<dynamic> data = jsonDecode(response.body);
        responseDataTable = data.map((data) {
          return {
            "No": data['id'],
            "Title": data['title'],
            "Description": data['description'],
            "Date": data['datetime'].toString().split('T').first,
            "Like": data['likes'],
            "Author/Writer/Speaker": data['author'],
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
          "No",
          "Title",
          "Description",
          "Date",
          'Like',
          "Author/Writer/Speaker",
          "Action"
        ],
        "dataType": ["Text", "Text", 'Text', 'Date', "Icon", "Text", "Action"],
        "data": responseDataTable
      }
    ];
  }
}
