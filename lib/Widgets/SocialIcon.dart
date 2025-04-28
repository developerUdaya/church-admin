import 'package:flutter/material.dart';

// ✅ Social Icon with Hover Effect
class SocialIcon extends StatefulWidget {
  final IconData icon;

  const SocialIcon({super.key, required this.icon});

  @override
  State<SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<SocialIcon> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(6),
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isHovered ? Colors.blue.withOpacity(0.2) : Colors.transparent,
        ),
        child: Icon(widget.icon, size: 18, color: isHovered ? Colors.blue : Colors.black),
      ),
    );
  }
}