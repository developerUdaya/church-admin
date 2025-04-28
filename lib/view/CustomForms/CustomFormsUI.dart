import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Widgets/CheckBoxe.dart';
import '../../Widgets/CustomButtons.dart';
import '../../Widgets/DropDown.dart';
import '../../Widgets/RadioSelecter.dart';
import '../../Widgets/Slider.dart';
import '../../Widgets/Switches.dart';
import '../../Widgets/TextFieldForms.dart';
import '../../Widgets/VolumeSlider.dart';
import '../../Widgets/Calendar.dart';
import '../../Widgets/TitleRow.dart';


void main(){
  runApp(MaterialApp(
    home: CustomForms()
  ));
}

class CustomForms extends StatefulWidget {
  const CustomForms({super.key});

  @override
  State<CustomForms> createState() => _CustomFormsState();
}

class _CustomFormsState extends State<CustomForms> {
  String dropdownValue = 'One';
  String dropdownValue2 = 'One';
  String dropdownValue3 = 'One';

  //String gender = 'Male';
  bool industryChecked = false;
  bool switchValue = false;

  final List<bool> boxChecker = List.generate(4, (index) => false);
  void onChangedCheckBox(bool value, int index) {
    setState(() {
      boxChecker[index] = value;
    });
  }

  double volumeValue = 0.5;
  void onChangedVolume(double value) {
    setState(() {
      volumeValue = value;
    });
  }

  double sliderValue = 0.5;
  void onChangedSlider(double value) {
    setState(() {
      sliderValue = value;
    });
  }

  List<bool> switchChecker = List.generate(4, (index) => false);
  void onChangedSwitch(bool value, int index) {
    setState(() {
      switchChecker[index] = value;
    });
  }

  String selectedGender = "Male";
  void onChangedGender(String? value) {
    setState(() {
      selectedGender = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 45, vertical: 30),
      margin: EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color(0xfff4f7fc),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TitleRow(title: 'Forms Custom'),
            SizedBox(height: 30),
            Container(
              width: MediaQuery.of(context).size.width * 0.80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                    child: Text(
                      'Ordrinary Form',
                      style: GoogleFonts.manrope(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 0.5,
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Textfieldforms(
                                title: 'Name',
                                hint: 'Enter your name',
                                isBlocked: false,
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: Textfieldforms(
                                title: 'Company Name',
                                hint: 'Company Name',
                                isBlocked: false,
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: Textfieldforms(
                                title: 'Phone',
                                hint: 'Enter your phone',
                                isBlocked: true,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 1,
                              child: DropdownSelector(
                                title: 'Select Dropdown',
                                value: dropdownValue,
                                onChanged: (newValue) {
                                  setState(() {
                                    dropdownValue = newValue!;
                                  });
                                }, ItemList: [],
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(flex: 1, child: CalendarApp(title: '', onDateSelected: (DateTime ) {  }, defaultDate: DateTime.now(),))
                          ],
                        ),
                        const SizedBox(height: 16),
                        GenderSelector(
                          selectedGender: selectedGender,
                          onChanged: onChangedGender,
                          genders: ["Male", "Female", "Disabled"], title: '',
                        ),
                        const SizedBox(height: 16),
                        CheckBoxes(
                          checker: boxChecker,
                          text: ["One", "Two", "Three",'4'],
                          onChangedCheckBox: onChangedCheckBox,
                        ),
                        const SizedBox(height: 16),
                        Switches(
                          checker: switchChecker,
                          text: [
                            "Enter Text",
                            "Enter Text",
                            "Enter Text",
                            "Enter Text"
                          ],
                          onChangedSwitch: onChangedSwitch,
                        ),
                        const SizedBox(height: 16),
                        SliderWidgets(
                            sliderValue: sliderValue,
                            onChanged: onChangedSlider),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: 500,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 100,
                                child: DropdownSelector(
                                  title: 'Select Dropdown',
                                  value: dropdownValue2,
                                  onChanged: (newValue) {
                                    setState(() {
                                      dropdownValue2 = newValue!;
                                    });
                                  }, ItemList: [],
                                ),
                              ),
                              Container(
                                width: 100,
                                child: DropdownSelector(
                                  title: 'Select Dropdown',
                                  value: dropdownValue3,
                                  onChanged: (newValue) {
                                    setState(() {
                                      dropdownValue3 = newValue!;
                                    });
                                  }, ItemList: [],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        VolumeIncDec(
                          volumeValue: volumeValue,
                          onChangedVolume: onChangedVolume,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CustomButton(
                              text: "Add New",
                              color: Colors.blue,
                              textColor: Colors.white,
                              onPressed: () {},
                            ),
                            CustomButton(
                              text: "Add New",
                              color: Colors.lightBlueAccent,
                              textColor: Colors.white,
                              onPressed: () {},
                            ),
                            CustomButton(
                              text: "Success",
                              color: Colors.green,
                              textColor: Colors.white,
                              onPressed: () {},
                            ),
                            CustomButton(
                              text: "Info",
                              color: Colors.lightBlue,
                              textColor: Colors.white,
                              onPressed: () {},
                            ),
                            CustomButton(
                              text: "Warning",
                              color: Colors.orange,
                              textColor: Colors.white,
                              onPressed: () {},
                            ),
                            CustomButton(
                              text: "Danger",
                              color: Colors.red,
                              textColor: Colors.white,
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
