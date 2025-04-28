import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommentCard extends StatelessWidget {
  final String username;
  final String comment;

  const CommentCard({
    super.key,
    required this.username,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xffeff4fa),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 15,
                child: Image.asset('assets/food.png'),
              ),
              const SizedBox(width: 16),
              Text(
                username,
                style: GoogleFonts.manrope(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            comment,
            style: GoogleFonts.manrope(
              fontSize: 14,
            ),
          ),
          SizedBox(height: 10),
          IconButton(
            padding: EdgeInsets.all(8),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color(0xff635bff)),
            ),
            onPressed: () {},
            icon: Icon(
              Icons.reply,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
