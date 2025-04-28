import 'package:church_admin/view/DashBoard.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'CustomForms/CustomFormsUI.dart';
import 'CustomForms/UserFormsUI.dart';

import 'Tables/PastorsProfileGrid.dart';
import 'Tables/TableForms/DepartmentFromCreation.dart';
import 'Tables/TableForms/PastorsPopForm.dart';
import 'ToastPageUI.dart';

class IkiaAdminPanel extends StatefulWidget {
  const IkiaAdminPanel({super.key});

  @override
  State<IkiaAdminPanel> createState() => _IkiaAdminPanelState();
}

class _IkiaAdminPanelState extends State<IkiaAdminPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F7FC),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
         
            Expanded(
                child: Dashboard()
                )
          ],
        ),
    );
  }
}


/*SizedBox(
              width: 300,
              height: 50,
              child:  DropdownWidget(
                  items: ['Add', 'Edit', 'Delete'],
                  onChanged: (value) {
                    print("Selected value: $value");
                  },
              ),
            ),
            SizedBox(
                width: 300,
                height: 250,
                child: ProductStatusUi(titleName: 'Status', subtitle: 'Tax Class *', desceription: 'Set the product status',))

            //Expanded(child: ProductlistUi()),
          //Expanded(child: SidebarUi())
          // Expanded(child: UserList(num: 5,))
             */
/*SizedBox(
               width: 300,
               height: 50,
               child: Row(
                 mainAxisAlignment:MainAxisAlignment.end,
                 children: [
                   OptionButton()
                 ],
               ),
             )*//*
        */
/*          SizedBox(
              width: 500,
              height: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('MemberShip Report',style: TextStyle(fontSize: 14,color: Colors.black),),
                  GradientLineChart(
                    dataPoints: [
                      FlSpot(0, 5),
                      FlSpot(1, 10),
                      FlSpot(2, 25),
                      FlSpot(3, 35),
                      FlSpot(4, 20),
                      FlSpot(5, 30),
                      FlSpot(6, 15),
                      FlSpot(7, 25),
                      FlSpot(8, 10),
                      FlSpot(9, 20),
                    ],
                    gradientColors: [Colors.blue, Colors.purple],
                  ),
                ],
              ))*/
/*

           Expanded(child: AddProductTittleBar(titleName: 'Add Product',)),
            //SizedBox(child: AddproductphotoWidget())
            //SizedBox(child: AddproductphotoWidget(titleName: 'Media',outerwidth: 0.50,outerheigth: 0.50,innerheigth: 0.30,innerwidth: 0.4,),),*/