import 'package:flutter/material.dart';

import '../../CustomColors.dart';
import '../../Widgets/CustomButtons.dart';
import '../../Widgets/WrapWidget.dart';

class SuggestionUi extends StatefulWidget {
  const SuggestionUi({super.key});

  @override
  State<SuggestionUi> createState() => _SuggestionUiState();
}

class _SuggestionUiState extends State<SuggestionUi> {

  final wrapData = wrapValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: wrapData.map((data) {
                    return SelectableChipsWidget(
                      name: data['name'],
                      items: List<String>.from(data['Value']),
                    );
                  }).toList(),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20, right: 20),
                child: ElevatedButton(
                  onPressed: () {
                    debugPrint("Update Button Clicked");
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor:Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  child: const Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

