import 'package:church_admin/Widgets/AddProductListWidget.dart';
import 'package:church_admin/view/Tables/TableForms/ProductFromCreation.dart';
import 'package:flutter/material.dart';
import '../../Widgets/ProductSidebarUi.dart';
import '../../Widgets/Productitem_Widget.dart';
import '../../Widgets/TitleRow.dart';
import '../Header/DashBoardHeader.dart';
import '../Products/ProductListUI.dart';

class Products_table extends StatefulWidget {
  final List<Map<String, dynamic>>? testData;
  final String? name;

  const Products_table({super.key, this.testData, this.name});

  @override
  State<Products_table> createState() => _Products_tableState();
}

class _Products_tableState extends State<Products_table> {
  bool isChange = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      body: Column(
        children: [
          DashboardHeader(),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  isChange
                      ? TitleRow(
                          title: widget.name ?? '',
                          onPressed: () {
                            setState(() {
                              isChange = false;
                            });
                          },
                        )
                      : AddProductTittleBar(
                          titleName: widget.name ?? '',
                          onPressed: () {
                            setState(() {
                              isChange = true;
                            });
                          }),
                  const SizedBox(height: 30),
                  isChange
                      ? ProductFromCreation()
                      : Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                // Sidebar
                                SizedBox(
                                  width: 250,
                                  child: shop_sidebar(),
                                ),

                                // Vertical Divider
                                Container(
                                  width: 1.5,
                                  color: const Color(0xFFEEF2F5),
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 12),
                                ),
                                // Main Content
                                Expanded(
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 10),
                                      //Search Bar
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: ProductSearch(
                                            name: widget.name ?? ''),
                                      ),
                                      const SizedBox(height: 10),
                                      //Product List
                                      Expanded(
                                        child: ProductlistUi(),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
