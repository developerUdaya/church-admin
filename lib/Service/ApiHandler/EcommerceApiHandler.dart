import 'package:church_admin/Service/EcommerceServices.dart';
import 'package:church_admin/model/ProductModel.dart';

Future<List<ProductModel>> fetchEcommerceProductDatasFromApi() async {
  try {
    final productData = await Ecommerceservices().fetchAllProduct();
    if (productData != null && productData is List) {
      print("Data returned successfully");
      return productData.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      print("Data returned Failed!");
    }
  } catch (e) {
    print("Error while Fetching the data from Api in Api handler file : $e");
  }
  return [];
}
