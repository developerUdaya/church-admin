import 'package:church_admin/Widgets/BlogWidget.dart';
import 'package:flutter/material.dart';

import '../Header/DashBoardHeader.dart';

class NewsLetterTab extends StatelessWidget {
  const NewsLetterTab({super.key});

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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Blogwidget(name: 'News Letter',),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
