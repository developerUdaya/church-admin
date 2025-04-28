import 'dart:convert';

import 'package:http/http.dart' as http;

class Pastorsservice {
  Future<dynamic> fetchChurchToolsSpeechData() async {
    String baseUrl = "http://147.93.97.78:5030/";

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
}
