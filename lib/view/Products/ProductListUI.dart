import 'package:church_admin/Service/ApiHandler/EcommerceApiHandler.dart';
import 'package:church_admin/model/ProductModel.dart';
import 'package:flutter/material.dart';

import '../../CustomColors.dart';
import '../../Widgets/Productitem_Widget.dart';

class ProductlistUi extends StatefulWidget {
  const ProductlistUi({super.key});

  @override
  State<ProductlistUi> createState() => _ProductlistUiState();
}

class _ProductlistUiState extends State<ProductlistUi> {
  late Future<List<ProductModel>> futureProductData;

  @override
  void initState() {
    super.initState();
    futureProductData = fetchEcommerceProductDatasFromApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<ProductModel>>(
          future: futureProductData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No products available'));
            } else {
              final productList = snapshot.data!;
              return GridView.builder(
                scrollDirection: Axis.vertical,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 25,
                  childAspectRatio: 1 / 1.1,
                ),
                itemCount: productList.length,
                itemBuilder: (context, index) {
                  final product = productList[index];
                  return ProductItemWidget(
                    productName: product.name,
                    price: double.parse(product.price),
                    originalPrice: double.parse(product.price) + 100,
                    rating: 4,
                    images: product.imageUrls[0],
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
