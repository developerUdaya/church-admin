import 'package:church_admin/Service/ApiHandler/EngagementApiHandler.dart';
import 'package:church_admin/Widgets/TableWidget.dart';
import 'package:church_admin/Widgets/TitleRow.dart';
import 'package:church_admin/view/Tables/TableForms/BlogForms.dart';
import 'package:flutter/material.dart';
import '../../Widgets/AddProductListWidget.dart';
import '../Header/DashBoardHeader.dart';

class BlogTable extends StatefulWidget {
  final String? name;
  const BlogTable({super.key, this.name});

  @override
  State<BlogTable> createState() => _BlogTableState();
}

class _BlogTableState extends State<BlogTable> {
  bool isChange = false;
  late Future<List<Map<String, dynamic>>> futureBlogData;
  @override
  void initState() {
    super.initState();
    futureBlogData = fetchEngagementBlogDataFromApi();
  }

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
                  SizedBox(height: isChange ? 20 : 30),
                  Flexible(
                    child: isChange
                        ? BlogForms()
                        : FutureBuilder<List<Map<String, dynamic>>>(
                            future: futureBlogData,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                return TableWidget(
                                  testData: snapshot.data!,
                                  name: widget.name ?? '',
                                );
                              }
                            }),
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
