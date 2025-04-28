import 'package:church_admin/model/SpeechModel.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../model/PasterProfile.dart';

class SpeechProfileCard extends StatelessWidget {
  final SpeechModel speechModel;
  final UserProfile user;

  const SpeechProfileCard({super.key, required this.user , required this.speechModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 2),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage(user.imagePath),
          ),
          const SizedBox(height: 10),
          Text(
            speechModel.speech,
            style: GoogleFonts.manrope(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            user.phone,
            style: GoogleFonts.manrope(
              fontSize: 14,
              color: const Color(0xff6b7280),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            DateFormat('yyyy-MM-dd – kk:mm').format(speechModel.datetime),
            style: GoogleFonts.manrope(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 30, width: 30,),
          const Divider(height: 1, color: Colors.grey),
        ],
      ),
    );
  }
}
