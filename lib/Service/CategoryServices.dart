import 'dart:convert';
import 'package:http/http.dart' as http;

class CategoryServices {
  Future<void> fetchAllCategory() async {
    String url = "http://147.93.97.78:5060/api/categories/";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var categoryData = jsonDecode(response.body);
        return categoryData;
      } else {
        print("Error fetching Category. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("error happing at fetch all category");
    }
  }

  Future<void> fetchCategoryByID(int id) async {
    String url = "http://147.93.97.78:5060/api/categories/$id/";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var categoryData = jsonDecode(response.body);
        return categoryData;
      } else {
        print("Error fetching Category. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("error happing at fetch category by ID");
    }
  }
}
