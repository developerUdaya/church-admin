// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Churchtoolsservices {
  String baseUrl = "http://147.93.97.78:5030/";
  Future<dynamic> fetchChurchToolsSpeechData() async {
    try {
      final response = await http.get(Uri.parse("${baseUrl}speech/"));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      } else {
        print("Error fetching data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("error at fetch data $e");
    }
  }

  Future<List<Map<String, dynamic>>> fetchChurchTools5ColumnTableDatas(
      String endPoint) async {
    List<Map<String, dynamic>> responseDataTable = [];

    try {
      final response = await http.get(Uri.parse("$baseUrl$endPoint/"));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        responseDataTable = data.map((data) {
          return {
            "No": data['id'],
            "Title": data['title'],
            "Description": data['description'] ?? data['agenda'],
            "Date": data['datetime'],
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
        "header": ['No', 'Title', 'Date', 'Description', 'Action'],
        "dataType": ["Text", "Text", 'Date', "Text", "Action"],
        "data": responseDataTable
      }
    ];
  }

  Future<List<Map<String, dynamic>>> fetchChurchToolsAudioPodcastData() async {
    List<Map<String, dynamic>> responseDataTable = [];
    try {
      final response = await http.get(Uri.parse("${baseUrl}audio_podcast/"));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        responseDataTable = data.map((data) {
          return {
            "No": data['id'],
            "Title": data['title'],
            "Volume": data['volume'],
            "Vocal": data['vocal'],
            "Date/Time": data['datetime'] != null
                ? DateTime.parse(DateTime.now().toIso8601String())
                : DateTime.now().toIso8601String(),
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
        "header": ["Title", 'Vocal', 'Volume', "Date/Time", "Action"],
        "dataType": ["Text", 'Text', "Text", 'Date', "Action"],
        "data": responseDataTable
      }
    ];
  }

  Future<List<Map<String, dynamic>>>
      fetchChurchToolsEventManagementData() async {
    List<Map<String, dynamic>> responseDataTable = [];
    try {
      final response = await http.get(Uri.parse("${baseUrl}events/"));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        responseDataTable = data.map((data) {
          return {
            "No": data['id'],
            "Event": data['event_title'] ?? 'N/A',
            "Date": data['event_date'] ?? 'N/A',
            "View": data['event_time'] ?? 'N/A',
            "Registered Users": data['host_user'] ?? 'N/A',
            "Location": data['event_place'] ?? 'N/A',
            "Description": data['description'] ?? 'N/A',
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
          "Event",
          "Date",
          "View",
          "Registered Users",
          "Location",
          "Description",
          "Action"
        ],
        "dataType": [
          "Text",
          "UserList",
          "Date",
          "Text",
          "Icon",
          "Text",
          "Text",
          "Action"
        ],
        "data": responseDataTable
      }
    ];
  }

  Future<List<Map<String, dynamic>>> fetchChurchToolsRemembranceData() async {
    List<Map<String, dynamic>> responseDataTable = [];
    try {
      final response = await http.get(Uri.parse("${baseUrl}remembrance/"));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        responseDataTable = data.map((data) {
          return {
            "No": data['id'],
            "Name": data['name'],
            "Description": data['description'],
            "Date": data['dod'],
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
        "header": ["No", 'Name', 'Description', "Date", "Action"],
        "dataType": ["Text", 'Text', "Text", 'Date', "Action"],
        "data": responseDataTable
      }
    ];
  }

  Future<List<Map<String, dynamic>>> fetchChurchToolsFunctionHallDatas() async {
    List<Map<String, dynamic>> responseDataTable = [];

    try {
      final response = await http.get(Uri.parse("${baseUrl}booking/"));
      if (response.statusCode == 200) {
        
        final List<dynamic> data = jsonDecode(response.body);
        responseDataTable = data.map((data) {
          return {
            "Title": data['function_title'],
            "Date": data['created_at'],
            "From": data['from_date'],
            "To": data['to_date'],
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
        "header": ["Title", "Date", "From", 'To', "Action"],
        "dataType": ["Text", 'Date', "Date", 'Date', "Action"],
        "data": responseDataTable
      }
    ];
  }

  Future<bool> createPrayerRequest({
    required String user,
    required String title,
    required String description,
    required String date,
    required String createdBy,
    String approvalStatus = "approved", // Default to "approved" as per payload
  }) async {
    final url = Uri.parse("${baseUrl}prayer/");
    final payload = {
      "user": user,
      "title": title,
      "description": description,
      "datetime": date,
      "created_by": createdBy,
      "approval_status": approvalStatus,
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
            'Failed to create prayer request. Status code: ${response.statusCode}, Response: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error creating prayer request: $e');
      return false;
    }
  }

  Future<bool> createEvent({
    required String eventTitle,
    required String eventDate,
    required String eventPlace,
    required String eventTime,
    required String description,
    required String type,
    required String hostUser,
    required String createdBy,
    File? bannerFile, // For mobile/desktop
    Uint8List? bannerBytes, // For web
  }) async {
    final url = Uri.parse("${baseUrl}events/");
    var request = http.MultipartRequest('POST', url);

    // Add form fields
    request.fields['event_title'] = eventTitle;
    request.fields['event_date'] = eventDate;
    request.fields['event_place'] = eventPlace;
    request.fields['event_time'] = eventTime;
    request.fields['description'] = description;
    request.fields['type'] = type;
    request.fields['host_user'] = hostUser;
    request.fields['created_by'] = createdBy;

    // Handle banner image file
    if (kIsWeb && bannerBytes != null) {
      request.files.add(http.MultipartFile.fromBytes(
        'banner_file', // Adjust field name if API expects something else
        bannerBytes,
        filename: 'event_banner.jpg',
      ));
    } else if (bannerFile != null) {
      request.files.add(
          await http.MultipartFile.fromPath('banner_file', bannerFile.path));
    }

    try {
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        print(
            'Failed to create event. Status code: ${response.statusCode}, Response: $responseBody');
        return false;
      }
    } catch (e) {
      print('Error creating event: $e');
      return false;
    }
  }

  Future<bool> createRemembrance({
    required String user,
    required String name,
    required String gender,
    required String age,
    required String dob,
    required String dod,
    required String description,
    required String family,
    required String createdBy,
  }) async {
    final url = Uri.parse("http://147.93.97.78:5030/remembrance/");
    final payload = {
      "user": user,
      "name": name,
      "gender": gender,
      "age": age,
      "dob": dob,
      "dod": dod,
      "description": description,
      "family": family,
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
            'Failed to create remembrance. Status code: ${response.statusCode}, Response: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error creating remembrance: $e');
      return false;
    }
  }

  Future<bool> createNotice({
    required String user,
    required String datetime,
    required String title,
    required String description,
    required String createdBy,
  }) async {
    final url = Uri.parse("${baseUrl}notices/");
    final payload = {
      "user": user,
      "datetime": datetime,
      "title": title,
      "description": description,
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
            'Failed to create notice. Status code: ${response.statusCode}, Response: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error creating notice: $e');
      return false;
    }
  }

  Future<bool> createBooking({
    required String user,
    required String name,
    required String mobileNumber,
    required String address,
    required String functionTitle,
    required String fromDate,
    required String toDate,
    required String fromTime,
    required String toTime,
    required String bookingFor,
    required String createdBy,
  }) async {
    final url = Uri.parse("${baseUrl}booking/");
    final payload = {
      "user": user,
      "name": name,
      "mobile_number": mobileNumber,
      "address": address,
      "function_title": functionTitle,
      "from_date": fromDate,
      "to_date": toDate,
      "from_time": fromTime,
      "to_time": toTime,
      "booking_for": bookingFor,
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
            'Failed to create booking. Status code: ${response.statusCode}, Response: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error creating booking: $e');
      return false;
    }
  }

  Future<bool> createAudioPodcast({
    required String episode,
    required String volume,
    required String title,
    required String description,
    required String vocal,
    required String user,
    required String createdBy,
    File? imageFile,
    Uint8List? imageBytes, // Add for web
    File? audioFile,
    Uint8List? audioBytes, // Add for web
  }) async {
    final url = Uri.parse("${baseUrl}audio_podcast/");
    var request = http.MultipartRequest('POST', url);

    request.fields['episode'] = episode;
    request.fields['volume'] = volume;
    request.fields['title'] = title;
    request.fields['description'] = description;
    request.fields['vocal'] = vocal;
    request.fields['user'] = user;
    request.fields['created_by'] = createdBy;

    // Handle image file
    if (kIsWeb && imageBytes != null) {
      request.files.add(http.MultipartFile.fromBytes(
        'image_file',
        imageBytes,
        filename: 'image.jpg', // Default filename, adjust as needed
      ));
    } else if (imageFile != null) {
      request.files
          .add(await http.MultipartFile.fromPath('image_file', imageFile.path));
    }

    // Handle audio file
    if (kIsWeb && audioBytes != null) {
      request.files.add(http.MultipartFile.fromBytes(
        'audio_file',
        audioBytes,
        filename: 'audio.mp3', // Default filename, adjust as needed
      ));
    } else if (audioFile != null) {
      request.files
          .add(await http.MultipartFile.fromPath('audio_file', audioFile.path));
    }

    try {
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        print(
            'Failed to create audio podcast. Status code: ${response.statusCode}, Response: $responseBody');
        return false;
      }
    } catch (e) {
      print('Error creating audio podcast: $e');
      return false;
    }
  }

  Future<bool> createTestimony({
    required int user,
    required String title,
    required String description,
    required bool verifiedStatus,
    required String datetime,
    required String createdBy,
  }) async {
    final url = Uri.parse("${baseUrl}testimonials/");
    final payload = {
      "user": user,
      "title": title,
      "description": description,
      "verified_status": verifiedStatus,
      "datetime": datetime,
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
            'Failed to create testimony. Status code: ${response.statusCode}, Response: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error creating testimony: $e');
      return false;
    }
  }
}
