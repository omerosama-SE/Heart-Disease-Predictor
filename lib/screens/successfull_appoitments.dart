import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:heart_disease_prediction/main.dart';
import 'package:heart_disease_prediction/models/doctor_profile_model.dart';
import 'package:heart_disease_prediction/models/lab_profile_model.dart';
import 'package:heart_disease_prediction/screens/home_page.dart';
import 'package:heart_disease_prediction/screens/view_appoitments_page.dart';

class SuccefullAppoitments extends StatelessWidget {
  SuccefullAppoitments(
      {this.docProfile,
      this.labProfile,
      required this.SelectedDate,
      required this.SelectedTime});

  DoctorProfileModel? docProfile;
  LabProfileModel? labProfile;
  String SelectedDate;
  String SelectedTime;

  @override
  Widget build(BuildContext context) {
    String name;
    String location;
    String price;

    if (docProfile != null) {
      name =
          'Dr. ${docProfile!.name.split(" ").map((str) => str[0].toUpperCase() + str.substring(1)).join(" ")}';
      location = docProfile!.location;
      price = docProfile!.price;
    } else if (labProfile != null) {
      name = labProfile!.name;
      location = labProfile!.zone;
      price = labProfile!.price;
    } else {
      throw Exception('Both doctorProfile and labProfile cannot be null');
    }

    return WillPopScope(
      onWillPop: () async {
        if (oneOrTwo == 1) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => PatientHomePage()),
            (Route<dynamic> route) => false,
          );
        } else {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => PatientMainPage()),
            (Route<dynamic> route) => false,
          );
        }
        return false;
      },
      child: Scaffold(
          backgroundColor: Color(0xffF0F4F7),
          appBar: AppBar(
              backgroundColor: Color(0xffD7E8F0),
              title: Text(
                'Thank You',
                style: TextStyle(color: Colors.black),
              ),
              leading: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  if (oneOrTwo == 1) {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) =>
                              PatientHomePage()), // Navigate to HomePage
                      (Route<dynamic> route) => false, // Remove all other pages
                    );
                  } else if (oneOrTwo == 2) {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) =>
                              PatientMainPage()), // Navigate to HomePage
                      (Route<dynamic> route) => false, // Remove all other pages
                    );
                  }
                },
              )),
          body: Center(
            child: Column(
              children: [
                SizedBox(height: 10),
                Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: 450,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(7)),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: 150,
                              height: 150,
                              child: Image.asset('assets/images/correct.png')),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Success!',
                        style: TextStyle(fontSize: 30),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Your reservation has been sent',
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(height: 10),
                      Text(
                        name,
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(height: 10),
                      Divider(
                        endIndent: 8,
                        indent: 8,
                      ),
                      SizedBox(height: 5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: 20),
                          Column(
                            children: [
                              SizedBox(height: 13),
                              SizedBox(
                                height: 30,
                                width: 30,
                                child: Image.asset(
                                    'assets/images/schedule (1).png'),
                              ),
                            ],
                          ),
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '$SelectedTime',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                '$SelectedDate',
                                style: TextStyle(fontSize: 15),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: 20),
                          Column(
                            children: [
                              SizedBox(height: 10),
                              SizedBox(
                                height: 30,
                                width: 30,
                                child:
                                    Image.asset('assets/images/location.png'),
                              ),
                            ],
                          ),
                          SizedBox(width: 20),
                          Column(
                            children: [
                              Column(
                                children: [
                                  SizedBox(height: 15),
                                  Text(
                                    location,
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: 20),
                          Column(
                            children: [
                              SizedBox(height: 10),
                              SizedBox(
                                height: 30,
                                width: 30,
                                child: Image.asset(
                                    'assets/images/icons8-money-96(-xxhdpi).png'),
                              ),
                            ],
                          ),
                          SizedBox(width: 20),
                          Column(
                            children: [
                              Column(
                                children: [
                                  SizedBox(height: 15),
                                  Text(
                                    '$price EGP',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Spacer(flex: 1),
                // SizedBox(
                //   height: 50,
                //   width: MediaQuery.of(context).size.width * 0.95,
                //   child: ElevatedButton(
                //       onPressed: () {
                //         if (oneOrTwo == 1) {
                //           Navigator.of(context).pushAndRemoveUntil(
                //             MaterialPageRoute(
                //                 builder: (context) =>
                //                     PatientHomePage()), // Navigate to HomePage
                //             (Route<dynamic> route) =>
                //                 false, // Remove all other pages
                //           );
                //         } else if (oneOrTwo == 2) {
                //           Navigator.of(context).pushAndRemoveUntil(
                //             MaterialPageRoute(
                //                 builder: (context) =>
                //                     PatientMainPage()), // Navigate to HomePage
                //             (Route<dynamic> route) =>
                //                 false, // Remove all other pages
                //           );
                //         }
                //       },
                //       child: Text(
                //         'Appointments',
                //         style: TextStyle(color: Colors.white, fontSize: 20),
                //       ),
                //       style: ElevatedButton.styleFrom(
                //           shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(7)),
                //           backgroundColor: Color(0xff00466B),
                //           fixedSize: Size(130, 50),
                //           side: BorderSide())),
                // ),
                Spacer(flex: 25),
              ],
            ),
          )),
    );
  }
}
