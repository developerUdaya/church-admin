import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Widgets/Calendar.dart';
import '../../Widgets/CustomButtons.dart';
import '../../Widgets/DropDown.dart';
import '../../Widgets/TextFieldForms.dart';
import '../../Widgets/TitleRow.dart';

class UserCreationForm extends StatefulWidget {
  const UserCreationForm({super.key});

  @override
  State<UserCreationForm> createState() => _UserCreationFormState();
}

class _UserCreationFormState extends State<UserCreationForm> {
  String maritalStatus = 'Single';
  String profession = 'Engineer';
  String selectedGender = "Male";
  bool switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 30),
      margin: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xfff4f7fc),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Row
            TitleRow(title: 'User Creation Form'),
            const SizedBox(height: 30),
            // Main Form Container
            Container(
              width: MediaQuery.of(context).size.width * 0.80,
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
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Personal Details Section
                    _buildSectionHeader('Personal Details'),
                    Textfieldforms(
                      title: 'Full Name',
                      hint: 'Enter your full name',
                      isBlocked: false,
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: Textfieldforms(
                            title: 'Gender',
                            hint: 'Enter gender',
                            isBlocked: false,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Textfieldforms(
                            title: 'Blood Group',
                            hint: 'Enter blood group',
                            isBlocked: false,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    CalendarApp(onDateSelected: (DateTime ) {  }, defaultDate: DateTime.now(),title: '',),
                    const SizedBox(height: 20),

                    // Marital Information Section
                    _buildSectionHeader('Marital Information'),
                    DropdownSelector(
                      title: 'Marital Status',
                      value: maritalStatus,
                      onChanged: (newValue) {
                        setState(() {
                          // maritalStatus = newValue!;
                        });
                      },  ItemList: ["Single","Married","Divorced"],
                    ),
                    const SizedBox(height: 20),

                    // Professional Details Section
                    _buildSectionHeader('Professional Details'),
                    Textfieldforms(
                      title: 'Profession',
                      hint: 'Enter profession',
                      isBlocked: false,
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: Textfieldforms(
                            title: 'Qualifications',
                            hint: 'Enter qualifications',
                            isBlocked: false,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Textfieldforms(
                            title: 'Company Name',
                            hint: 'Enter company name',
                            isBlocked: false,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Contact Details Section
                    _buildSectionHeader('Contact Details'),
                    Textfieldforms(
                      title: 'Phone',
                      hint: 'Enter phone number',
                      isBlocked: false,
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: Textfieldforms(
                            title: 'Alternative Phone',
                            hint: 'Enter alternative phone',
                            isBlocked: false,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Textfieldforms(
                            title: 'Email',
                            hint: 'Enter email',
                            isBlocked: false,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Textfieldforms(
                      title: 'Alternative Email',
                      hint: 'Enter alternative email',
                      isBlocked: false,
                    ),
                    const SizedBox(height: 20),

                    // Address Details Section
                    _buildSectionHeader('Address Details'),
                    Textfieldforms(
                      title: 'House Type',
                      hint: 'Owned/Rented',
                      isBlocked: false,
                    ),
                    const SizedBox(height: 15),
                    Textfieldforms(
                      title: 'Full Address',
                      hint: 'Enter full address',
                      isBlocked: false,
                      isMultiline: true,

                    ),
                    const SizedBox(height: 15),
                    Textfieldforms(
                      title: 'Communication Address',
                      hint: 'Enter communication address',
                      isBlocked: false,
                      isMultiline: true,
                    ),
                    const SizedBox(height: 30),

                    // Submit and Reset Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomButton(
                          text: "Submit",
                          color: Colors.blue,
                          textColor: Colors.white,
                          onPressed: () {},
                        ),
                        CustomButton(
                          text: "Reset",
                          color: Colors.grey,
                          textColor: Colors.white,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to create section headers
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