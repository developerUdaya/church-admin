import 'dart:convert';
import 'package:http/http.dart' as http;

class Ecommerceservices {
  Future<dynamic> fetchAllProduct() async {
    String url = "http://147.93.97.78:5030/api/products/";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var productData = jsonDecode(response.body);
        return productData;
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
        var productData = jsonDecode(response.body);
        return productData;
      } else {
        print("error ${response.statusCode}");
      }
    } catch (e) {
      print("error at fetching product by id $e");
    }
  }

  Future<void> fetchOrderByOrderId(int id) async {
    String url = "http://147.93.97.78:5060/orders/$id/";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var OrderData = jsonDecode(response.body);
        print(OrderData);
      } else {
        print(
            "Error fetching Order by Order ID. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("error at fetch order by order id $e");
    }
  }

  Future<void> fetchOrderByUser(int id) async {
    String url = "http://147.93.97.78:5060/orders/user/$id/";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var OrderDataByUser = jsonDecode(response.body);
        print(OrderDataByUser);
      } else {
        print(
            "Error fetching Order by User. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("error at fetch order by order id $e");
    }
  }
}
