import 'package:church_admin/Service/UserServices.dart';
import 'package:church_admin/Widgets/TitleRow.dart';
import 'package:church_admin/view/Tables/TableForms/UserFormCreation.dart';
import 'package:flutter/material.dart';
import '../../Widgets/AddProductListWidget.dart';
import '../../Widgets/TableWidget.dart';
import '../Header/DashBoardHeader.dart';

class userList_table extends StatefulWidget {
  List<Map<String, dynamic>>? testData;
  String? name;

  userList_table({super.key,  this.testData,  this.name});

  @override
  State<userList_table> createState() => _userList_tableState();
}

class _userList_tableState extends State<userList_table> {
  bool isChange = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final fetchedData = await UserServices.fetchUserDetails();
      setState(() {
        widget.testData = fetchedData;
      });
    });
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
                          title: widget.name ?? 'Default Title',
                          onPressed: () {
                            setState(() {
                              isChange = false;
                            });
                          },
                          // withSized: 0.69,
                        )
                      : AddProductTittleBar(
                          titleName: widget.name ?? '',
                          onPressed: () {
                            setState(() {
                              isChange = true;
                            });
                          },
                        ),
                  SizedBox(height: isChange ? 20 : 30),
                  Flexible(
                    child: isChange
                        ? UserFormCreation(
                            onPressed: () {
                              setState(() {
                                isChange = false;
                              });
                            },
                          )
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

/*Column(
       /* crossAxisAlignment: CrossAxisAlignment.stretch,*/ // Ensures width consistency
          children: [
    Expanded(
    child: Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
    // Sidebar

    // Table Section
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DashboardHeader(),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: AddProductTittleBar(titleName:widget.name),
            ),

            const SizedBox(height: 40),
            Expanded(
              child: Center(
                child: SizedBox(
                  width: 950,
                  height: 500,
                  child: TableWidget(testData: widget.testData, name: widget.name),
                ),
              ),
            ),
          ],
        ),*/
