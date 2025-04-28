import 'package:church_admin/Service/ApiHandler/LittleFlocksApiHandler.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Widgets/AddProductListWidget.dart';
import '../../Widgets/CustomButtons.dart';
import '../../Widgets/TableWidget.dart';
import '../../Widgets/TextFieldForms.dart';
import '../Header/DashBoardHeader.dart';
import '../../Service/Littleflocksservice.dart';

class FlocksTable extends StatefulWidget {
  final List<Map<String, dynamic>>? testData;
  final String? name;

  const FlocksTable({super.key, this.testData, this.name});

  @override
  State<FlocksTable> createState() => _FlocksTableState();
}

class _FlocksTableState extends State<FlocksTable> {
  final TextEditingController _flockNameController = TextEditingController();
  final Littleflocksservice _flocksService = Littleflocksservice();
  late Future<List<Map<String, dynamic>>> futureFlockData;

  @override
  void initState() {
    super.initState();
    futureFlockData = fetchLittleFlocksDataFromApi();
  }

  @override
  void dispose() {
    _flockNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          DashboardHeader(),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AddProductTittleBar(
                    titleName: widget.name ?? 'Default Name',
                    onPressed: () {
                      _showPopup(context);
                    },
                  ),
                  const SizedBox(height: 30),
                  Flexible(
                    child: FutureBuilder<List<Map<String, dynamic>>>(
                      future: futureFlockData,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(child: Text('No data available'));
                        } else {
                          return TableWidget(
                            testData: snapshot.data!,
                            name: widget.name ?? 'Default Name',
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showPopup(BuildContext context) {
    _flockNameController.clear();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.2),
                  spreadRadius: 4,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            width: MediaQuery.of(context).size.width * 0.30,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeader('Add Flock'),
                const Divider(),
                const SizedBox(height: 10),
                Textfieldforms(
                  title: 'Flock Name *',
                  hint: 'Enter Flock Name',
                  isBlocked: false,
                  isController: _flockNameController,
                  isErrorText: _flockNameController.text.isEmpty && _flockNameController.text.trim().isNotEmpty,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      text: "Create",
                      color: Colors.green,
                      textColor: Colors.white,
                      onPressed: () async {
                        if (_flockNameController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please enter a flock name')),
                          );
                          return;
                        }
                        bool success = await _flocksService.createFlock(
                          name: _flockNameController.text,
                          createdBy: "admin",
                        );
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(success ? 'Flock created successfully' : 'Failed to create flock')),
                        );
                      },
                    ),
                    const SizedBox(width: 10),
                    CustomButton(
                      text: "Cancel",
                      color: Colors.red,
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: GoogleFonts.manrope(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }
}
