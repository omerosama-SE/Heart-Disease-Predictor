import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:heart_disease_prediction/Components/verifications_fields.dart';
import 'package:heart_disease_prediction/screens/login_page_updated.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});

  @override
  State<VerificationPage> createState() => _Verification();
}

class _Verification extends State<VerificationPage> {
  bool obsecureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: 765,
                color: Colors.white,
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(height: 220),
                      Text(
                        'Enter Verification Code',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 7),
                      Text(
                        'We\'ve sent a code to XYZ@gmail.com',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 50),
                      Row(
                        children: [
                          VerificationFields(),
                          VerificationFields(),
                          VerificationFields(),
                          VerificationFields(),
                        ],
                      ),
                      SizedBox(height: 50),
                      // Row(
                      //   children: [
                      //     SizedBox(width: 30),
                      //     SizedBox(
                      //       height: 50,
                      //       width: 150,
                      //       child: ElevatedButton(
                      //           onPressed: () {},
                      //           child: Text(
                      //             'Cancel',
                      //             style: TextStyle(
                      //                 color: Colors.black, fontSize: 20),
                      //           ),
                      //           style: ElevatedButton.styleFrom(
                      //               shape: RoundedRectangleBorder(
                      //                   borderRadius: BorderRadius.circular(7)),
                      //               backgroundColor: Colors.white,
                      //               fixedSize: Size(130, 50),
                      //               side: BorderSide())),
                      //     ),
                      //     SizedBox(width: 30),
                      //     SizedBox(
                      //       height: 50,
                      //       width: 150,
                      //       child: ElevatedButton(
                      //           onPressed: () {},
                      //           child: Text(
                      //             'Verify',
                      //             style: TextStyle(
                      //                 color: Colors.white, fontSize: 20),
                      //           ),
                      //           style: ElevatedButton.styleFrom(
                      //               shape: RoundedRectangleBorder(
                      //                   borderRadius: BorderRadius.circular(7)),
                      //               backgroundColor: Color(0xff00466B),
                      //               fixedSize: Size(130, 50),
                      //               side: BorderSide())),
                      //     ),
                      //   ],
                      // ),
                      SizedBox(
                        height: 50,
                        width: 340,
                        child: ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              'Verify',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7)),
                                backgroundColor: Color(0xff00466B),
                                fixedSize: Size(130, 50),
                                side: BorderSide())),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Didn\'t get a code ?',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(width: 15),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return LoginPageUpdated();
                              }));
                            },
                            child: Text(
                              'Resend it',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xff00466B),
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 120),
                      Text(
                        '© 2024 Heart Disease Prediction',
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 150,
                color: Color(0xffD7E8F0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Verify Password',
                          style:
                              TextStyle(color: Color(0xff00466B), fontSize: 20),
                        ),
                        // SizedBox(height: 5),
                        // Text(
                        //   'Enter verification code',
                        //   style:
                        //       TextStyle(color: Color(0xff6C757D), fontSize: 20),
                        // ),
                        // Text(
                        //   'We\'ve sent a code to xyz@gmail.com',
                        //   style:
                        //       TextStyle(color: Color(0xff6C757D), fontSize: 20),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                  width: 100,
                  height: 100,
                  top: 100,
                  left: 150,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          width: 3,
                          color: Color(0xffC1D0D8),
                        )),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50)),
                      child: Image.asset(
                          'assets/images/_31f75d3e-ef0d-4330-adca-3e9f76cdae2a-removebg.png'),
                    ),
                  ))
              // Align(
              //     alignment: Alignment.center,
              //     child: Image.asset(
              //         'assets/images/_31f75d3e-ef0d-4330-adca-3e9f76cdae2a-removebg.png'))
            ],
          ),
        ));
  }
}
