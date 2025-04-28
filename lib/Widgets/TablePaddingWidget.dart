import 'package:flutter/material.dart';

class Table_layout extends StatelessWidget {
  final String name;
  final Widget widget;

  Table_layout({
    super.key, required this.name, required this.widget,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Text
              Text(
                name,
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16.0),
              Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                      style: BorderStyle.solid,
                    ),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: widget,
                ),
            ],
          ),
        ),
      ),
    );
  }
}