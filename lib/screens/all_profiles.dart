import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:heart_disease_prediction/Components/sign_up_fields.dart';
import 'package:heart_disease_prediction/Components/user_profile_cards.dart';
import 'package:heart_disease_prediction/main.dart';
import 'package:heart_disease_prediction/screens/appoitments.dart';
import 'package:heart_disease_prediction/screens/prescriptions.dart';
import 'package:heart_disease_prediction/screens/welcome_page.dart';

//patient profile
class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool obsecureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF0F4F7),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 115,
            decoration: BoxDecoration(color: Color(0xffD7E8F0)),
            child: Padding(
              padding: const EdgeInsets.only(left: 15, top: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome! $name',
                    style: TextStyle(fontFamily: 'Myriad', fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Text(
                    //database
                    '$email',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 15),
                      Text(
                        'My Profile',
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              )),
          SizedBox(height: 10),
          Container(
            width: double.infinity,
            height: 230,
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: MyProfileThings(
                    img: 'assets/images/user011.png',
                    title: 'My Account',
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return MyAccount();
                      }));
                    },
                  ),
                ),
                SizedBox(height: 5),
                Divider(
                  indent: 10,
                  endIndent: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: MyProfileThings(
                    img: 'assets/images/medical-prescription (1).png',
                    title: 'Prescriptions',
                    onTap: () {},
                  ),
                ),
                SizedBox(height: 5),
                Divider(
                  indent: 10,
                  endIndent: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: MyProfileThings(
                    img: 'assets/images/chemical-analysis.png',
                    title: 'Medical Tests',
                    onTap: () {},
                  ),
                ),
                SizedBox(height: 5),
                Divider(
                  indent: 10,
                  endIndent: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: MyProfileThings(
                    img: 'assets/images/medical-report (1).png',
                    title: 'Predictions',
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 15),
                      Text(
                        'Settings',
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              )),
          SizedBox(height: 10),
          Container(
            width: double.infinity,
            height: 115,
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: MyProfileThings(
                    img: 'assets/images/letter-a.png',
                    title: 'App Language',
                    onTap: () {},
                  ),
                ),
                SizedBox(height: 5),
                Divider(
                  indent: 10,
                  endIndent: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: MyProfileThings(
                    img: 'assets/images/logout.png',
                    title: 'Logout',
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => WelcomePage()),
                        (Route<dynamic> route) => false,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// doctor profile
class DoctorProfile extends StatefulWidget {
  const DoctorProfile({super.key});

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  bool obsecureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF0F4F7),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 115,
            decoration: BoxDecoration(color: Color(0xffD7E8F0)),
            child: Padding(
              padding: const EdgeInsets.only(left: 15, top: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome! Username',
                    style: TextStyle(fontFamily: 'Myriad', fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Text(
                    //database
                    '$email',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 15),
                      Text(
                        'My Profile',
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              )),
          SizedBox(height: 10),
          Container(
            width: double.infinity,
            height: 230,
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: MyProfileThings(
                    img: 'assets/images/user011.png',
                    title: 'My Account',
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return MyAccount();
                      }));
                    },
                  ),
                ),
                SizedBox(height: 5),
                Divider(
                  indent: 10,
                  endIndent: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: MyProfileThings(
                    img: 'assets/images/medical-prescription (1).png',
                    title: 'Prescriptions',
                    onTap: () {},
                  ),
                ),
                SizedBox(height: 5),
                Divider(
                  indent: 10,
                  endIndent: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: MyProfileThings(
                    img: 'assets/images/chemical-analysis.png',
                    title: 'Medical Tests',
                    onTap: () {},
                  ),
                ),
                SizedBox(height: 5),
                Divider(
                  indent: 10,
                  endIndent: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: MyProfileThings(
                    img: 'assets/images/medical-report (1).png',
                    title: 'Predictions',
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 15),
                      Text(
                        'Settings',
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              )),
          SizedBox(height: 10),
          Container(
            width: double.infinity,
            height: 115,
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: MyProfileThings(
                    img: 'assets/images/letter-a.png',
                    title: 'App Language',
                    onTap: () {},
                  ),
                ),
                SizedBox(height: 5),
                Divider(
                  indent: 10,
                  endIndent: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: MyProfileThings(
                    img: 'assets/images/logout.png',
                    title: 'Logout',
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => WelcomePage()),
                        (Route<dynamic> route) => false,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//Medical Analyst Profile
class MedicalAnalystProfille extends StatefulWidget {
  const MedicalAnalystProfille({super.key});

  @override
  State<MedicalAnalystProfille> createState() => _MedicalAnalystProfileState();
}

class _MedicalAnalystProfileState extends State<MedicalAnalystProfille> {
  bool obsecureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF0F4F7),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 115,
            decoration: BoxDecoration(color: Color(0xffD7E8F0)),
            child: Padding(
              padding: const EdgeInsets.only(left: 15, top: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome! Username',
                    style: TextStyle(fontFamily: 'Myriad', fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Text(
                    //database
                    'username12@gmail.com',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 15),
                      Text(
                        'My Profile',
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              )),
          SizedBox(height: 10),
          Container(
            width: double.infinity,
            height: 230,
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: MyProfileThings(
                    img: 'assets/images/user011.png',
                    title: 'My Account',
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return MyAccount();
                      }));
                    },
                  ),
                ),
                SizedBox(height: 5),
                Divider(
                  indent: 10,
                  endIndent: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: MyProfileThings(
                    img: 'assets/images/medical-prescription (1).png',
                    title: 'Prescriptions',
                    onTap: () {},
                  ),
                ),
                SizedBox(height: 5),
                Divider(
                  indent: 10,
                  endIndent: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: MyProfileThings(
                    img: 'assets/images/chemical-analysis.png',
                    title: 'Medical Tests',
                    onTap: () {},
                  ),
                ),
                SizedBox(height: 5),
                Divider(
                  indent: 10,
                  endIndent: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: MyProfileThings(
                    img: 'assets/images/medical-report (1).png',
                    title: 'Predictions',
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 15),
                      Text(
                        'Settings',
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              )),
          SizedBox(height: 10),
          Container(
            width: double.infinity,
            height: 115,
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: MyProfileThings(
                    img: 'assets/images/letter-a.png',
                    title: 'App Language',
                    onTap: () {},
                  ),
                ),
                SizedBox(height: 5),
                Divider(
                  indent: 10,
                  endIndent: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: MyProfileThings(
                    img: 'assets/images/logout.png',
                    title: 'Logout',
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => WelcomePage()),
                        (Route<dynamic> route) => false,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyProfileThings extends StatelessWidget {
  MyProfileThings(
      {required this.onTap, required this.img, required this.title});

  void Function()? onTap;
  String img;
  String title;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Row(
          children: [
            SizedBox(
              width: 30,
              height: 30,
              child: Image.asset(img),
            ),
            SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Spacer(flex: 20),
            Icon(
              Icons.chevron_right_rounded,
              // size: 25,
            ),
            Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  int isEdit = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF0F4F7),
      appBar: AppBar(
        backgroundColor: Color(0xffD7E8F0),
        title: Text(
          'Account Details',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        leadingWidth: 30,
        actions: [
          TextButton(
              onPressed: () {
                setState(() {
                  isEdit = 0;
                });
              },
              child: Text(
                isEdit == 1 ? 'EDIT' : 'SAVE',
                style: TextStyle(color: Color(0xff00466D)),
              ))
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Container(
            width: double.infinity,
            height: 400,
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              children: [
                SizedBox(height: 5),
                EditProfile(name: 'First name*', sizeW: 370, sizeH: 47),
                SizedBox(height: 5),
                EditProfile(name: 'Last name*', sizeW: 370, sizeH: 47),
                SizedBox(height: 5),
                EditProfile(name: 'SSN*', sizeW: 370, sizeH: 47),
                SizedBox(height: 5),
                EditProfile(name: 'Phone number*', sizeW: 370, sizeH: 47),
                SizedBox(height: 5),
                EditProfile(name: 'Email*', sizeW: 370, sizeH: 47),
                SizedBox(height: 5),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EditProfile extends StatefulWidget {
  EditProfile({required this.name, required this.sizeH, required this.sizeW});
  String name;
  double sizeW;
  double sizeH;
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.sizeW,
      height: widget.sizeH,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(7)),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 15),
              Text(
                widget.name,
                style: TextStyle(fontSize: 10),
              ),
            ],
          ),
          SizedBox(height: 10),
          SizedBox(
              width: 350,
              height: 20,
              child: TextFormField(
                cursorColor: Color(0xff00466D),
                cursorHeight: 20,
                decoration: InputDecoration(border: InputBorder.none),
              ))
        ],
      ),
    );
  }
}
