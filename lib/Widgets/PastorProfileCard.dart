import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../CustomColors.dart';
import '../model/PasterProfile.dart';
import 'SocialIcon.dart';

//  Profile Card Widget
class PastorProfileCard extends StatelessWidget {
  final UserProfile user;

  const PastorProfileCard({super.key, required this.user});

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
            user.name,
            style: GoogleFonts.manrope(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            user.job ?? 'no data',
            style: GoogleFonts.manrope(
              fontSize: 12,
              color: const Color(0xff6b7280),
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
          const Divider(height: 1, color: Colors.grey),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: const BoxDecoration(
              color: Color(0xffeff4fa),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: socialIcons.map((icon) => SocialIcon(icon: icon)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
