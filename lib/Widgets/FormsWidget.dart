import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../view/CustomForms/WrapUi.dart';
import 'CustomButtons.dart';


class FromDropDownWidget extends StatefulWidget {
  final Map<String, dynamic> listValue;
  final String? selectedOption;
  final Function(String?) onShopSelected;
  final String name;

  const FromDropDownWidget({
    super.key,
    required this.listValue,
    this.selectedOption,
    required this.onShopSelected,
    required this.name,
  });

  @override
  State<FromDropDownWidget> createState() => _FromDropDownWidgetState();
}

class _FromDropDownWidgetState extends State<FromDropDownWidget> {
  String? selectedOption;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    List<String> options = List<String>.from(widget.listValue["Options"] ?? []);
    selectedOption = options.isNotEmpty ? options.first : null;
  }

  @override
  Widget build(BuildContext context) {
    List<String> options = List<String>.from(widget.listValue["Options"] ?? []);

    return Container(
      width: MediaQuery.of(context).size.width * 0.61,
      height: MediaQuery.of(context).size.height*0.99,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: const Color(0xFFEEF1F4), width: 1.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 1,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            widget.name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C3442),
            ),
          ),
          const SizedBox(height: 10),
          const Divider(thickness: 1, color: Color(0xFFE4E6E8)),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Text(
                    'Select:',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C3442),
                    ),
                  ),
                ),

                Container(
                  width: MediaQuery.of(context).size.width * 0.28,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: const Text(
                        'Select an option',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      items: options
                          .toSet() // Removes duplicates
                          .map((option) {
                        return DropdownMenuItem(
                          value: option,
                          child: Center(
                            child: Text(option, style: const TextStyle(fontSize: 14)),
                          ),
                        );
                      }).toList(),
                      value: options.contains(selectedOption) ? selectedOption : null,
                      onChanged: (value) {
                        setState(() {
                          selectedOption = value;
                        });
                        widget.onShopSelected(value);
                      },
                      buttonStyleData: ButtonStyleData(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                   /*     padding: EdgeInsets.symmetric(horizontal: 16),
                        height: 50,*/
                      ),
                      dropdownStyleData: DropdownStyleData(
                        maxHeight: 200,
                        width: MediaQuery.of(context).size.width * 0.28,
                      ),
                      menuItemStyleData: const MenuItemStyleData(height: 40),
                      dropdownSearchData: DropdownSearchData(
                        searchController: searchController,
                        searchInnerWidgetHeight: 50,
                        searchInnerWidget: Padding(
                          padding: const EdgeInsets.all(8),
                          child: TextFormField(
                            controller: searchController,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                              hintText: 'Search...',
                              hintStyle: const TextStyle(fontSize: 12),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),

                            ),
                          ),
                        ),
                        searchMatchFn: (item, searchValue) {
                          return item.value.toString().toLowerCase().contains(searchValue.toLowerCase());
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
              child: SuggestionUi()
          ),
        ],
      ),
    );
  }
}


