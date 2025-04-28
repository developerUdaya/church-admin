import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class OptionButton extends StatefulWidget {
  final List<Map<String, dynamic>> menuItems;

  const OptionButton({super.key, required this.menuItems});

  @override
  State<OptionButton> createState() => _OptionButtonState();

  void onPressed(String label) {}
}

class _OptionButtonState extends State<OptionButton> {
  String? selectedValue;
  bool isHovered = false;
  String? hoveredItem;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 20,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: false,
              value: selectedValue,
              customButton: const Icon(
                Icons.more_vert,
                size: 22,
                color: Colors.black,
              ),
              items: widget.menuItems.map<DropdownMenuItem<String>>((menuItem) {
                return DropdownMenuItem<String>(
                  value: menuItem['label'],
                  child: StatefulBuilder(
                    builder: (context, setStateInternal) {
                      return MouseRegion(
                        onEnter: (_) {
                          setStateInternal(() {
                            hoveredItem = menuItem['label'];
                          });
                        },
                        onExit: (_) {
                          setStateInternal(() {
                            hoveredItem = null;
                          });
                        },
                        child: GestureDetector(
                          onTap: () {
                            if (menuItem['onPressed'] != null) {
                              menuItem['onPressed']();
                            }
                          },
                          child: Row(
                            children: [
                              Icon(
                                menuItem['icon'],
                                size: 22,
                                color: hoveredItem == menuItem['label']
                                    ? const Color(0xFF736DED)
                                    : const Color(0xFF353C48),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                menuItem['label'],
                                style: TextStyle(
                                  fontSize: 16,
                                  color: hoveredItem == menuItem['label']
                                      ? const Color(0xFF736DED)
                                      : const Color(0xFF353C48),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedValue = value;
                });
              },
              dropdownStyleData: DropdownStyleData(
                width: 110,
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
              ),
              buttonStyleData: ButtonStyleData(
                height: 35,
                width: 35,
                padding: EdgeInsets.zero,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Example data for the OptionButton widget
// final List<Map<String, dynamic>> menuItems = [
//   {
//     'label': 'Edit',
//     'icon': Icons.edit,
//     'onPressed': () {
//       print('Edit button pressed');
//     },
//   },
//   {
//     'label': 'Delete',
//     'icon': Icons.delete,
//     'onPressed': () {
//       print('Delete button pressed');
//     },
//   },
//   {
//     'label': 'Share',
//     'icon': Icons.share,
//     'onPressed': () {
//       print('Share button pressed');
//     },
//   },
// ];
