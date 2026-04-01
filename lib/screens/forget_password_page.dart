import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:heart_disease_prediction/screens/login_page_updated.dart';
import 'package:heart_disease_prediction/screens/verification_page.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPassword();
}

class _ForgetPassword extends State<ForgetPasswordPage> {
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
                      SizedBox(height: 270),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 25,
                            height: 50,
                          ),
                          Text(
                            'Email',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      SizedBox(
                          height: 60,
                          width: 350,
                          child: TextField(
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.email),
                                hintText: 'e.g: user@domain.com',
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7)))),
                          )),
                      SizedBox(height: 50),
                      SizedBox(
                        height: 50,
                        width: 350,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return VerificationPage();
                              }));
                            },
                            child: Text(
                              'Send',
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
                            'Remember it ?',
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
                              'Login now',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xff00466B),
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 150),
                      Text(
                        '© 2024 Heart Disease Prediction',
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 200,
                color: Color(0xffD7E8F0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Reset Password',
                          style:
                              TextStyle(color: Color(0xff00466B), fontSize: 20),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Enter your email to recieve',
                          style:
                              TextStyle(color: Color(0xff6C757D), fontSize: 20),
                        ),
                        Text(
                          'your OTP!',
                          style:
                              TextStyle(color: Color(0xff6C757D), fontSize: 20),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                  width: 100,
                  height: 100,
                  top: 150,
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
