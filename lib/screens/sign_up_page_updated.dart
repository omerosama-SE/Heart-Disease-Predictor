import 'dart:convert';
import 'dart:math';

import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:heart_disease_prediction/Components/sign_up_fields.dart';
import 'package:heart_disease_prediction/screens/doctorScreens/D_Home_Page.dart';
import 'package:heart_disease_prediction/screens/home_page.dart';
import 'package:heart_disease_prediction/screens/login_page_updated.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:simple_toast_message/simple_toast.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _SignUp();
}

class _SignUp extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  var dio = Dio();

  Future<void> RegisterPostMethod() async {
    Map data = {
      "FirstName": firstNameController.text,
      "LastName": lastNameController.text,
      "Gender": maleORfemale,
      "SSN": ssnController.text,
      "PhoneNumber": phoneController.text,
      "BirthDate": dateOfBirthController.text,
      "Email": emailController.text,
      "Password": passwordController.text,
      "ConfirmPassword": passwordController.text
    };

    try {
      Response response = await dio.post(
          "http://heartdiseasepredictionapi.runasp.net/api/Account/registerPatient",
          data: data,
          options: Options(headers: {
            'Content-Type': 'application/json',
          }));

      if (response.statusCode == 200) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => PatientMainPage()), // Navigate to HomePage
          (Route<dynamic> route) => false, // Rmove all other pages
        );
      }
    } catch (e) {
      CherryToast.error(
              toastPosition: Position.top,
              title: Text("Registration Failed",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              description: Text("Email or SSN is already exists",
                  style: TextStyle(color: Colors.black, fontSize: 15)),
              animationType: AnimationType.fromRight,
              animationDuration: Duration(milliseconds: 1000),
              autoDismiss: true)
          .show(context);
    } finally {
      _hideLoadingIndicator();
    }
  }

  @override
  bool obsecureText = true;
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController ssnController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? firstNameErr;
  String? lastNameErr;
  String? ssnErr;
  String? emailErr;
  String? passwordErr;
  String? dateOfBirthErr;

  int maleORfemale = -1;

  OverlayEntry? _overlayEntry;

  void _showLoadingIndicator() {
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 0,
        left: 0,
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black.withOpacity(0.3),
            child: Column(children: [
              Spacer(flex: 1),
              CircularProgressIndicator(color: Color(0xff00466D)),
              Spacer(flex: 1),
            ])),
      ),
    );

    Overlay.of(context)?.insert(_overlayEntry!);
  }

  void _hideLoadingIndicator() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  // void register() {
  //   setState(() {
  //     firstNameErr = firstNameController.text.isEmpty ? 'Required' : null;
  //     lastNameErr = lastNameController.text.isEmpty ? 'Required' : null;
  //     ssnErr = ssnController.text.isEmpty ? 'Required' : null;
  //     emailErr = emailController.text.isEmpty ? 'Required' : null;
  //     passwordErr = passwordController.text.isEmpty ? 'Required' : null;
  //     dateOfBirthErr = dateOfBirthController.text.isEmpty ? 'Required' : null;
  //   });
  // }

  String? validateEmail(String? email) {
    RegExp emailRegex = RegExp(r'^[\w\.-]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$');
    final isEmailValid = emailRegex.hasMatch(email ?? '');
    if (!isEmailValid) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? password) {
    RegExp passwordRegex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[^a-zA-Z0-9]).{8,}$');
    final isPasswordValid = passwordRegex.hasMatch(password ?? '');
    if (!isPasswordValid) {
      return 'Please enter a valid password';
    }
    return null;
  }

  final borderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      borderSide: BorderSide(color: Colors.grey, width: 1.5));
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        // resizeToAvoidBottomInset: true,
        backgroundColor: Color(0xffD7E8F0),
        body: Column(
          children: [
            Container(
              height: height * 0.16,
              color: Color(0xffD7E8F0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Spacer(flex: 1),
                  Column(
                    children: [
                      Spacer(flex: 1),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                              width: 3,
                              color: Color(0xffC1D0D8),
                            )),
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50)),
                          child: Image.asset(
                              'assets/images/_31f75d3e-ef0d-4330-adca-3e9f76cdae2a-removebg.png'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: width * 0.04),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30),
                      Text(
                        'Register',
                        style: TextStyle(
                            color: Color(0xff00466B),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Get your Account now',
                        style:
                            TextStyle(color: Color(0xff6C757D), fontSize: 20),
                      ),
                    ],
                  ),
                  Spacer(flex: 8),
                ],
              ),
            ),
            SizedBox(height: height * 0.01),
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _formKey,
                  child: Container(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: Offset(0, -3), // changes position of shadow
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    height: height * 0.83,
                    width: width,
                    child: Column(
                      children: [
                        // Spacer(flex: 2),
                        SizedBox(height: height * 0.02),
                        SignUpFields(
                          text: 'First Name',
                          controller: firstNameController,
                          // errorText: firstNameErr,
                          validator: (value) => value!.length < 3
                              ? 'Name must be at least 3 digits'
                              : null,
                        ),
                        SignUpFields(
                          text: 'Last Name',
                          controller: lastNameController,
                          // errorText: lastNameErr,
                          validator: (value) => value!.length < 3
                              ? 'Name must be at least 3 digits'
                              : null,
                        ),
                        SignUpFields(
                          text: 'SSN',
                          controller: ssnController,
                          // errorText: ssnErr,
                          numFields: TextInputType.number,
                          validator: (value) => value!.length < 14
                              ? 'SSN must be 14 digits'
                              : null,
                        ),
                        SignUpFields(
                          text: 'Phone number',
                          controller: phoneController,
                          // errorText: ssnErr,
                          numFields: TextInputType.number,
                          validator: (value) => value!.length < 11
                              ? 'Phone must be 11 digits'
                              : null,
                        ),
                        SignUpFields(
                          text: 'Email',
                          controller: emailController,
                          // errorText: emailErr,
                          validator: validateEmail,
                        ),
                        SignUpFields(
                          text: 'Password',
                          controller: passwordController,
                          // errorText: passwordErr
                          validator: validatePassword,
                        ),
                        SizedBox(
                          height: height * 0.08,
                          width: width * 0.95,
                          child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) => value!.isEmpty
                                  ? 'Please Enter your Birth Date'
                                  : null,
                              readOnly: true,
                              controller: dateOfBirthController,
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                      onPressed: () => _selectDate(context),
                                      icon: Icon(Icons.date_range)),
                                  contentPadding: EdgeInsets.only(left: 30),
                                  labelText: 'Date Of Birth',
                                  border: borderStyle,
                                  focusedBorder: borderStyle,
                                  enabledBorder: borderStyle,
                                  errorText: dateOfBirthErr)),
                        ),
                        // Spacer(flex: 1),
                        SizedBox(height: height * 0.01),
                        Row(
                          children: [
                            Spacer(flex: 1),
                            Text(
                              'Gender',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                            Spacer(flex: 5),
                            SizedBox(
                              height: 35,
                              width: 90,
                              child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      maleORfemale = 1;
                                      print(maleORfemale);
                                    });
                                  },
                                  child: Text(
                                    'Male',
                                    style: TextStyle(
                                        color: maleORfemale == 1
                                            ? Colors.white
                                            : Color(0xff00466B),
                                        fontSize: 15),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(7)),
                                      backgroundColor: maleORfemale == 1
                                          ? Color(0xff00466B)
                                          : Color(0xffD7E8F0),
                                      fixedSize: Size(130, 50),
                                      side: BorderSide(
                                          color: Color(0xff00466B)))),
                            ),
                            SizedBox(width: width * 0.02),
                            SizedBox(
                              height: 35,
                              width: 100,
                              child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      maleORfemale = 0;
                                      print(maleORfemale);
                                    });
                                  },
                                  child: Text(
                                    'Female',
                                    style: TextStyle(
                                        color: maleORfemale == 0
                                            ? Colors.white
                                            : Color(0xff00466B),
                                        fontSize: 15),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(7)),
                                      backgroundColor: maleORfemale == 0
                                          ? Color(0xff00466B)
                                          : Color(0xffD7E8F0),
                                      fixedSize: Size(130, 50),
                                      side: BorderSide(
                                          color: Color(0xff00466B)))),
                            ),
                            Spacer(flex: 1),
                          ],
                        ),
                        SizedBox(height: height * 0.03),
                        SizedBox(
                          height: 50,
                          width: width * 0.95,
                          child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate() &&
                                        maleORfemale == 1 ||
                                    maleORfemale == 0) {
                                  _showLoadingIndicator();
                                  RegisterPostMethod();
                                }
                              },
                              child: Text(
                                'Register',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7)),
                                  backgroundColor: Color(0xff00466B),
                                  fixedSize: Size(130, 50),
                                  side: BorderSide())),
                        ),
                        SizedBox(height: height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account?',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(width: width * 0.04),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return LoginPageUpdated();
                                }));
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xff00466B),
                                  // decoration: TextDecoration.underline
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Spacer(flex: 2),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());

    if (picked != null) {
      setState(() {
        dateOfBirthController.text = picked.toString().split(" ")[0];
      });
    }
  }
}
