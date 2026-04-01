import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_disease_prediction/models/view_patient_prescriptions_model.dart';

//view patient prescriptions
class PrescriptionsCards extends StatelessWidget {
  PrescriptionsCards({required this.Prescriptions});

  ViewPatientPrescriptionsModel Prescriptions;

  @override
  Widget build(BuildContext context) {
    DateTime visitDate = DateTime.parse(Prescriptions.date);
    DateTime nextVisitDate = visitDate.add(Duration(days: 7));
    String nextVisitDateString =
        nextVisitDate.toIso8601String().substring(0, 10);
    return Container(
      width: 370,
      height: 100,
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
      child: Row(
        children: [
          SizedBox(
              width: 80,
              height: 80,
              child: Image.asset('assets/images/prescription (1).png')),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 13),
              Text(
                'From : Dr. ${Prescriptions.docName.split(" ").map((str) => str[0].toUpperCase() + str.substring(1)).join(" ")}',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 5),
              Text(
                'Examination Date : ${visitDate.toIso8601String().substring(0, 10)}',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 5),
              Text(
                'Consultation Date : $nextVisitDateString',
                style: TextStyle(fontSize: 15),
              ),
            ],
          )
        ],
      ),
    );
  }
}

//view all prescriptions for doctor
class ViewPrescriptionsCards extends StatelessWidget {
  ViewPrescriptionsCards({required this.allPrescriptions});

  ViewAllDoctorPrescriptionsModel allPrescriptions;

  @override
  Widget build(BuildContext context) {
    DateTime visitDate = DateTime.parse(allPrescriptions.date);
    DateTime nextVisitDate = visitDate.add(Duration(days: 7));
    String nextVisitDateString =
        nextVisitDate.toIso8601String().substring(0, 10);
    return Container(
      width: 370,
      height: 120,
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
      child: Row(
        children: [
          SizedBox(
              width: 80,
              height: 80,
              child: Image.asset('assets/images/prescription (1).png')),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 13),
              Text(
                'Name : ${allPrescriptions.firstName} ${allPrescriptions.lastName}',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 5),
              Text(
                'Age : ${allPrescriptions.age}',
                style: TextStyle(fontSize: 15),
              ),
              // SizedBox(height: 5),
              // Text(
              //   'Gender : ${allPrescriptions.gender == 0 ? 'Male' : 'Female'}',
              //   style: TextStyle(fontSize: 15),
              // ),
              SizedBox(height: 5),
              Text(
                'Examination Date : ${visitDate.toIso8601String().substring(0, 10)}',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 5),
              Text(
                'Consultation Date : $nextVisitDateString',
                style: TextStyle(fontSize: 15),
              ),
            ],
          )
        ],
      ),
    );
  }
}

//view all prescriptions for patient
class ViewPatientPrescriptionsCards extends StatelessWidget {
  ViewPatientPrescriptionsCards({required this.allPrescriptions});

  ViewAllPatientPrescriptionsModel allPrescriptions;

  @override
  Widget build(BuildContext context) {
    DateTime visitDate = DateTime.parse(allPrescriptions.date);
    DateTime nextVisitDate = visitDate.add(Duration(days: 7));
    String nextVisitDateString =
        nextVisitDate.toIso8601String().substring(0, 10);
    return Container(
      width: 370,
      height: 100,
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
      child: Row(
        children: [
          SizedBox(
              width: 80,
              height: 80,
              child: Image.asset('assets/images/prescription (1).png')),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 13),
              Text(
                'From : ${allPrescriptions.name.split(" ").map((str) => str[0].toUpperCase() + str.substring(1)).join(" ")}',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 5),
              Text(
                'Examination Date : ${visitDate.toIso8601String().substring(0, 10)}',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 5),
              Text(
                'Consultation Date : $nextVisitDateString',
                style: TextStyle(fontSize: 15),
              ),
            ],
          )
        ],
      ),
    );
  }
}
