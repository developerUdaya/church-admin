import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

class TitleRow extends StatefulWidget {
  final String title;
  final VoidCallback? onPressed;
  final double? withSized;
  const TitleRow({super.key, required this.title,this.onPressed, this.withSized});

  @override
  State<TitleRow> createState() => _TitleRowState();
}

class _TitleRowState extends State<TitleRow> {
  final Color baseColor = Color(0xFF7876FA);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 100),
          height: MediaQuery.of(context).size.height * 0.07,
          width: MediaQuery.of(context).size.width > 1000 ? 1000 : MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 28, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              HugeIcon(
                  icon: HugeIcons.strokeRoundedHome01,
                  color: Colors.black54
              ),
              SizedBox(width: 10),
              GestureDetector(
                onTap: widget.onPressed,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 3,
                    horizontal: 11,
                  ),
                  decoration: BoxDecoration(
                    color: baseColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'Back '+widget.title,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight:FontWeight.w600,
                      color: baseColor,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
