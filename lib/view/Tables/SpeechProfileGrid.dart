import 'package:church_admin/Service/ApiHandler/ChurchToolsApiHandler.dart';
import 'package:church_admin/Service/ChurchToolsServices.dart';
import 'package:church_admin/Widgets/TitleRow.dart';
import 'package:church_admin/model/SpeechModel.dart';
import 'package:church_admin/view/Header/DashBoardHeader.dart';
import 'package:church_admin/view/Tables/TableForms/SpeechForms.dart';
import 'package:flutter/material.dart';
import '../../CustomColors.dart';
import '../../Widgets/AddProductListWidget.dart';
import '../../Widgets/OptionButton.dart';
import '../../Widgets/SpeechProfileCard.dart';

class SpeechProfileGrid extends StatefulWidget {
  final String? name;
  const SpeechProfileGrid({super.key,  this.name});

  @override
  State<SpeechProfileGrid> createState() => _SpeechProfileGridState();
}

class _SpeechProfileGridState extends State<SpeechProfileGrid> {
  late Future<List<SpeechModel>> futureSpeechData;

  @override
  void initState() {
    super.initState();
    futureSpeechData = fetchChurchToolsSpeechDataFromApi();
  }

  @override
  Widget build(BuildContext context) {
    bool isChange = false;
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DashboardHeader(),
            const SizedBox(height: 20),
            FutureBuilder<List<SpeechModel>>(
              future: futureSpeechData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("No data available"));
                }

                List<SpeechModel> speechList = snapshot.data!;

                return Column(
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
                            },
                          ),
                    const SizedBox(height: 20),
                    isChange
                        ? SpeechForms()
                        : Padding(
                            padding: const EdgeInsets.all(100),
                            child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: speechList.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                crossAxisSpacing: 68,
                                mainAxisSpacing: 40,
                                mainAxisExtent: 250,
                              ),
                              itemBuilder: (context, index) {
                                return Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(24),
                                        child: SpeechProfileCard(speechModel: speechList[index] , user: speech[index],),
                                      ),
                                    ),
                                    Positioned(
                                      top: 20,
                                      right: 20,
                                      child: OptionButton(
                                        menuItems: actionButtons,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}


