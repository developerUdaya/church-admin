import 'package:church_admin/CustomColors.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';


class DropdownSidebarWidget extends StatefulWidget {
  final IconData icon;
  final String name;
  final List<Map<String, dynamic>> menuData;
  const DropdownSidebarWidget({super.key, required this.name, required this.menuData, required this.icon});

  @override
  State<DropdownSidebarWidget> createState() => _DropdownSidebarWidgetState();
}

class _DropdownSidebarWidgetState extends State<DropdownSidebarWidget> {
  String? selectedValue;
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.menuData.map((menu) {
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
          child: Padding(
            padding:EdgeInsets.symmetric(horizontal: 7.0, vertical: 4),
            child: AnimatedContainer(
              height: 55,
              duration: Duration(milliseconds: 150),
              child: ExpansionTile(
                collapsedShape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                tilePadding: EdgeInsets.symmetric(vertical: 1, horizontal: 15),
                leading: Icon(
                  widget.icon,
                  color: isHovered ? Colors.white : Colors.black54,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                collapsedBackgroundColor: isHovered ? Colors.blue.shade900 : Colors.white,
                backgroundColor: Colors.blue,
                iconColor: Colors.white,
                collapsedIconColor: menu['items'].isEmpty ? Colors.grey : Colors.white,
                textColor: Colors.white,
                collapsedTextColor: menu['items'].isEmpty ? Colors.grey : Colors.white,
                title: Text(
                  menu['title'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: isHovered ? Colors.white : Colors.black54,
                  ),
                ),
                children: menu['items']
                    .map<Widget>(
                      (item) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Row(
                      children: [
                        Text(
                          '.',
                          style: TextStyle(
                            color: isHovered?primaryBlue:Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            item,
                            style: TextStyle(
                              color: isHovered?primaryBlue:Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    )
                  ),
                ).toList(),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

}


