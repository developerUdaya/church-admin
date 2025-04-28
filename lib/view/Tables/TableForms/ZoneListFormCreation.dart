import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:church_admin/Service/ZoneActivitiesService.dart'; // Assuming this exists
import 'package:church_admin/Widgets/CustomButtons.dart';
import 'package:church_admin/Widgets/DropDown.dart';
import 'package:church_admin/Widgets/TextFieldForms.dart';
import 'package:church_admin/Widgets/TitleRow.dart';

class ZoneListFormCreation extends StatefulWidget {
  final Function(Map<String, dynamic>)? onSubmit; // Add callback for ZoneList_table

  const ZoneListFormCreation({super.key, this.onSubmit});

  @override
  State<ZoneListFormCreation> createState() => _ZoneListFormCreationState();
}

class _ZoneListFormCreationState extends State<ZoneListFormCreation> {
  final Zoneactivitiesservice _zoneListService = Zoneactivitiesservice(); // Service for POST

  final List<Map<String, dynamic>> fields = [
    {'title': 'Zone ID *', 'hint': 'Enter Zone ID', 'type': 'text'},
    {'title': 'Zone Name *', 'hint': 'Enter Zone Name', 'type': 'text'},
    {
      'title': 'Leader Name *',
      'hint': '',
      'type': 'dropdown',
      'options': ["China", "Mark", "Williom", "Barkar", "Johnson"]
    },
    {'title': 'Leader Phone', 'hint': 'Enter Leader Phone', 'type': 'text'},
    {
      'title': 'Member Name',
      'hint': '',
      'type': 'dropdown',
      'options': ["Barkar", "Johnson", "Williom", "Mark", "China"] // Use supporters list
    },
    {'title': 'Member ID', 'hint': 'Enter Member ID', 'type': 'text'},
  ];

  // Dropdown States
  String selectedLeader = "Mark";
  String selectedMember = "Barkar";

  // Sample Data
  final List<String> allAreas = ["Chennai", "Kolathur", "Asoke Pillar", "North Madras", "Meenampakkam"];
  final List<String> supporters = ["Barkar", "Johnson", "Williom", "Mark", "China"];

  // Selected Items
  final List<String> selectedAreas = [];
  final List<String> selectedSupporters = [];

