import 'package:church_admin/Service/UserServices.dart';
import 'package:church_admin/Service/FinanceService.dart';
import 'package:church_admin/Widgets/Calendar.dart';
import 'package:church_admin/Widgets/CustomButtons.dart';
import 'package:church_admin/Widgets/DropDown.dart';
import 'package:church_admin/Widgets/TextFieldForms.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DonationsForms extends StatefulWidget {
  const DonationsForms({super.key});

  @override
  State<DonationsForms> createState() => _DonationsFormsState();
}

class _DonationsFormsState extends State<DonationsForms> {
  final List<Map<String, dynamic>> fields = [
    {'title': 'Amount *', 'hint': 'Enter your amount', 'type': 'text', 'isMultiline': false},
    {'title': 'Source', 'hint': 'Enter source', 'type': 'text', 'isMultiline': false},
    {'title': 'Through/By/Via *', 'hint': 'Enter text', 'type': 'text', 'isMultiline': false},
    {'title': 'Verifier', 'type': 'dropdown', 'isMultiline': false},
    {'title': 'Notes', 'hint': 'Enter description', 'type': 'multiline', 'isMultiline': true},
  ];

  String paymentMethod = 'Upi';
  DateTime? selectedDate = DateTime.now(); // Default to today for clarity
  String? selectedVerifier;
  List<String> userIds = [];
  Map<String, String> userIdToNameMap = {};
  bool isLoading = true;

  final Map<String, TextEditingController> _textControllers = {};
  final Map<String, bool> _errorStates = {};
  final Financeservice _donationsService = Financeservice();

  @override
  void initState() {
    super.initState();
    for (var field in fields) {
      if (field['type'] == 'text' || field['type'] == 'multiline') {
        _textControllers[field['title']] = TextEditingController();
      }
      _errorStates[field['title']] = false;
    }
    _fetchUserDetails();
  }

  @override
  void dispose() {
    for (var controller in _textControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _fetchUserDetails() async {
    try {
      setState(() {
        isLoading = true;
      });
      final response = await UserServices.fetchUserDetails();

      if (response.isEmpty) {
        setState(() {
          userIds = [];
          userIdToNameMap = {};
          isLoading = false;
        });
        return;
      }

      final userDetails = response[0]['data'] as List<dynamic>;

      setState(() {
        userIds = userDetails
            .where((user) =>
                user['No'] != null &&
                user['Name'] != null &&
                user['Name']['name'] != null)
            .map((user) => user['No'].toString())
            .toList();

        userIdToNameMap = {
          for (var user in userDetails)
            if (user['No'] != null &&
                user['Name'] != null &&
                user['Name']['name'] != null)
              user['No'].toString(): user['Name']['name'].toString()
        };

        selectedVerifier = userIds.isNotEmpty ? userIds[0] : null;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching user details: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void _validateForm() {
    setState(() {
      for (var field in fields) {
        String title = field['title'];
        if (title.endsWith('*')) {
          if (field['type'] == 'text' || field['type'] == 'multiline') {
            _errorStates[title] = _textControllers[title]!.text.isEmpty;
          }
        }
      }
    });

    bool isDateValid = selectedDate != null;
    bool isFormValid = !_errorStates.values.contains(true) && isDateValid;

    if (isFormValid) {
      _submitForm();
    } else {
      if (!isDateValid) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a valid date')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill all required fields')),
        );
      }
      print("Form contains errors. Date: $selectedDate, Errors: ${_errorStates}");
    }
  }

  Future<void> _submitForm() async {
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate!);
    bool success = await _donationsService.createDonation(
      via: _textControllers['Through/By/Via *']!.text,
      paymentMethod: paymentMethod,
      verifier: selectedVerifier ?? '',
      description: _textControllers['Notes']!.text,
      date: formattedDate,
      amount: _textControllers['Amount *']!.text,
      source: _textControllers['Source']!.text,
      createdBy: "admin",
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Donation created successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to create donation')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.74,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      margin: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xfff4f7fc),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Add Donations'),
          const Divider(thickness: 1, color: Color(0xFFE4E6E8)),
          const SizedBox(height: 15),
          if (isLoading)
            const Center(child: CircularProgressIndicator())
          else ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: CalendarApp(
                    onDateSelected: (DateTime date) {
                      setState(() {
                        selectedDate = date;
                        print("Date selected: $selectedDate"); // Debug log
                      });
                    },
                    defaultDate: selectedDate ?? DateTime.now(),
                    title: 'Date *',
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  flex: 1,
                  child: _buildField(fields[0]), // Amount *
                ),
                const SizedBox(width: 15),
                Expanded(
                  flex: 1,
                  child: _buildField(fields[1]), // Source
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: _buildField(fields[2]), // Through/By/Via *
                ),
                const SizedBox(width: 15),
                Expanded(
                  flex: 1,
                  child: DropdownSelector(
                    title: 'Payment Method *',
                    value: paymentMethod,
                    onChanged: (newValue) {
                      setState(() {
                        paymentMethod = newValue!;
                      });
                    },
                    ItemList: ["Upi", "Bank", "Cheque", "Other"],
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  flex: 1,
                  child: _buildField(fields[3]), // Verifier
                ),
              ],
            ),
            const SizedBox(height: 15),
            _buildField(fields[4]), // Notes
            const SizedBox(height: 15),
            Align(
              alignment: Alignment.bottomRight,
              child: CustomButton(
                text: "Add Now",
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: _validateForm,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildField(Map<String, dynamic> field) {
    if (field['type'] == 'text' || field['type'] == 'multiline') {
      return Textfieldforms(
        title: field['title'],
        hint: field['hint'],
        isBlocked: false,
        isMultiline: field['isMultiline'] ?? false,
        isController: _textControllers[field['title']]!,
        isErrorText: _errorStates[field['title']]!,
      );
    } else if (field['title'] == 'Verifier') {
      return DropdownSelector(
        title: field['title'],
        value: selectedVerifier ?? '',
        onChanged: (newValue) {
          setState(() {
            selectedVerifier = newValue;
          });
        },
        ItemList: userIds,
      );
    }
    return const SizedBox();
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
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