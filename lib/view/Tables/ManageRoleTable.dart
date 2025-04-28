import 'package:flutter/material.dart';

import '../../Widgets/AddProductListWidget.dart';
import '../../Widgets/FormsWidget.dart';
import '../Header/DashBoardHeader.dart';

class ManageRoleTable extends StatefulWidget {
  final Map<String, dynamic>? mainTableData;
  final String? name;


  const ManageRoleTable({super.key,  this.mainTableData,  this.name});

  @override
  State<ManageRoleTable> createState() => _ManageRoleTableState();
}

class _ManageRoleTableState extends State<ManageRoleTable> {
  String? selectedShop;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          DashboardHeader(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AddProductTittleBar(titleName: widget.name ?? ''),
                  const SizedBox(height: 30),
                  Flexible(
                    child:FromDropDownWidget(
                    listValue: widget.mainTableData ?? {},
                    onShopSelected: (String? value) {
                      setState(() {
                        selectedShop = value;
                      });
                    },
                    name: widget.name ?? '',
                  ),),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
