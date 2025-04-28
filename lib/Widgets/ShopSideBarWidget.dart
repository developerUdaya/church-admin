import 'package:flutter/material.dart';

class DashboardButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final Widget destination;
  final bool isSelected;

  const DashboardButton({
    super.key,
    required this.icon,
    required this.label,
    required this.destination,
    this.isSelected = false, required void Function() onTap,
  });

  @override
  State<DashboardButton> createState() => _DashboardButtonState();
}

class _DashboardButtonState extends State<DashboardButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: MaterialButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => widget.destination),
          );
        },

        height: 50,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(
              widget.icon,
              size: 20,
              color: widget.isSelected ? Colors.purpleAccent : Colors.black87,
            ),
            const SizedBox(width: 10),
            Text(
              widget.label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: widget.isSelected ? Colors.purpleAccent : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}