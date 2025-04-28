
import 'package:church_admin/Widgets/CustomButtons.dart';
import 'package:church_admin/Widgets/DropDown.dart';
import 'package:church_admin/Widgets/ProfileCard.dart';
import 'package:church_admin/Widgets/TitleRow.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';




class ChurchStaffPopForm extends StatefulWidget {

  const ChurchStaffPopForm({super.key});

  @override
  State<ChurchStaffPopForm> createState() => _ChurchStaffPopFormState();
}

class _ChurchStaffPopFormState extends State<ChurchStaffPopForm> {
  String selectedMemberId = 'KIAI0001';
  String selectedMemberName = 'Mark';
  bool isProfileVisible = false;
  @override
  Widget build(BuildContext context) {
    return  Container(
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
              title: 'Add ChurchStaff',
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
                          'ADD CHURCH STAFF',
                          style: GoogleFonts.manrope(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.black54),
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                        ),
                      ],
                    ),
                    Divider(),
                    const SizedBox(height: 20),

                    // Input Fields
                    Row(
                      children: [
                        Expanded(
                          child: DropdownSelector(
                            title: 'Member ID *',
                            value: selectedMemberId,
                            onChanged: (newValue) {
                              setState(() {
                                selectedMemberId = newValue!;
                              });
                            },
                            ItemList: const ["KIAI0001", "KIAI0098", "KIAI0087", "KIAI0045", "KIAI0023"],
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: DropdownSelector(
                            title: 'Member Name *',
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
                              isProfileVisible = true; // Show ProfileCard
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
                              isProfileVisible = false; // Hide ProfileCard
                              selectedMemberId = 'KIAI0001';
                              selectedMemberName = 'Mark';
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Show Profile Card only after "Search"
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


/* void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
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
                      'ADD CHURCH STAFF',
                      style: GoogleFonts.manrope(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.black54),
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Input Fields
                Row(
                  children: [
                    Expanded(
                      child: DropdownSelector(
                        title: 'Member ID *',
                        value: selectedMemberId,
                        onChanged: (newValue) {
                          setState(() {
                            selectedMemberId = newValue!;
                          });
                        },
                        itmeList: const ["KIAI0001", "KIAI0098", "KIAI0087", "KIAI0045", "KIAI0023"],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: DropdownSelector(
                        title: 'Member Name *',
                        value: selectedMemberName,
                        onChanged: (newValue) {
                          setState(() {
                            selectedMemberName = newValue!;
                          });
                        },
                        itmeList: const ["Devid", "john", "Mark", 'Sam'],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Buttons (Search & Clear)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                      text: "Search",
                      color: Colors.blue,
                      textColor: Colors.white,
                      onPressed: () {
                        // Implement Search Logic
                      },
                    ),
                    const SizedBox(width: 10),
                    CustomButton(
                      text: "Clear",
                      color: Colors.red,
                      textColor: Colors.white,
                      onPressed: () {
                        // Clear fields
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Profile Card (After Search)
                ProfileCard(),
              ],
            ),
          ),
        );
      },
    );
  }*/


}