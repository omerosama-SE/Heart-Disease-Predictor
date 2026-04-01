import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:heart_disease_prediction/main.dart';
import 'package:heart_disease_prediction/screens/doctorScreens/D_Home_Page.dart';
import 'package:heart_disease_prediction/screens/forget_password_page.dart';
import 'package:heart_disease_prediction/screens/home_page.dart';
import 'package:heart_disease_prediction/screens/medicalAnalystScreens/MA_Home_Page.dart';
import 'package:heart_disease_prediction/screens/sign_up_page_updated.dart';
import 'package:simple_toast_message/simple_toast.dart';

class LoginPageUpdated extends StatefulWidget {
  const LoginPageUpdated({super.key});

  @override
  State<LoginPageUpdated> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPageUpdated> {
  final _formKey = GlobalKey<FormState>();
  String? validateEmail(String? email) {
    RegExp emailRegex = RegExp(r'^[\w\.-]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$');
    final isEmailValid = emailRegex.hasMatch(email ?? '');
    if (!isEmailValid) {
      return 'Please enter a valid email';
    }
    return null;
  }

//search method
  Future<void> search() async {
    dio.options.headers['Authorization'] = 'Bearer $globalToken';
    Response response = await dio.get(
        "http://heartdiseasepredictionapi.runasp.net/api/MedicalTest/GetMedicalTestsByEmail");
    var search = response.data['\$values'] as List;
    var ifNull;
    var ifNotNull;
    for (var item in search) {
      if (item['predicition'] == '0' || item['predicition'] == '1') {
        ifNotNull = item['predicition'];
      } else {
        ifNull = item['predicition'];
      }
    }
    if (ifNotNull == '0' || ifNotNull == '1') {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => PatientMainPageV2()),
        (Route<dynamic> route) => false,
      );
    } else if (ifNull == null) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => PatientMainPage()),
        (Route<dynamic> route) => false,
      );
    }
  }

  //search method v2
  Future<void> searchV2() async {
    dio.options.headers['Authorization'] = 'Bearer $globalToken';
    Response response = await dio.get(
        "http://heartdiseasepredictionapi.runasp.net/api/MedicalTest/GetMedicalTestsByEmail");
    var search = response.data['\$values'] as List;
    bool navigateToV2 = false;
    for (var item in search) {
      var result = item['Prediction'];
      print(result);
      if (result == 0 || result == 1) {
        navigateToV2 = true;
      }
    }
    if (navigateToV2) {
      oneOrTwo = 1;
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => PatientHomePage()),
        (Route<dynamic> route) => false,
      );
    } else {
      oneOrTwo = 2;
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => PatientMainPage()),
        (Route<dynamic> route) => false,
      );
    }
  }

  //
//Login post Method
  bool loading = false;
  var dio = Dio();
  var data;
  Response? res;
  Future<void> LoginPostMethod() async {
    Map data = {
      "Email": emailCont.text,
      "Password": passwordCont.text,
    };

    try {
      Response response = await dio.post(
        "http://heartdiseasepredictionapi.runasp.net/api/Account/Login",
        data: data,
      );
      if (response.statusCode == 200) {
        globalToken = response.data['Token'];
        roles = response.data['Roles']['\$values'][0];
        email = response.data['Email'];
        name = response.data['Name'];
        if (roles == 'User') {
          //
          await searchV2();
          //
        } else if (roles == 'Doctor') {
          Response response = await dio
              .get('http://heartdiseasepredictionapi.runasp.net/api/Doctor');
          var list = response.data['\$values'];
          for (var elment in list) {
            var possible = elment['User']['Email'];
            if (possible == email) {
              docImage = elment['User']['ProfileImg'];
            }
          }
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => DoctorHomePage()),
            (Route<dynamic> route) => false,
          );
        } else {
          Response response = await dio
              .get('http://heartdiseasepredictionapi.runasp.net/api/Lab');
          var list = response.data['\$values'];
          for (var elment in list) {
            var possible = elment['User']['Email'];
            if (possible == email) {
              labImage = elment['User']['ProfileImg'];
            }
          }
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => MedicalAnalystHomePage()),
            (Route<dynamic> route) => false,
          );
        }
        return globalToken;
      }
    } catch (e) {
      setState(() {
        CherryToast.error(
                toastPosition: Position.top,
                title: Text("Login Failed",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
                description: Text("Incorrect Email or Password",
                    style: TextStyle(color: Colors.black, fontSize: 15)),
                animationType: AnimationType.fromRight,
                animationDuration: Duration(milliseconds: 1000),
                autoDismiss: true)
            .show(context);
      });
    } finally {
      // why! because the finally run even the try or catch failed or success
      setState(() {
        loading = false;
      });
    }
  }

  bool obsecureText = true;
  TextEditingController emailCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              // height: 765,
              height: height,
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: height * 0.35),
                      SizedBox(
                          height: height * 0.08,
                          width: width * 0.95,
                          child: TextFormField(
                            cursorColor: Color(0xff00466D),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: validateEmail,
                            controller: emailCont,
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff00466D)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7))),
                                prefixIcon: Icon(Icons.email),
                                hintText: 'Enter Your Email Address',
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7)))),
                          )),
                      Spacer(flex: 2),
                      SizedBox(
                          height: height * 0.08,
                          width: width * 0.95,
                          child: TextFormField(
                            cursorColor: Color(0xff00466D),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) => value!.isEmpty
                                ? 'Please enter your password'
                                : null,
                            controller: passwordCont,
                            obscureText: obsecureText,
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff00466D)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7))),
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
                      Spacer(flex: 3),
                      Row(
                        children: [
                          Spacer(flex: 12),
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
                                  // decoration: TextDecoration.underline,
                                ),
                              )),
                          Spacer(flex: 1),
                        ],
                      ),
                      Spacer(flex: 8),
                      SizedBox(
                        height: 50,
                        // width: 350,
                        width: width * 0.95,
                        child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                LoginPostMethod();
                              }
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
                      Spacer(flex: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account ?',
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
                                // decoration: TextDecoration.underline
                              ),
                            ),
                          ),
                        ],
                      ),
                      Spacer(flex: 100),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: height * 0.24,
              color: Color(0xffD7E8F0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome Back !',
                        style: TextStyle(
                            color: Color(0xff00466B),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: height * 0.008),
                      Text(
                        'Sign in to countinue',
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
                top: width * 0.39,
                left: width * 0.39,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        width: 3,
                        color: const Color(0xffC1D0D8),
                      )),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50)),
                    child: Image.asset(
                        'assets/images/_31f75d3e-ef0d-4330-adca-3e9f76cdae2a-removebg.png'),
                  ),
                )),
            loading == true ? LoadingIndicator() : SizedBox()
          ],
        ));
  }
}

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.black.withOpacity(0.3), // Semi-transparent background
          child: Column(
            children: [
              Spacer(flex: 1),
              CircularProgressIndicator(
                color: Color(0xff00466D),
              ),
              Spacer(flex: 1),
            ],
          ),
        ),
      ],
    );
  }
}
