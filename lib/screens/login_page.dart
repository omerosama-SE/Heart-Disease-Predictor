import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:heart_disease_prediction/screens/Sign_Up.dart';
import 'package:heart_disease_prediction/screens/forget_password_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  bool obsecureText = true;
  Widget build(BuildContext context) {
    final borderStyle = OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xff00466B), width: 1.5),
        borderRadius: BorderRadius.all(Radius.circular(50)));

    return Scaffold(
      backgroundColor: Color(0xffD7E8F0),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 250,
                width: 400,
                child: Image.asset(
                    'assets/images/_31f75d3e-ef0d-4330-adca-3e9f76cdae2a-removebg.png'),
              ),
              Text(
                'Sign in',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff004670)),
              ),
              SizedBox(
                height: 35,
              ),
              // Text(
              //   'Email',
              //   style: TextStyle(
              //       fontSize: 20,
              //       fontWeight: FontWeight.w400,
              //       color: Color(0xff004670)),
              // ),
              SizedBox(
                  height: 80,
                  width: 350,
                  child: TextField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        hintText: 'Enter Your Email Address',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50)))),
                  )),
              // Text(
              //   'Password',
              //   style: TextStyle(
              //       fontSize: 20,
              //       fontWeight: FontWeight.w400,
              //       color: Color(0xff004670)),
              // ),
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
                                BorderRadius.all(Radius.circular(50)))),
                  )),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ForgetPasswordPage();
                  }));
                },
                child: Text(
                  'Forget Password?',
                  style: TextStyle(
                      color: Color(0xff00466B),
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.underline),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff00466B),
                      fixedSize: Size(130, 50))),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('New Account?'),
                  SizedBox(width: 15),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return SignUp();
                      }));
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                          color: Color(0xff00466B),
                          fontStyle: FontStyle.italic,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
