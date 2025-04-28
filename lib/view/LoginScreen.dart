import 'package:church_admin/CustomColors.dart';
import 'package:church_admin/Widgets/CustomButtons.dart';
import 'package:church_admin/Widgets/TextFieldForms.dart';
import 'package:church_admin/view/IKIAAdminPanel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: LoginScreen(),
//     );
//   }
// }

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController passwordController =
      TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              primaryBlue,
              Colors.white,
            ],
          ),
        ),
        child: Center(
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 800) {
                // Web layout
                return Container(
                  width: 800,
                  height: 460,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 20),
                              Center(
                                  child: Text('Let’s get you',
                                      style: GoogleFonts.manrope(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold))),
                              SizedBox(height: 10),
                              Center(
                                  child: Text('sign in with email',
                                      style:
                                          GoogleFonts.manrope(fontSize: 18))),
                              SizedBox(height: 20),
                              Textfieldforms(
                                hint: 'Enter your email',
                                title: 'Email Address',
                                isBlocked: false,
                                isController: emailController,
                              ),
                              SizedBox(height: 10),
                              Textfieldforms(
                                hint: 'Enter your password',
                                title: 'Password',
                                isBlocked: false,
                                isController: passwordController,
                              ),
                              SizedBox(height: 10),
                              Center(
                                child: Text(
                                  'By Signing in you are agreeing to our Terms of Service and Privacy Policy',
                                  style:
                                      GoogleFonts.manrope(color: Colors.grey),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(height: 10),
                              Center(
                                child: CustomButton(
                                  onPressed: () {
                                    if (emailController.text ==
                                            'test@gmail.com' &&
                                        passwordController.text == '123456') {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //       builder: (context) =>
                                      //           IkiaAdminPanel()),
                                      Navigator.pushNamed(
                                          context, '/ikiaAdminPanel');
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Invalid email or password')),
                                      );
                                    }
                                  },
                                  color: primaryBlue,
                                  text: 'Login',
                                  textColor: Colors.white,
                                ),
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                      VerticalDivider(),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('ar-logo.png',
                                  width: 150, height: 150, fit: BoxFit.fill),
                              SizedBox(height: 20),
                              Text('Church Management System',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: 10),
                              Text(
                                'powered by AR Digital Solutions',
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                // Mobile layout
                return SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Column(
                            children: [
                              Image.asset('ar-logo.png',
                                  width: 150, height: 150, fit: BoxFit.fill),
                              Text('Church Management System',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: 4),
                              Text(
                                'powered by AR Digital Solutions',
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Center(
                            child: Text('Let’s get you',
                                style: GoogleFonts.manrope(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold))),
                        SizedBox(height: 10),
                        Center(
                            child: Text('sign in with email',
                                style: GoogleFonts.manrope(fontSize: 18))),
                        SizedBox(height: 20),
                        Textfieldforms(
                          hint: 'Enter your email',
                          title: 'Email Address',
                          isBlocked: false,
                          isController: emailController,
                        ),
                        SizedBox(height: 10),
                        Textfieldforms(
                          hint: 'Enter your password',
                          title: 'Password',
                          isBlocked: false,
                          isController: passwordController,
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: Text(
                            'By Signing in you are agreeing to our Terms of Service and Privacy Policy',
                            style: GoogleFonts.manrope(color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: CustomButton(
                            onPressed: () {
                              if (emailController.text == 'test@gmail.com' &&
                                  passwordController.text == '123456') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => IkiaAdminPanel()),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text('Invalid email or password')),
                                );
                              }
                            },
                            color: primaryBlue,
                            text: 'Login',
                            textColor: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
