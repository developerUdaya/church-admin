import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../CustomColors.dart';

class DashboardButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final double textSize;
  final double iconSize;
  final bool isSelected;
  final ValueChanged onPressed;

  DashboardButton({
    super.key,
    required this.icon,
    required this.label,
    this.textSize = 16,
    this.iconSize = 22,
    this.isSelected = false,
    required this.onPressed,
  });

  @override
  State<DashboardButton> createState() => _DashboardButtonState();
}

class _DashboardButtonState extends State<DashboardButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },
      child: GestureDetector(
        onTap:(){
        setState(() {
          widget.onPressed(widget.label);
        });
        },

        child: AnimatedContainer(
          height: 55,

          duration: const Duration(milliseconds: 150),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
          margin: const EdgeInsets.symmetric(horizontal: 18.0, ),
          decoration: BoxDecoration(
            color: widget.isSelected ? primaryBlue : null,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: widget.isSelected
                ? [
              BoxShadow(
                color: primaryBlue.withOpacity(0.5),
                offset: const Offset(3.0, 3.0),
                blurRadius: 10.0,
              )
            ]
                : [],
          ),
          child: Row(
            children: [
              HugeIcon(
                icon: widget.icon,
                size: widget.iconSize,
                color: widget.isSelected
                    ? Colors.white
                    : isHovered
                    ? primaryBlue
                    : const Color(0xff302929),
              ),
              const SizedBox(width: 12),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 150),
                curve: Curves.easeInOut,
                style: TextStyle(
                  fontSize: widget.textSize,
                  fontWeight: FontWeight.w500,
                  color: widget.isSelected
                      ? Colors.white
                      : isHovered
                      ? primaryBlue
                      : const Color(0xff302929),
                ),
                child: Text(widget.label),
              ),
            ],
          ),
        ),
      ),
    );
   /* return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },
      child: GestureDetector(
        onTap: () {
          setState(() {
            widget.onPressed(widget.label);
          });
        },
        child: AnimatedContainer(
          height: 55,
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0), // Reduced padding
          margin: const EdgeInsets.symmetric(horizontal: 8.0), // Reduced margin
          decoration: BoxDecoration(
            color: widget.isSelected ? primaryBlue : null,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: widget.isSelected
                ? [
              BoxShadow(
                color: primaryBlue.withOpacity(0.5),
                offset: const Offset(3.0, 3.0),
                blurRadius: 10.0,
              )
            ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min, // Makes Row take only needed space
            children: [
              HugeIcon(
                icon: widget.icon,
                size: widget.iconSize,
                color: widget.isSelected
                    ? Colors.white
                    : isHovered
                    ? primaryBlue
                    : const Color(0xff302929),
              ),
              const SizedBox(width: 8), // Reduced spacing
              Flexible( // Prevents text overflow
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 150),
                  curve: Curves.easeInOut,
                  style: TextStyle(
                    fontSize: widget.textSize,
                    fontWeight: FontWeight.w100,
                    color: widget.isSelected
                        ? Colors.white
                        : isHovered
                        ? primaryBlue
                        : const Color(0xff302929),
                  ),
                  child: Text(
                    widget.label,
                    overflow: TextOverflow.ellipsis, // Ensures long text doesn't overflow
                    maxLines: 1, // Limits text to one line
                    softWrap: false,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );*/

  }
}