  // Controllers and Error States
  final Map<String, TextEditingController> _textControllers = {};
  final Map<String, bool> _errorStates = {};
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    for (var field in fields) {
      _textControllers[field['title']] = TextEditingController();
      _errorStates[field['title']] = false;
    }
  }

  @override
  void dispose() {
    for (var controller in _textControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _validateAndSubmit() {
    setState(() {
      for (var field in fields) {
        String title = field['title'];
        if (title.endsWith('*')) {
          if (field['type'] == 'text') {
            _errorStates[title] = _textControllers[title]!.text.isEmpty;
          } else if (field['type'] == 'dropdown') {
            _errorStates[title] = (title == 'Leader Name *' ? selectedLeader : selectedMember).isEmpty;
          }
        }
      }
    });

    bool isValid = !_errorStates.values.contains(true);
    if (isValid) {
      _submitForm();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
      print("Form errors: $_errorStates");
    }
  }

  Future<void> _submitForm() async {
    setState(() {
      _isLoading = true;
    });

    // Only send zone, name, and created_by as per the original POST requirement
    bool success = await _zoneListService.createZoneList(
      zone: _textControllers['Zone ID *']!.text,
      name: _textControllers['Zone Name *']!.text,
      createdBy: "admin_user",
    );

    setState(() {
      _isLoading = false;
    });

    if (success) {
      if (widget.onSubmit != null) {
        widget.onSubmit!({
          "zone": _textControllers['Zone ID *']!.text,
          "name": _textControllers['Zone Name *']!.text,
          "created_by": "admin_user",
        });
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Zone area added successfully')),
      );
      for (var controller in _textControllers.values) {
        controller.clear();
      }
      setState(() {
        selectedLeader = "Mark";
        selectedMember = "Barkar";
        selectedAreas.clear();
        selectedSupporters.clear();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to add zone area')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.73,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      margin: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xfff4f7fc),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TitleRow(title: 'Add Zone'),
            const SizedBox(height: 30),
            _buildFormContainer(),
          ],
        ),
      ),
    );
  }

  Widget _buildFormContainer() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeader('Add Zone'),
                const Divider(thickness: 1, color: Color(0xFFE4E6E8)),
                const SizedBox(height: 15),
                ..._buildFormRows(),
                Row(
                  children: [
                    Expanded(child: buildAreaList("All Areas", allAreas, addToZoneArea)),
                    const SizedBox(width: 15),
                    Expanded(child: buildSelectedAreaList("Zone Area", selectedAreas, removeFromZoneArea)),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(child: buildMemberInput()),
                    const SizedBox(width: 15),
                    Expanded(child: buildSelectedAreaList("Zone Leader Supporters", selectedSupporters, removeSupporter)),
                  ],
                ),
                const SizedBox(height: 15),
                Align(
                  alignment: Alignment.bottomRight,
                  child: CustomButton(
                    text: "SUBMIT",
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: _validateAndSubmit,
                  ),
                ),
              ],
            ),
    );
  }

  List<Widget> _buildFormRows() {
    List<Widget> rows = [];
    int i = 0;
    while (i < fields.length) {
      if (fields[i]['type'] == 'multiline') {
        rows.add(_buildField(fields[i]));
        rows.add(const SizedBox(height: 15));
        i++;
      } else {
        List<Widget> rowChildren = [];
        for (int j = 0; j < 3 && i + j < fields.length; j++) {
          if (fields[i + j]['type'] != 'multiline') {
            rowChildren.add(Expanded(child: _buildField(fields[i + j])));
            if (j < 2 && i + j + 1 < fields.length && fields[i + j + 1]['type'] != 'multiline') {
              rowChildren.add(const SizedBox(width: 15));
            }
          } else {
            break;
          }
        }
        if (rowChildren.isNotEmpty) {
          rows.add(Row(children: rowChildren));
          rows.add(const SizedBox(height: 15));
        }
        i += rowChildren.length ~/ 2 + 1;
      }
    }
    return rows;
  }

  Widget _buildField(Map<String, dynamic> field) {
    if (field['type'] == 'dropdown') {
      return DropdownSelector(
        title: field['title'],
        value: field['title'] == 'Leader Name *' ? selectedLeader : selectedMember,
        onChanged: (newValue) {
          setState(() {
            if (field['title'] == 'Leader Name *') {
              selectedLeader = newValue!;
            } else if (field['title'] == 'Member Name') {
              selectedMember = newValue!;
            }
          });
        },
        ItemList: field['options'],
      );
    } else {
      return Textfieldforms(
        title: field['title'],
        hint: field['hint'],
        isBlocked: false,
        isMultiline: field['type'] == 'multiline',
        isController: _textControllers[field['title']]!,
        isErrorText: _errorStates[field['title']]!,
      );
    }
  }

  Widget buildMemberInput() {
    return Card(
      color: Colors.white,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Members", style: TextStyle(fontWeight: FontWeight.bold)),
            DropdownSelector(
              title: "Member Name",
              value: selectedMember,
              onChanged: (newValue) {
                setState(() {
                  selectedMember = newValue!;
                });
              },
              ItemList: supporters,
            ),
            const SizedBox(height: 5),
            Textfieldforms(
              title: "Member ID",
              hint: "Enter Member ID",
              isBlocked: false,
              isController: _textControllers["Member ID"]!,
            ),
            const SizedBox(height: 10),
            Center(
              child: CustomButton(
                text: "ADD",
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: addSupporter,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildListSection(String title, List<String> items, Widget? Function(String)? actionBuilder) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Card(
          color: Colors.white,
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(items[index]),
                      if (actionBuilder != null) actionBuilder(items[index])!,
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildAreaList(String title, List<String> items, Function(String) onAdd) {
    return buildListSection(title, items, (item) {
      return IconButton(
        icon: const Icon(Icons.add_circle, color: Colors.blue),
        onPressed: () => onAdd(item),
      );
    });
  }

  Widget buildSelectedAreaList(String title, List<String> items, Function(String) onRemove) {
    return buildListSection(title, items, (item) {
      return IconButton(
        icon: const Icon(Icons.remove_circle, color: Colors.blue),
        onPressed: () => onRemove(item),
      );
    });
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Text(
        title,
        style: GoogleFonts.manrope(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
      ),
    );
  }

  void addSupporter() {
    if (!selectedSupporters.contains(selectedMember) && selectedMember.isNotEmpty) {
      setState(() {
        selectedSupporters.add(selectedMember);
      });
    }
  }

  void removeSupporter(String supporter) {
    setState(() {
      selectedSupporters.remove(supporter);
    });
  }

  void addToZoneArea(String area) {
    if (!selectedAreas.contains(area)) {
      setState(() {
        selectedAreas.add(area);
      });
    }
  }

  void removeFromZoneArea(String area) {
    setState(() {
      selectedAreas.remove(area);
    });
  }
}