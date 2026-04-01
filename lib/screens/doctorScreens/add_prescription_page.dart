import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:heart_disease_prediction/Services/AppoitnmentService.dart';
import 'package:heart_disease_prediction/screens/doctorScreens/D_Home_Page.dart';
import 'package:heart_disease_prediction/screens/doctorScreens/doctor_appoitnments.dart';
import 'package:heart_disease_prediction/screens/doctorScreens/view_patient_profile.dart';
import 'package:heart_disease_prediction/screens/doctorScreens/view_prescriptions.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:simple_toast_message/simple_toast.dart';

class AddPrescriptions extends StatefulWidget {
  AddPrescriptions({required this.id});

  int id;

  @override
  State<AddPrescriptions> createState() => _AddPrescriptionsState();
}

class _AddPrescriptionsState extends State<AddPrescriptions> {
  @override
  List<String> dosage = [
    '1 pill',
    '2 pill',
    '3 pill',
    '4 pill',
    '5 pill',
  ];
  List<String> Schedule = [
    'Morning',
    'Afternoon',
    'Evening',
    'Night',
  ];
  List<String> MealTime = [
    'Before Meal',
    'With Meal',
    'After Meal',
  ];
  List<String> Duration = [
    '1 Week',
    '2 Weeks',
    '3 Weeks',
    '4 Weeks',
  ];

  List<dynamic> medicines = [];

  String myString = '';

  var text = TextEditingController();
  var text2 = TextEditingController();
  var patientSSN = TextEditingController();
  String? valueChoosen;
  String? valueChoosen3;
  String? valueChoosen4;
  String? valueChoosen5;
  String? checkSSN;

//Post Method
  AppoitnmentsService service = AppoitnmentsService(Dio());

  void handlePostPrescription() async {
    try {
      Response response = await service.PostPrescription(widget.id, myString);

      if (response.statusCode == 200) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: 'Prescription Added Successfully!',
          barrierDismissible: false,
          confirmBtnText: 'OK',
          confirmBtnColor: Color(0xff14C06A),
          onConfirmBtnTap: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => DoctorAppoitnments()),
              (Route<dynamic> route) => false,
            );
          },
        );
      } else {
        // SimpleToast.showErrorToast(context, "Incorrect Values", "Wrong SSN");
      }
    } catch (e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF0F4F7),
      appBar: AppBar(
        backgroundColor: Color(0xffD7E8F0),
        title: Text(
          'Add Prescription',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        leadingWidth: 30,
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Row(
            children: [
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Add Medicine',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.93,
                          child: TextField(
                            controller: text,
                            decoration: InputDecoration(
                                focusColor: Color(0xff00466D),
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Enter Medicine Name',
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7)))),
                          )),
                      SizedBox(width: 5),
                    ],
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(width: 25),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dosage',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    DropdownButton(
                      hint: Text('Select'),
                      value: valueChoosen,
                      items: dosage.map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          valueChoosen = newValue;
                        });
                      },
                    )
                  ],
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Meal Time',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    DropdownButton(
                      hint: Text('Select'),
                      value: valueChoosen3,
                      items: MealTime.map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          valueChoosen3 = newValue;
                        });
                      },
                    )
                  ],
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Secdule',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    DropdownButton(
                      hint: Text('Select'),
                      value: valueChoosen4,
                      items: Schedule.map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          valueChoosen4 = newValue;
                        });
                      },
                    )
                  ],
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Duration',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    DropdownButton(
                      hint: Text('Select'),
                      value: valueChoosen5,
                      items: Duration.map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          valueChoosen5 = newValue;
                        });
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 20),
              SizedBox(
                  height: 70,
                  width: MediaQuery.of(context).size.width * 0.93,
                  child: TextField(
                    controller: text2,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Notes',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(7)))),
                  )),
            ],
          ),
          Spacer(flex: 30),
          SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.95,
            child: ElevatedButton(
                onPressed: () {
                  if (text.text.isNotEmpty &&
                          valueChoosen != null &&
                          valueChoosen3 != null &&
                          valueChoosen4 != null &&
                          valueChoosen5 != null ||
                      text2.text.isNotEmpty) {
                    DialougBuilder(context);
                  } else {
                    SimpleToast.showErrorToast(context, "Missing Values",
                        "Please fill all the fields");
                  }
                },
                child: Text(
                  'Add Prescription',
                  style: TextStyle(color: Color(0xff00466B), fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7)),
                    backgroundColor: Color(0xffD7E8F0),
                    // fixedSize: Size(130, 50),
                    side: BorderSide())),
          ),
          Spacer(flex: 1),
        ],
      ),
    );
  }

  Future<void> DialougBuilder(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text('Are you want to add another medicine ?'),
              titlePadding: EdgeInsets.all(20),
              insetPadding: EdgeInsets.all(25),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(flex: 1),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            medicines.add('R/ ' + text.text);
                            medicines.add(valueChoosen);
                            medicines.add(valueChoosen3);
                            medicines.add(valueChoosen4);
                            medicines.add(valueChoosen5);
                            text2.text.isNotEmpty
                                ? medicines.add(text2.text)
                                : null;
                            myString = medicines.join('\n') + '\n';
                            print(myString);
                          });
                          Navigator.of(context).pop();
                          handlePostPrescription();
                        },
                        child: Text('No',
                            style: TextStyle(
                                fontSize: 20,
                                color: Color(0xff00466D),
                                fontWeight: FontWeight.bold))),
                    Spacer(flex: 1),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            medicines.add('R/ ' + text.text);
                            medicines.add(valueChoosen);
                            medicines.add(valueChoosen3);
                            medicines.add(valueChoosen4);
                            medicines.add(valueChoosen5);
                            text2.text.isNotEmpty
                                ? medicines.add(text2.text)
                                : null;
                            text.clear();
                            text2.clear();
                            valueChoosen = null;
                            valueChoosen3 = null;
                            valueChoosen4 = null;
                            valueChoosen5 = null;
                          });
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Yes',
                          style: TextStyle(
                              fontSize: 20,
                              color: Color(0xff00466D),
                              fontWeight: FontWeight.bold),
                        )),
                    Spacer(flex: 1),
                  ],
                ),
              ],
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(5)));
        });
  }
}
