import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ToastButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBackgroundColor;
  final String text;
  final Function onPressed;
  final bool haveIcon;
  final bool haveUndo;
  const ToastButton(
      {super.key,
      required this.icon,
      required this.text,
      required this.onPressed,
      required this.haveIcon,
      required this.haveUndo, required this.iconColor, required this.iconBackgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 320,
      padding: EdgeInsets.all(14),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            blurRadius: 5,
            spreadRadius: 1,
            offset: Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              haveIcon
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: iconBackgroundColor,
                      ),
                      padding: EdgeInsets.all(6),
                      child: Icon(
                        icon,
                        color: iconColor,
                        size: 24,
                      ),
                    )
                  : SizedBox(),
              SizedBox(width: 10),
              Text(
                text,
                style: GoogleFonts.manrope(
                  fontSize: 14,
                  //fontWeight: FontWeight.w800,
                  color: Color(0xff6b7280),
                ),
              ),
            ],
          ),
          Row(
            children: [
              if (haveUndo) ...{
                TextButton(
                  child: Text(
                    'Undo',
                    style: GoogleFonts.manrope(
                      fontSize: 14,
                      //fontWeight: FontWeight.w600,
                      color: Color(0xff635bff),
                    ),
                  ),
                  onPressed: () => {
                    onPressed(),
                  },
                ),
                SizedBox(width: 10)
              },
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: Color(0xff6b7280),
                ),
                onPressed: () {
                  onPressed();
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
