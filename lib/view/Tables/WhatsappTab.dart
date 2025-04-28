import 'package:church_admin/Widgets/TitleRow.dart';
import 'package:church_admin/view/Tables/TableForms/WhatsAppForms.dart';
import 'package:flutter/material.dart';

import '../../Widgets/AddProductListWidget.dart';
import '../../Widgets/TableWidget.dart';
import '../Header/DashBoardHeader.dart';

class Whatsappui extends StatefulWidget {

  final List<Map<String, dynamic>>? testData;
  final String? name;
  const Whatsappui({super.key,  this.testData,  this.name});

  @override
  State<Whatsappui> createState() => _WhatsappuiState();
}

class _WhatsappuiState extends State<Whatsappui> {
  bool isChange=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F7FB),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          DashboardHeader(),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  isChange?
                  TitleRow(title: widget.name ?? '',
                      onPressed: (){
                        setState(() {
                          isChange = false;
                        });
                      }
                  )
                      :AddProductTittleBar(
                    titleName: widget.name ?? '',
                    onPressed: () {
                      setState(() {
                        isChange = true;
                        debugPrint('Value $isChange');
                      });
                      debugPrint('Value $isChange');
                    },
                  ),
                  const SizedBox(height: 30),
                  Flexible(
                    child: isChange
                        ? WhatsAppForms()
                        : TableWidget(
                      testData: widget.testData ?? [],
                      name: widget.name ?? '',
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
