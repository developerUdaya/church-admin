import 'package:flutter/material.dart';

import 'CustomButtons.dart';


class SelectableChipsWidget extends StatefulWidget {
  final List<String> items;
  final String name;

  const SelectableChipsWidget({Key? key, required this.items, required this.name}) : super(key: key);

  @override
  _SelectableChipsWidgetState createState() => _SelectableChipsWidgetState();
}

class _SelectableChipsWidgetState extends State<SelectableChipsWidget> {
  Set<String> selectedItems = {};

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const Divider(thickness: 1, color: Color(0xFFE4E6E8)),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: widget.items.map((item) {
              final isSelected = selectedItems.contains(item);
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      selectedItems.remove(item);
                    } else {
                      selectedItems.add(item);
                    }
                    debugPrint("Selected Values: $selectedItems");
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.blue : Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    item,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

