import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class ProductFormDetails extends StatelessWidget {
  const ProductFormDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(16.0),
        child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Product Name *",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  hintText: "Product Name",
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                "Description",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                padding:EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      padding:  EdgeInsets.all(8.0),
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          HugeIcon(
                            icon: HugeIcons.strokeRoundedTextBold,
                            color: Colors.black,
                            size: 19.0,
                          ),
                          HugeIcon(
                            icon: HugeIcons.strokeRoundedTextItalic,
                            color: Colors.black,
                            size: 19.0,
                          ),
                          HugeIcon(
                            icon: HugeIcons.strokeRoundedTextUnderline,
                            color: Colors.black,
                            size: 19.0,
                          ),
                          HugeIcon(
                            icon: HugeIcons.strokeRoundedHeading01,
                            color: Colors.black,
                            size: 19.0,
                          ),
                          HugeIcon(
                            icon: HugeIcons.strokeRoundedHeading02,
                            color: Colors.black,
                            size: 19.0,
                          ),HugeIcon(
                            icon: HugeIcons.strokeRoundedHeading03,
                            color: Colors.black,
                            size: 19.0,
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      padding:  EdgeInsets.all(8.0),
                      child: TextField(
                        maxLines: null,
                        expands: true,
                        decoration: InputDecoration(
                          hintText: "Start typing...",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text(
                "Output",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
      );
  }
}
