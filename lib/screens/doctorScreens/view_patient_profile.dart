import 'package:dio/dio.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:heart_disease_prediction/Services/AppoitnmentService.dart';
import 'package:heart_disease_prediction/models/patients_list_model.dart';
import 'package:heart_disease_prediction/models/view_patient_prescriptions_model.dart';
import 'package:heart_disease_prediction/screens/doctorScreens/add_prescription_page.dart';
import 'package:heart_disease_prediction/screens/doctorScreens/view_patient_tests_doc.dart';
import 'package:heart_disease_prediction/screens/doctorScreens/view_predictions.dart';
import 'package:heart_disease_prediction/screens/doctorScreens/view_prescriptions.dart';
import 'package:heart_disease_prediction/screens/medicalAnalystScreens/add_medical_Tests.dart';
import 'package:heart_disease_prediction/screens/medicalAnalystScreens/view_patient_tests_lab.dart';

class ViewPatientProfile extends StatefulWidget {
  ViewPatientProfile(
      {this.patientDetailsForDoctor,
      this.patientDetailsForLab,
      required this.id});

  PatientsListForDoctorModel? patientDetailsForDoctor;
  PatientsListForLabModel? patientDetailsForLab;
  int id;

  @override
  State<ViewPatientProfile> createState() => _ViewPatientProfileState();
}

class _ViewPatientProfileState extends State<ViewPatientProfile> {
  final AppoitnmentsService service = AppoitnmentsService(Dio());
  String expandText = 'see more';
  String? collapseText = 'see less';

  @override
  Widget build(BuildContext context) {
    String name;
    int age;
    int gender;
    String phone;
    if (widget.patientDetailsForDoctor != null) {
      name =
          '${widget.patientDetailsForDoctor!.name.split(" ").map((str) => str[0].toUpperCase() + str.substring(1)).join(" ")}';

      age = widget.patientDetailsForDoctor!.age;
      gender = widget.patientDetailsForDoctor!.gender;
      phone = widget.patientDetailsForDoctor!.phone;
    } else if (widget.patientDetailsForLab != null) {
      name =
          '${widget.patientDetailsForLab!.name.split(" ").map((str) => str[0].toUpperCase() + str.substring(1)).join(" ")}';

      age = widget.patientDetailsForLab!.age;
      gender = widget.patientDetailsForLab!.gender;
      phone = widget.patientDetailsForLab!.phone;
    } else {
      throw Exception(
          'Both patientDetailsForDoctor and patientDetailsForLab cannot be null');
    }
    return Scaffold(
      backgroundColor: Color(0xffF0F4F7),
      appBar: AppBar(
        backgroundColor: Color(0xffD7E8F0),
        title: Text(
          'Patient Profile',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        leadingWidth: 30,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 66),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    height: 270,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: Offset(0, -3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //           SizedBox(
                          // height: 100,
                          // width: 100,
                          // child: Image.asset('assets/images/patient.png')),
                          SizedBox(height: 80),
                          Text(
                            'Personal Information',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Divider(
                            endIndent: 20,
                          ),
                          Row(
                            children: [
                              Text(
                                'Name : ',
                                style: TextStyle(fontSize: 17),
                              ),
                              Text(
                                '${name}',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              // Spacer(flex: 1),

                              // Spacer(flex: 2),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                'Age : ',
                                style: TextStyle(fontSize: 17),
                              ),
                              Text(
                                '${age} Y',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                'Gender : ',
                                style: TextStyle(fontSize: 17),
                              ),
                              Text(
                                gender == 0 ? 'Female' : 'Male',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                'Phone Number : ',
                                style: TextStyle(fontSize: 17),
                              ),
                              Text(
                                '+2${phone}',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Spacer(flex: 1),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.93,
                        child: ElevatedButton(
                          onPressed: () {
                            if (widget.patientDetailsForLab != null) {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return AddMedicalTest(
                                  id: widget.patientDetailsForLab!.id,
                                  age: widget.patientDetailsForLab!.age,
                                  gender: widget.patientDetailsForLab!.gender,
                                );
                              }));
                            } else {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return AddPrescriptions(
                                  id: widget.id,
                                );
                              }));
                            }
                          },
                          child: Text(
                            widget.patientDetailsForDoctor == null
                                ? 'Add Medical Test'
                                : 'Add Prescription',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              backgroundColor: Color(0xff00466B),
                              fixedSize: Size(130, 50),
                              side: BorderSide()),
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.93,
                        child: ElevatedButton(
                          onPressed: () {
                            if (widget.patientDetailsForLab != null) {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return ViewPatientMedicalTests(id: widget.id);
                              }));
                            } else {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return OlderPatientPrescriptions(
                                  id: widget.patientDetailsForDoctor!.id,
                                  name: widget.patientDetailsForDoctor!.name,
                                );
                              }));
                            }
                          },
                          child: Text(
                            widget.patientDetailsForDoctor == null
                                ? 'View Medical Tests'
                                : 'View Prescriptions',
                            style: TextStyle(
                                color: Color(0xff00466B), fontSize: 20),
                          ),
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              backgroundColor: Color(0xffD7E8F0),
                              fixedSize: Size(130, 50),
                              side: BorderSide(color: Color(0xff00466B))),
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.93,
                        child: ElevatedButton(
                          onPressed: () {
                            if (widget.patientDetailsForDoctor != null) {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return ViewPatientMedicalTestsDoc(
                                    id: widget.id);
                              }));
                            }
                          },
                          child: Text(
                            'View Medical Tests',
                            style: TextStyle(
                                color: Color(0xff00466B), fontSize: 20),
                          ),
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              backgroundColor: Color(0xffD7E8F0),
                              fixedSize: Size(130, 50),
                              side: BorderSide(color: Color(0xff00466B))),
                        ),
                      ),
                    ],
                  ),
                  Spacer(flex: 20),
                ],
              ),
            ),
          ),
          Positioned(
              width: 140,
              height: 140,
              top: MediaQuery.of(context).size.height * 0.005,
              left: MediaQuery.of(context).size.width * 0.35,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  // border: Border.all(
                  //   width: 1,
                  //   color: Color(0xffC1D0D8),
                  // )
                ),
                child: Container(
                  decoration: BoxDecoration(
                      // color: Colors.white,
                      borderRadius: BorderRadius.circular(50)),
                  child: Image.asset('assets/images/patient.png'),
                ),
              )),
        ],
      ),
    );
  }
}
