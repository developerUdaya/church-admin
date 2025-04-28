import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Widgets/CustomButtons.dart';
import '../Widgets/ToastButton.dart';
import '../Widgets/TitleRow.dart';

class Toastpage extends StatefulWidget {
  const Toastpage({super.key});

  @override
  State<Toastpage> createState() => _ToastpageState();
}

class _ToastpageState extends State<Toastpage> {
  bool isDefaultToast = true;
  void onPressedDefaultToast() {
    setState(() {
      isDefaultToast = !isDefaultToast;
    });
  }

  bool isButtonToast = true;
  void onPressedButtonToast() {
    setState(() {
      isButtonToast = !isButtonToast;
    });
  }

  bool isColorToast = true;
  void onPressedColorToast() {
    setState(() {
      isColorToast = !isColorToast;
    });
  }

  bool isColorToast1 = true;
  void onPressedColorToast1() {
    setState(() {
      isColorToast1 = !isColorToast1;
    });
  }

  bool isColorToast2 = true;
  void onPressedColorToast2() {
    setState(() {
      isColorToast2 = !isColorToast2;
    });
  }

  bool isToggleToast = false;
  void onPressedToggleToast() {
    setState(() {
      isToggleToast = !isToggleToast;
    });
  }

  bool isDefaultToast1 = true;
  void onPressedDefaultToast1() {
    setState(() {
      isDefaultToast1 = !isDefaultToast1;
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
            TitleRow(title: 'Toast'),
            SizedBox(height: 30),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //row 1
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          padding: EdgeInsets.all(30),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Default Toast',
                                style: GoogleFonts.manrope(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 20),
                              isDefaultToast
                                  ? ToastButton(
                                icon: Icons.local_fire_department,
                                iconColor: Color(0xff635bff),
                                iconBackgroundColor: Color(0xffcffbfd),
                                text: 'Set yourself free.',
                                haveIcon: true,
                                haveUndo: false,
                                onPressed: onPressedDefaultToast,
                              )
                                  : SizedBox()
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 30),
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          padding: EdgeInsets.all(30),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Toast with Button',
                                style: GoogleFonts.manrope(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 20),
                              isButtonToast
                                  ? ToastButton(
                                icon: Icons.local_fire_department,
                                iconColor: Color(0xff635bff),
                                iconBackgroundColor: Color(0xffcffbfd),
                                text: 'Conversation archived.',
                                haveIcon: false,
                                haveUndo: true,
                                onPressed: onPressedButtonToast,
                              )
                                  : SizedBox()
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 30),
                  //row 2
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          padding: EdgeInsets.all(30),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Interactive Toast',
                                style: GoogleFonts.manrope(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 20),
                              Container(
                                width: 320,
                                //height: 120,
                                padding: EdgeInsets.all(14),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.25),
                                      blurRadius: 5,
                                      spreadRadius: 1,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                  border: Border.all(
                                      color: Colors.grey.withOpacity(0.2)),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Color(0xffcffbfd),
                                      ),
                                      padding: EdgeInsets.all(6),
                                      child: Icon(
                                        Icons.repeat_rounded,
                                        color: Color(0xff635bff),
                                        size: 24,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Update available',
                                            style: GoogleFonts.manrope(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            "A new software version is available for download.A new software version is available for download.A new software version is available for download.A new software version is available for download.",
                                            style: GoogleFonts.manrope(
                                              fontSize: 14,
                                              color: Color(0xff6b7280),
                                            ),
                                            softWrap: true,
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              CustomButton(
                                                text: 'Update',
                                                color: Color(0xff635bff),
                                                textColor: Colors.white,
                                                onPressed: () => {},
                                              ),
                                              SizedBox(width: 10),
                                              CustomButton(
                                                text: 'Not now',
                                                color: Colors.white,
                                                textColor: Color(0xff6b7280),
                                                onPressed: () => {},
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 30),
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          padding: EdgeInsets.all(30),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Toast Colors',
                                style: GoogleFonts.manrope(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 20),
                              Column(
                                children: [
                                  isColorToast
                                      ?
                                  ToastButton(
                                    icon: Icons.check,
                                    iconColor: Colors.green,
                                    iconBackgroundColor:
                                    Colors.green.withOpacity(0.1),
                                    text: 'Item moved successfully.',
                                    haveIcon: true,
                                    haveUndo: false,
                                    onPressed: onPressedColorToast,
                                  ) : SizedBox(),
                                  SizedBox(height: 10),
                                  isColorToast1
                                      ?
                                  ToastButton(
                                    icon: Icons.close,
                                    iconColor: Colors.red,
                                    iconBackgroundColor:
                                    Colors.red.withOpacity(0.1),
                                    text: 'Item has been deleted.',
                                    haveIcon: true,
                                    haveUndo: false,
                                    onPressed: onPressedColorToast1,
                                  ) : SizedBox(),
                                  SizedBox(height: 10),
                                  isColorToast2
                                      ?
                                  ToastButton(
                                    icon: Icons.warning,
                                    iconColor: Colors.orange,
                                    iconBackgroundColor:
                                    Colors.orange.withOpacity(0.1),
                                    text: 'Improve password difficulty.',
                                    haveIcon: true,
                                    haveUndo: false,
                                    onPressed: onPressedColorToast2,
                                  ) : SizedBox(),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 30),
                  //row 3
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          padding: EdgeInsets.all(30),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Feedback Toast',
                                style: GoogleFonts.manrope(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 20),
                              Container(
                                height: 50,
                                width: 320,
                                padding: EdgeInsets.all(14),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.25),
                                      blurRadius: 5,
                                      spreadRadius: 1,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                  border: Border.all(
                                      color: Colors.grey.withOpacity(0.2)),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.telegram,
                                      color: Color(0xff635bff),
                                      size: 24,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      'Message sent successfully.',
                                      style: GoogleFonts.manrope(
                                        fontSize: 14,
                                        //fontWeight: FontWeight.w800,
                                        color: Color(0xff6b7280),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 30),
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          padding: EdgeInsets.all(30),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Dismissal Toast',
                                style: GoogleFonts.manrope(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 20),
                              CustomButton(
                                text: 'Toggle toast',
                                color: Color(0xff635bff),
                                textColor: Colors.white,
                                onPressed: onPressedToggleToast,
                              ),
                              if (isToggleToast) ...{
                                SizedBox(
                                  height: 20,
                                ),
                                isDefaultToast1
                                    ?
                                ToastButton(
                                  icon: Icons.local_fire_department,
                                  iconColor: Color(0xff635bff),
                                  iconBackgroundColor: Color(0xffcffbfd),
                                  text: 'Set yourself free.',
                                  haveIcon: true,
                                  haveUndo: false,
                                  onPressed: onPressedDefaultToast1,
                                ) : SizedBox()
                              }
                            ],
                          ),
                        ),
                      )
                    ],
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
