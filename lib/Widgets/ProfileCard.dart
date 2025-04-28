import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hugeicons/hugeicons.dart';


 // SVG image icon code

/*class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/user.jpg'),
            ),
            const SizedBox(height: 10),
            Text(
              'Claudia Foster',
              style: GoogleFonts.manrope(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              'Chemist',
              style: GoogleFonts.manrope(
                fontSize: 12,
                color: Color(0xff6b7280),
              ),
            ),
            const SizedBox(height: 10),
            const Divider(height: 1, color: Colors.grey),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xffeff4fa),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _socialIcon('assets/facebook.svg'),
                  _socialIcon('assets/instagram.svg'),
                  _socialIcon('assets/github.svg'),
                  _socialIcon('assets/twitter.svg'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _socialIcon(String assetPath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SvgPicture.asset(assetPath, height: 14, width: 14),
    );
  }
}*/

 // HugeIcons icon code

class ProfileCard extends StatefulWidget {
  const ProfileCard({super.key});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/avatar3.png'),
            ),
            const SizedBox(height: 10),
            Text(
              'Mark',
              style: GoogleFonts.manrope(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              'Antony',
              style: GoogleFonts.manrope(
                fontSize: 12,
                color: Color(0xff6b7280),
              ),
            ),
            Text(
              '9876543210',
              style: GoogleFonts.manrope(
                fontSize: 14,
                color: Color(0xff6b7280),
              ),
            ),
            const SizedBox(height: 10),
            const Divider(height: 1, color: Colors.grey),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xffeff4fa),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _socialIcon( HugeIcons.strokeRoundedFacebook02, Colors.black,),
                  _socialIcon(HugeIcons.strokeRoundedInstagram, Colors.black,),
                  _socialIcon( HugeIcons.strokeRoundedWhatsapp, Colors.black,),
                  _socialIcon( HugeIcons.strokeRoundedGithub01, Colors.black,),
                  _socialIcon( HugeIcons.strokeRoundedNewTwitter, Colors.black,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _socialIcon(IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Icon(icon, size: 20, color: color),
    );
  }
}


