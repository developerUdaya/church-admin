import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Widgets/CheckBoxe.dart';
import '../../../Widgets/CustomButtons.dart';
import '../../../Widgets/DropDown.dart';
import '../../../Widgets/TextFieldForms.dart';
import '../../../Widgets/TitleRow.dart';

class WhatsAppForms extends StatefulWidget {
  const WhatsAppForms({super.key});

  @override
  State<WhatsAppForms> createState() => _WhatsAppFormsState();
}

class _WhatsAppFormsState extends State<WhatsAppForms> {
  String Status = 'Select Blood Group';
  String Status1 = 'Select Gender';

  final List<bool> boxChecker = List.generate(5, (index) => false);
  void onChangedCheckBox(bool value, int index) {
    setState(() {
      boxChecker[index] = value;
    });
  }

  final List<bool> boxChecker1 = List.generate(5, (index) => false);
  void onChangedCheckBox1(bool value, int index) {
    setState(() {
      boxChecker1[index] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      margin: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xfff4f7fc),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Merged Form UI
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section Header
                  _buildSectionHeader('WhatsApp Message'),
                  const Divider(thickness: 1, color: Color(0xFFE4E6E8)),
                  const SizedBox(height: 15),

                  // ✅ First Row: Checkboxes (Full Width)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CheckBoxes(
                      checker: boxChecker,
                      text: ["Users", "Members", "Student", "Department",'Church Staff'],
                      onChangedCheckBox: onChangedCheckBox,
                    ),
                  ),

                  const SizedBox(height: 15),

                  // ✅ Second Row: Checkboxes + Dropdown
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center, // Ensures alignment
                    children: [
                      Expanded(
                        flex: 3, // Gives more space for checkboxes
                        child: CheckBoxes(
                          checker: boxChecker1,
                          text: ["Pastors", "Committee", "Chorus",'Married','Single'],
                          onChangedCheckBox: onChangedCheckBox1,
                          name: '   ',
                        ),
                      ),

                      // Responsive Space Between Items
                      SizedBox(width: MediaQuery.of(context).size.width * 0.04),

                      Expanded(
                        child: DropdownSelector(
                          title: 'Blood Group',
                          value: Status,
                          onChanged: (newValue) {
                            setState(() {
                              Status = newValue!;
                            });
                          },
                          ItemList: ["Select Blood Group","AB+", "AB-", 'A+', "A-", 'O+', 'O-'],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),

                  Row(
                    children: [
                      Expanded(
                        child: DropdownSelector(
                          title: 'Gender',
                          value: Status1,
                          onChanged: (newValue) {
                            setState(() {
                              Status1 = newValue!;
                            });
                          },
                          ItemList: ['Select Gender',"Male", "Female", 'Transgender'],
                        ),
                      ),
                      const SizedBox(width: 15),
                      // Amount Field (Expanded to take available space)
                      Expanded(
                        flex: 1, // Adjust flex values if needed
                        child: Textfieldforms(
                          title: 'Pin Code',
                          hint: 'Enter pin code',
                          isBlocked: false,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: CustomButton(
                      text: "Apply",
                      color: Colors.blue,
                      textColor: Colors.white,
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(height: 15),
                  // ✅ Third Row: Remarks & Button
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Textfieldforms(
                        title: 'Message *',
                        hint: 'Enter Message',
                        isBlocked: false,
                        isMultiline: true,
                      ),
                      const SizedBox(height: 15), // Space between fields

                      Align(
                        alignment: Alignment.bottomRight,
                        child: CustomButton(
                          text: "Send",
                          color: Colors.blue,
                          textColor: Colors.white,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  // Section Header Styling
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: GoogleFonts.manrope(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }
}
