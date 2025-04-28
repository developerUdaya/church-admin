import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'DashBoardButton.dart';

class shop_sidebar extends StatefulWidget {
  const shop_sidebar({super.key});

  @override
  _shop_sidebarState createState() => _shop_sidebarState();
}

class _shop_sidebarState extends State<shop_sidebar> {
  String selectedGender = 'All';
  String selectedPriceRange = 'All';
  String selectedColor = 'white';
  String selectedLabel = 'All';
  String selectedItem = 'All';
  String selectedItem1 = 'Newest';

  void _onButtonTap(String label, Widget destination) {
    setState(() {
      selectedLabel = label;
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => destination),
    );
  }


  final List<Map<String, dynamic>> colorOptions = [
    {'name': 'white', 'color': Colors.white},
    {'name': 'black', 'color': Colors.black},
    {'name': 'blue', 'color': Colors.blue},
    {'name': 'green', 'color': Colors.green},
    {'name': 'red', 'color': Colors.red},
    {'name': 'yellow', 'color': Colors.yellow},
    {'name': 'pink', 'color': Colors.pink},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          // 🔹 Category Filter
          _buildSectionTitle('Filter By Category'),
          DashboardButton(icon: HugeIcons.strokeRoundedNote05, label: 'All', isSelected:selectedItem == "All",
              onPressed: (value) {setState(() {
            selectedItem = "All";
          });}),
          DashboardButton(icon: HugeIcons.strokeRoundedAward05, label: 'Fashion',isSelected:selectedItem == "Fashion",
              onPressed: (value) {setState(() {
                selectedItem = "Fashion";
              });}),
          DashboardButton(icon: HugeIcons.strokeRoundedBook02, label: 'Books',isSelected:selectedItem == "Books",
              onPressed: (value) {setState(() {
                selectedItem = "Books";
              });}),
          DashboardButton(icon: HugeIcons.strokeRoundedSmile, label: 'Toys',isSelected:selectedItem == "Toys",
              onPressed: (value) {setState(() {
                selectedItem = "Toys";
              });}),
          DashboardButton(icon: HugeIcons.strokeRoundedLaptopCharging, label: 'Electronics',isSelected:selectedItem == "Electronics",
              onPressed: (value) {setState(() {
                selectedItem = "Electronics";
              });}),

          const SizedBox(height: 20),
          const Divider(thickness: 2, color: Color(0xFFEEF2F5),),
          // 🔹 Sort By
          _buildSectionTitle('Sort By'),
          DashboardButton(icon: HugeIcons.strokeRoundedNews01, label: 'Newest',isSelected:selectedItem1 == "Newest",
              onPressed: (value) {setState(() {
                selectedItem1 = "Newest";
              });}),
          DashboardButton(icon: HugeIcons.strokeRoundedTradeDown, label: 'Price: High-Low',isSelected:selectedItem1 == "Price: High-Low",
              onPressed: (value) {setState(() {
                selectedItem1 = "Price: High-Low";
              });}),
          DashboardButton(icon: HugeIcons.strokeRoundedTradeUp, label: 'Price: Low-High',isSelected:selectedItem1 == "Price: Low-High",
              onPressed: (value) {setState(() {
                selectedItem1 = "Price: Low-High";
              });}),
          DashboardButton(icon: HugeIcons.strokeRoundedDiscount, label: 'Discounted',isSelected:selectedItem1 == "Discounted",
              onPressed: (value) {setState(() {
                selectedItem1 = "Discounted";
              });}),

          const SizedBox(height: 20),
          const Divider(thickness: 2, color: Color(0xFFEEF2F5)),
          // 🔹 Filter by Gender
          _buildSectionTitle('By Gender'),
          _buildRadioButton('All', selectedGender, (value) { setState(() => selectedGender = value!); }),
          _buildRadioButton('Men', selectedGender, (value) { setState(() => selectedGender = value!); }),
          _buildRadioButton('Women', selectedGender, (value) { setState(() => selectedGender = value!); }),
          _buildRadioButton('Kids', selectedGender, (value) { setState(() => selectedGender = value!); }),

          const SizedBox(height: 20),
          const Divider(thickness: 2, color: Color(0xFFEEF2F5)),
          // 🔹 Filter by Pricing
          _buildSectionTitle('By Pricing'),
          _buildRadioButton('All', selectedPriceRange, (value) { setState(() => selectedPriceRange = value!); }),
          _buildRadioButton('0-50', selectedPriceRange, (value) { setState(() => selectedPriceRange = value!); }),
          _buildRadioButton('50-100', selectedPriceRange, (value) { setState(() => selectedPriceRange = value!); }),
          _buildRadioButton('100-200', selectedPriceRange, (value) { setState(() => selectedPriceRange = value!); }),
          _buildRadioButton('200-99999', selectedPriceRange, (value) { setState(() => selectedPriceRange = value!); }),

          const SizedBox(height: 20),
          const Divider(thickness:2, color: Color(0xFFEEF2F5)),
          // 🔹 Filter by Colors
          _buildSectionTitle('By Colors'),
          Wrap(
            spacing: 10,
            children: colorOptions.map((colorOption) {
              return GestureDetector(
                onTap: () { setState(() => selectedColor = colorOption['name']); },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colorOption['color'],
                    border: Border.all(
                      color: selectedColor == colorOption['name'] ? Colors.blue : Color(0xFFEEF2F5),
                      width: selectedColor == colorOption['name'] ? 3 : 1,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 20),

          // 🔹 Reset Button
          Align(
            alignment: Alignment.centerLeft,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedLabel = 'All';
                  selectedGender = 'All';
                  selectedPriceRange = 'All';
                  selectedColor = 'white';
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
              child: const Text('Reset Filter'),
            ),
          ),
        ],
      ),
    );

  }

  void _updateSelectedLabel(String label) {
    setState(() {
    });
  }

  Widget _buildRadioButton(String label, String groupValue, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 30),
      child: Row(
        children: [
          Radio<String>(
            value: label,
            groupValue: groupValue,
            onChanged: onChanged,
          ),
          SizedBox(width: 10,),
          Text(label),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}