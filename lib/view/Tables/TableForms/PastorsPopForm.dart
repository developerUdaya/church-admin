import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Widgets/CustomButtons.dart';
import '../../../Widgets/DropDown.dart';
import '../../../Widgets/ProfileCard.dart';
import '../../../Widgets/TitleRow.dart';

class PastorsPopForm extends StatefulWidget {
  const PastorsPopForm({super.key});

  @override
  State<PastorsPopForm> createState() => _PastorsPopFormState();
}

class _PastorsPopFormState extends State<PastorsPopForm> {
  String selectedMemberId = 'KIAI0001';
  String selectedMemberName = 'Mark';
  bool isProfileVisible = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      margin: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xfff4f7fc),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleRow(
              title: 'Add Pastors',
              onPressed: () {
                _showPopup(context);
              },
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.60,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 4,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title Row with Close Icon
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'ADD PASTORS',
                          style: GoogleFonts.manrope(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.black54),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                    Divider(),
                    const SizedBox(height: 20),

                    Row(
                      children: [
                        Expanded(
                          child: DropdownSelector(
                            title: 'Pastor\'s ID *',
                            value: selectedMemberId,
                            onChanged: (newValue) {
                              setState(() {
                                selectedMemberId = newValue!;
                              });
                            },
                            ItemList: const [
                              "KIAI0001",
                              "KIAI0098",
                              "KIAI0087",
                              "KIAI0045",
                              "KIAI0023"
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: DropdownSelector(
                            title: 'Pastor\'s Name *',
                            value: selectedMemberName,
                            onChanged: (newValue) {
                              setState(() {
                                selectedMemberName = newValue!;
                              });
                            },
                            ItemList: const ["Devid", "john", "Mark", 'Sam'],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Buttons (Search & Clear)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButton(
                          text: "Search",
                          color: Colors.blue,
                          textColor: Colors.white,
                          onPressed: () {
                            setState(() {
                              isProfileVisible = true;
                            });
                          },
                        ),
                        const SizedBox(width: 10),
                        CustomButton(
                          text: "Clear",
                          color: Colors.red,
                          textColor: Colors.white,
                          onPressed: () {
                            setState(() {
                              isProfileVisible = false;
                              selectedMemberId = 'KIAI0001';
                              selectedMemberName = 'Mark';
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    if (isProfileVisible)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ProfileCard(),
                        ],
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
