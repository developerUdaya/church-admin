import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductServices {
  Future<void> fetchAllProduct() async {
    String url = "http://147.93.97.78:5060/api/products/";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        print("Product fetched successfully");
        var productData = jsonDecode(response.body);
        print(productData);
      } else {
        print("error ${response.statusCode}");
      }
    } catch (e) {
      print("error at fetching all product $e");
    }
  }

  Future<void> fetchProductById(int id) async {
    String url = "http://147.93.97.78:5060/api/products/$id/";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        print("Product fetched by id successfully");
        var productData = jsonDecode(response.body);
        print(productData);
      } else {
        print("error ${response.statusCode}");
      }
    } catch (e) {
      print("error at fetching product by id $e");
    }
  }
}
