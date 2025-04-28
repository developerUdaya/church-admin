import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Financeservice {
  String baseUrl = "http://147.93.97.78:5030/";
  Future<List<Map<String, dynamic>>> fetchFinanceFundManagementData() async {
    List<Map<String, dynamic>> responseDataTable = [];

    try {
      final response = await http.get(Uri.parse("${baseUrl}fund-management/"));
      if (response.statusCode == 200) {
        
        final List<dynamic> data = jsonDecode(response.body);
        responseDataTable = data.map((data) {
          return {
            "No": data['id'],
            "Amount": data['amount'],
            "Verifier": data['verifier'] ?? 'No Subject',
            "Source": data['source'],
            "Record Type": data['record_type'],
            "Document": data['remarks'],
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
          "Amount",
          'Verifier',
          'Source',
          "Record Type",
          "Document",
          "Action"
        ],
        "dataType": [
          "Text",
          "Text",
          'Text',
          'Text',
          "Record Type",
          "Text",
          "Action"
        ],
        "data": responseDataTable
      }
    ];
  }

  Future<bool> createFundRecord({
    required String date,
    required String amount,
    required String recordType,
    required String verifier,
    required String source,
    required String remarks,
    required String createdBy,
  }) async {
    final url = Uri.parse("${baseUrl}fund-management/");
    final payload = {
      "date": date,
      "amount": amount,
      "record_type":
          recordType.toLowerCase(), // Ensure consistency (expense/receivable)
      "verifier": verifier,
      "source": source,
      "remarks": remarks,
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
            'Failed to create fund record. Status code: ${response.statusCode}, Response: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error creating fund record: $e');
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> fetchFinanceDonationsData() async {
    List<Map<String, dynamic>> responseDataTable = [];

    try {
      final response = await http.get(Uri.parse("${baseUrl}donations/"));
      if (response.statusCode == 200) {
        
        final List<dynamic> data = jsonDecode(response.body);
        responseDataTable = data.map((data) {
          return {
            "No": data['id'],
            "Date": data['date'].toString().split('T').last.split('.').first,
            "Amount": data['amount'],
            "Source": data['source'],
            "Cheque/Bank": data['payment_method'],
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
        "header": ["No", "Date", "Amount", 'Source', "Cheque/Bank", "Action"],
        "dataType": ["Text", "Date", 'Text', 'Text', "Status", "Action"],
        "data": responseDataTable
      }
    ];
  }

  Future<bool> createDonation({
    required String via,
    required String paymentMethod,
    required String verifier,
    required String description,
    required String date,
    required String amount,
    required String source,
    required String createdBy,
  }) async {
    final url = Uri.parse("${baseUrl}donations/");
    final payload = {
      "via": via,
      "payment_method": paymentMethod.toLowerCase(), // Ensure consistency
      "verifier": verifier,
      "description": description,
      "date": date,
      "amount": amount,
      "source": source,
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
            'Failed to create donation. Status code: ${response.statusCode}, Response: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error creating donation: $e');
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> fetchFinanceAssetManagementData() async {
    List<Map<String, dynamic>> responseDataTable = [];

    try {
      final response = await http.get(Uri.parse("${baseUrl}assets/"));
      if (response.statusCode == 200) {
        
        final List<dynamic> data = jsonDecode(response.body);
        responseDataTable = data.map((data) {
          return {
            "No": data['id'],
            "Date": data['date'].toString().split('T').last.split('.').first,
            "Amc Date": data['amc_date'],
            "Assets": data['asset_name'],
            "Approximate Value": data['approximate_value'],
            "Note": data['description'],
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
          "Date",
          "Amc Date",
          'Assets',
          "Approximate Value",
          "Note",
          "Action"
        ],
        "dataType": ["Text", "Date", 'Date', 'Text', 'Text', "Text", "Action"],
        "data": responseDataTable
      }
    ];
  }

  Future<bool> createAsset({
    required String assetName,
    required String approximateValue,
    required String verifier,
    required String description,
    required String date,
    required String location,
    required String quantity,
    required String createdBy,
    required String amcDate,
    File? imageFile, // For mobile/desktop
    Uint8List? imageBytes, // For web
    String? insuranceDate, // Optional
  }) async {
    final url = Uri.parse("${baseUrl}assets/");
    var request = http.MultipartRequest('POST', url);

    // Add form fields
    request.fields['asset_name'] = assetName;
    request.fields['approximate_value'] = approximateValue;
    request.fields['verifier'] = verifier;
    request.fields['description'] = description;
    request.fields['date'] = date;
    request.fields['location'] = location;
    request.fields['quantity'] = quantity;
    request.fields['created_by'] = createdBy;
    request.fields['amc_date'] = amcDate;
    if (insuranceDate != null) {
      request.fields['insurance_date'] = insuranceDate;
    }

    // Handle image file
    if (kIsWeb && imageBytes != null) {
      request.files.add(http.MultipartFile.fromBytes(
        'image_url', // Field name expected by the API
        imageBytes,
        filename: 'asset_image.jpg', // Default filename, adjust as needed
      ));
    } else if (imageFile != null) {
      request.files
          .add(await http.MultipartFile.fromPath('image_url', imageFile.path));
    }

    try {
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        print(
            'Failed to create asset. Status code: ${response.statusCode}, Response: $responseBody');
        return false;
      }
    } catch (e) {
      print('Error creating asset: $e');
      return false;
    }
  }
}
