import 'package:church_admin/Widgets/DropdownWidget.dart';
import 'package:flutter/material.dart';

class ProductStatusUi extends StatelessWidget {
  final String titleName;
  final String subtitle;
  final String desceription;
  final double outerwidth;
  final double outerheigth;
  final double innerwidth;
  final double innerheigth;

  const ProductStatusUi({
    super.key,
    this.outerwidth =  0.40,
    this.outerheigth = 0.40,
    this.innerwidth = 0.3,
    this.innerheigth = 0.20,
    required this.titleName,
    required this.subtitle,
    required this.desceription
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(16.0),
      child: Container(
        width: MediaQuery.of(context).size.width * outerwidth,
        height:  MediaQuery.of(context).size.height * outerheigth,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        padding:  EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titleName,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF313948),
              ),
            ),
            SizedBox(height: 16),
           SizedBox(
                width: MediaQuery.of(context).size.width * innerwidth,
                height: MediaQuery.of(context).size.height *innerheigth,
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF313948),
                      ),
                    ),
                    SizedBox(height: 8),
                    DropdownWidget(items: ['Add', 'Edit', 'Delete'],),
                    SizedBox(height: 8),
                    Text(
                      desceription,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                )
              ),
          ],
        ),
      ),
    );
  }
}
