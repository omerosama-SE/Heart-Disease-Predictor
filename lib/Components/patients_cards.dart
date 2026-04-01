import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_disease_prediction/Services/AppoitnmentService.dart';
import 'package:heart_disease_prediction/models/patients_list_model.dart';
import 'package:heart_disease_prediction/screens/doctorScreens/doctor_appoitnments.dart';
import 'package:heart_disease_prediction/screens/doctorScreens/view_patient_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class PatientCards extends StatefulWidget {
  PatientCards({required this.patientCards, required this.onDelete});

  PatientsListForDoctorModel patientCards;
  Function() onDelete;

  @override
  State<PatientCards> createState() => _PatientCardsState();
}

class _PatientCardsState extends State<PatientCards> {
  final AppoitnmentsService service = AppoitnmentsService(Dio());

  bool isAccepted = false;
  bool iscancelled = false;

  void initState() {
    super.initState();
    loadAppoitnmentState(widget.patientCards.id);
  }

  void handleAcceptAppointment() async {
    //used in accept button
    try {
      Response response =
          await service.AcceptAppoitnment(widget.patientCards.id);
    } catch (e) {
      print(e);
    }
  }

  void handleCancelAppointment() async {
    //used in cancel button
    try {
      Response response =
          await service.CancelAppoitnment(widget.patientCards.id);
    } catch (e) {
      print(e);
    }
  }

  DoctorAppoitnments da = DoctorAppoitnments();
//Load the saved states after reopening the app
  Future<void> loadAppoitnmentState(int id) async {
    final prefs = await SharedPreferences.getInstance();

    String acceptedKey = 'accepted_$id';
    String cancelledKey = 'cancelled_$id';
// Load the states
    setState(() {
      isAccepted = prefs.getBool(acceptedKey) ?? false;
      iscancelled = prefs.getBool(cancelledKey) ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 370,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3), // More transparent shadow
            spreadRadius: 2, // Reduced spread radius
            blurRadius: 4, // Reduced blur radius
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Column(
            children: [
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: Image.asset('assets/images/patient.png'),
                    ),
                    SizedBox(width: 15),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SizedBox(height: 10),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Name : ',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                //variable from database
                                widget.patientCards.name,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ]),
                        SizedBox(height: 5),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Time Slot : ',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              //variable from database
                              widget.patientCards.time,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Appointment Type : ',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              //variable from database
                              'Examination',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          isAccepted == false
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: ElevatedButton(
                          onPressed: () {
                            handleCancelAppointment();
                            setState(() {
                              iscancelled = true;
                            });
                            saveAppointmentsState(widget.patientCards.id,
                                isAccepted, iscancelled);
                            widget.onDelete();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.cancel_outlined,
                                color: Color(0xff00466B),
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Cancel',
                                style: TextStyle(
                                    color: Color(0xff00466B), fontSize: 17),
                              ),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            backgroundColor: Color(0xffD7E8F0),
                          )),
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: ElevatedButton(
                          onPressed: () {
                            handleAcceptAppointment();
                            setState(() {
                              isAccepted = true;
                            });
                            saveAppointmentsState(widget.patientCards.id,
                                isAccepted, iscancelled);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.done,
                                color: Colors.white,
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Accept',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              ),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            backgroundColor: Color(0xff00466B),
                          )),
                    ),
                  ],
                )
              : ifAppointmentAcceptedState(patientCards: widget.patientCards),
        ],
      ),
    );
  }

//save the state if the accept button pressed
  Future<void> saveAppointmentsState(
      int id, bool accepted, bool cancelled) async {
    final prefs = await SharedPreferences.getInstance();

// Use the appointment ID to create unique keys for the accepted and cancelled states
    String acceptedKey = 'accepted_$id';
    String cancelledKey = 'cancelled_$id';
// Save the states
    prefs.setBool(acceptedKey, accepted);
    prefs.setBool(cancelledKey, cancelled);
  }
}

class ifAppointmentAcceptedState extends StatelessWidget {
  ifAppointmentAcceptedState({required this.patientCards});

  PatientsListForDoctorModel patientCards;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 40,
          width: MediaQuery.of(context).size.width * 0.45,
          child: ElevatedButton(
              onPressed: () async {
                final Uri url = Uri(
                  scheme: 'tel',
                  path: patientCards.phone,
                );
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                } else {
                  print('Cannot Lanch This URL');
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.call,
                    color: Color(0xff00466B),
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Call',
                    style: TextStyle(color: Color(0xff00466B), fontSize: 17),
                  ),
                ],
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7)),
                backgroundColor: Color(0xffD7E8F0),
              )),
        ),
        SizedBox(width: 10),
        SizedBox(
          height: 40,
          width: MediaQuery.of(context).size.width * 0.45,
          child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ViewPatientProfile(
                      patientDetailsForDoctor: patientCards,
                      id: patientCards.id);
                }));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.account_circle_outlined,
                    color: Colors.white,
                  ),
                  SizedBox(width: 5),
                  Text(
                    'View Profile',
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ],
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7)),
                backgroundColor: Color(0xff00466B),
              )),
        ),
      ],
    );
  }
}
