import 'package:church_admin/Widgets/CustomButtons.dart';
import 'package:church_admin/Widgets/TextFieldForms.dart';
import 'package:church_admin/Widgets/TitleRow.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FlockNamePopForm extends StatefulWidget {
  const FlockNamePopForm({super.key});

  @override
  State<FlockNamePopForm> createState() => _FlockNamePopFormState();
}

class _FlockNamePopFormState extends State<FlockNamePopForm> {
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
              title: 'AddFlocks',
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
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.2),
                  spreadRadius: 4,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            width: MediaQuery.of(context).size.width * 0.30,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeader('Add Flock'),
                Divider(),
                const SizedBox(height: 10),
                Textfieldforms(
                  title: 'Flock Name *',
                  hint: 'Enter Flock Name',
                  isBlocked: false,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      text: "Create",
                      color: Colors.green,
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(width: 10,),
                    CustomButton(
                      text: "Cancel",
                      color: Colors.red,
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
