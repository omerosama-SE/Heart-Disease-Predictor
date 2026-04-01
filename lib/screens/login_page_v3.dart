import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:heart_disease_prediction/screens/forget_password_page.dart';
import 'package:heart_disease_prediction/screens/home_page.dart';
import 'package:heart_disease_prediction/screens/sign_up_page_updated.dart';

class LoginPageV3 extends StatefulWidget {
  const LoginPageV3({super.key});

  @override
  State<LoginPageV3> createState() => _LoginPageState3();
}

class _LoginPageState3 extends State<LoginPageV3> {
  bool obsecureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                height: 765,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 270),
                      SizedBox(
                          height: 80,
                          width: 350,
                          child: TextField(
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.email),
                                hintText: 'Enter Your Email Address',
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7)))),
                          )),
                      SizedBox(height: 10),
                      SizedBox(
                          height: 80,
                          width: 350,
                          child: TextField(
                            obscureText: obsecureText,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        obsecureText = !obsecureText;
                                      });
                                    },
                                    icon: Icon(obsecureText
                                        ? Icons.visibility
                                        : Icons.visibility_off)),
                                hintText: 'Enter Your Password',
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7)))),
                          )),
                      SizedBox(height: 30),
                      SizedBox(
                        height: 50,
                        width: 350,
                        child: ElevatedButton(
                            onPressed: () {
                              // Navigator.push(context,
                              //     MaterialPageRoute(builder: (context) {
                              //   return HomePage();
                              // }));
                            },
                            child: Text(
                              'Login',
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
                        height: 30,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ForgetPasswordPage();
                            }));
                          },
                          child: Text(
                            'Forget Password?',
                            style: TextStyle(
                              color: Color(0xff00466B),
                              decoration: TextDecoration.underline,
                            ),
                          )),
                      SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'New Account ?',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(width: 15),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return Register();
                              }));
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xff00466B),
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Text(
                        '© 2024 Heart Disease Prediction',
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 100,
                color: Color(0xffD7E8F0),
              ),
              Positioned(
                  width: 100,
                  height: 100,
                  top: 50,
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
