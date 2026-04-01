import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:heart_disease_prediction/Components/sign_up_fields.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _LoginPageState();
}

class _LoginPageState extends State<SignUp> {
  @override
  bool obsecureText = true;
  final borderStyle = OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xff00466B), width: 1.5),
      borderRadius: BorderRadius.all(Radius.circular(50)));

  int? selectedRadio = 0;
  TextEditingController _dataConroller = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffD7E8F0),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              width: 300,
              child: Column(
                children: [
                  Text(
                    'Create An Account',
                    style: TextStyle(
                        fontSize: 20,
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
                  // SignUpFields(text: 'First Name'),
                  // //SignUpFields(text: 'Sur Name'),
                  // SignUpFields(text: 'Last Name'),
                  // SignUpFields(text: 'Username'),
                  // SignUpFields(text: 'Email'),
                  // SignUpFields(text: 'Password'),
                  //SignUpFields(text: 'Confirm Password'),
                  TextField(
                      readOnly: true,
                      controller: _dataConroller,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () => _selectDate(context),
                              icon: Icon(Icons.date_range)),
                          contentPadding: EdgeInsets.only(left: 30),
                          labelText: 'Date Of Birth',
                          border: borderStyle,
                          focusedBorder: borderStyle,
                          enabledBorder: borderStyle)),
                  // Text(
                  //   'Password',
                  //   style: TextStyle(
                  //       fontSize: 20,
                  //       fontWeight: FontWeight.w400,
                  //       color: Color(0xff004670)),
                  // )
                  SizedBox(height: 15),
                  Row(children: [
                    Text(
                      'Gender',
                      style: TextStyle(fontSize: 20, color: Color(0xff61616A)),
                    ),
                    SizedBox(width: 20),
                    Radio(
                        activeColor: Color(0xff00466B),
                        value: 1,
                        groupValue: selectedRadio,
                        onChanged: (value) {
                          setState(() {
                            selectedRadio = value;
                          });
                        }),
                    Text(
                      'Male',
                      style: TextStyle(fontSize: 15, color: Color(0xff61616A)),
                    ),
                    SizedBox(width: 10),
                    Radio(
                        activeColor: Color(0xff00466B),
                        value: 2,
                        groupValue: selectedRadio,
                        onChanged: (value) {
                          setState(() {
                            selectedRadio = value;
                          });
                        }),
                    Text(
                      'Female',
                      style: TextStyle(fontSize: 15, color: Color(0xff61616A)),
                    ),
                  ]),
                  // Row(
                  //   children: [
                  //     Text(
                  //       'Gender',
                  //       style:
                  //           TextStyle(fontSize: 20, color: Color(0xff61616A)),
                  //     ),
                  //     SizedBox(width: 20),
                  //     ElevatedButton(
                  //       onPressed: () {},
                  //       child: Text(
                  //         'Male',
                  //         style: TextStyle(color: Colors.white),
                  //       ),
                  //       style: ElevatedButton.styleFrom(
                  //           backgroundColor: Color(0xff00466B),
                  //           fixedSize: Size(100, 30)),
                  //     ),
                  //     SizedBox(width: 10),
                  //     ElevatedButton(
                  //       onPressed: () {},
                  //       child: Text(
                  //         'Female',
                  //         style: TextStyle(color: Colors.white),
                  //       ),
                  //       style: ElevatedButton.styleFrom(
                  //           backgroundColor: Color(0xff00466B),
                  //           fixedSize: Size(100, 30)),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff00466B),
                          fixedSize: Size(130, 50))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());

    if (picked != null) {
      setState(() {
        _dataConroller.text = picked.toString().split(" ")[0];
      });
    }
  }
}
