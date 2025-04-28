import 'package:flutter/material.dart';
/*
class Timepickerwidget extends StatefulWidget {
  const Timepickerwidget({super.key});

  @override
  State<Timepickerwidget> createState() => _TimepickerwidgetState();
}

class _TimepickerwidgetState extends State<Timepickerwidget> {
  TextEditingController timePiker = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: timePiker,
              decoration:  InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                labelText: "time",
                labelStyle: const TextStyle(
                  fontSize: 16,
                  color: Colors.black
                )
              ),
              onTap: () async {
                var time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                if(time!=null)
                  {
                    setState(() {
                      timePiker.text = time.format(context);
                    });
                  }
              },
            ),
          ],
        ),
      ),
    );
  }
}
*/


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

class TimePickerWidget extends StatefulWidget {
  final String title;
  final TimeOfDay? initialTime;
  final ValueChanged<TimeOfDay> onTimeSelected;

  const TimePickerWidget({
    super.key,
    required this.title,
    this.initialTime,
    required this.onTimeSelected,
  });

  @override
  State<TimePickerWidget> createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  TimeOfDay? selectedTime;

  @override
  void initState() {
    super.initState();
    selectedTime = widget.initialTime ?? TimeOfDay.now();
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );

    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
      widget.onTimeSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.title,
          style: GoogleFonts.manrope(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () => _selectTime(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12), // Matching Textfieldforms
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey,
                width: 0.5,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Ensures spacing
              children: [
                Row(
                  children: [
                    HugeIcon(
                      icon: HugeIcons.strokeRoundedClock01,
                      color: Colors.grey,
                      size: 18, // Slightly increased for better proportion
                    ),
                    const SizedBox(width: 10), // Space between icon and text
                    Text(
                      selectedTime?.format(context) ?? 'Select Time',
                      style: GoogleFonts.manrope(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            )
          ),
        ),
      ],
    );
  }
}


