import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import '../CustomColors.dart';
import 'Calendar.dart';
import 'TableWidget.dart';

class DropdownButtonWidget extends StatefulWidget {
  final IconData icon;
  final String label;
  final List<String> items;
  final String selectedItem;
  final ValueChanged<String> onItemSelected;
  final EdgeInsetsGeometry margin;

  const DropdownButtonWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.items,
    required this.selectedItem,
    required this.onItemSelected,
    this.margin = const EdgeInsets.only(left: 20.0),

  });

  @override
  State<DropdownButtonWidget> createState() => _DropdownButtonWidgetState();
}

class _DropdownButtonWidgetState extends State<DropdownButtonWidget> {
  bool isHovered = false;
  String hoveredItem = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: Theme(
        data: Theme.of(context).copyWith(
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent, // Remove ripple effect
          highlightColor: Colors.transparent, // Remove hover effect
        ),
        child: ExpansionTile(
          leading: HugeIcon(
            icon: widget.icon,
            size: 22,
            color: isHovered || widget.selectedItem.startsWith(widget.label)
                ? primaryBlue
                : const Color(0xff302929),
          ),
          title: MouseRegion(
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
            child: Text(
              widget.label,
              style: TextStyle(
                fontWeight: FontWeight.w500,

                fontSize: 16,
                color: isHovered || widget.selectedItem.startsWith(widget.label)
                    ? primaryBlue
                    : const Color(0xff302929),
              ),
            ),
          ),
          collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          tilePadding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: widget.items.map((item) {
            return MouseRegion(
              onEnter: (_) {
                setState(() {
                  hoveredItem = item;
                });
              },
              onExit: (_) {
                setState(() {
                  hoveredItem = '';
                });
              },
              child: ListTile(
                // hoverColor: Colors.transparent, // Remove hover background
                // splashColor: Colors.transparent, // Remove ripple effect
                title: Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      margin: const EdgeInsets.only(left: 8,right: 20),
                      decoration: BoxDecoration(
                        color: widget.selectedItem == item || hoveredItem == item
                            ? primaryBlue
                            : const Color(0xff302929),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Text(
                      item,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: widget.selectedItem == item || hoveredItem == item
                            ? primaryBlue
                            : const Color(0xff302929),
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  setState(() {
                    widget.onItemSelected(item);
                  });

                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}


