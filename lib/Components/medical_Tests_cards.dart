import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_disease_prediction/models/medical_tests_model.dart';

class MedicalTestsCards extends StatelessWidget {
  MedicalTestsCards({this.test, this.test2, this.test3});

  MedicalTestsModel? test;
  MedicalTestsModelLab? test2;
  MedicalTestsModelDoc? test3;

  @override
  Widget build(BuildContext context) {
    int id;
    String name;
    String analystName;
    String date;
    String specialName;

    if (test != null) {
      id = test!.id;
      name = '${test!.labName}';

      analystName = test!.superVisor;
      date = test!.date;
    } else if (test2 != null) {
      id = test2!.id;
      name =
          '${test2!.patientName.split(" ").map((str) => str[0].toUpperCase() + str.substring(1)).join(" ")}';

      analystName = test2!.superVisor;
      date = test2!.date;
    } else if (test3 != null) {
      id = test3!.id;
      name =
          '${test3!.labName.split(" ").map((str) => str[0].toUpperCase() + str.substring(1)).join(" ")}';

      analystName = test3!.superVisor;
      date = test3!.date;
    } else {
      throw Exception(
          'Both patientDetailsForDoctor and patientDetailsForLab cannot be null');
    }
    DateTime testDate = DateTime.parse(date);
    DateTime oneMonthAgo = DateTime.now().subtract(Duration(days: 30));

    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      height: 185,
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
          SizedBox(height: 15),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 20),
              Column(
                children: [
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      print(testDate);
                      print(oneMonthAgo);
                    },
                    child: SizedBox(
                      height: 70,
                      width: 70,
                      child: Image.asset('assets/images/health-check.png'),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SizedBox(height: 10),
                  Text(
                    test != null
                        ? '${name} Test'
                        : test2 != null
                            ? '${name}'
                            : '${name.replaceAll('@gmail.com', '')} Test',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      SizedBox(
                          width: 20,
                          height: 20,
                          child: Image.asset('assets/images/microscope.png')),
                      SizedBox(width: 10),
                      Text(
                        'Dr.${analystName}',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      SizedBox(
                          width: 20,
                          height: 20,
                          child: Image.asset('assets/images/calendar.png')),
                      SizedBox(width: 10),
                      Text(
                        '${testDate.toIso8601String().substring(0, 10)}',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      SizedBox(
                          width: 20,
                          height: 20,
                          child: Image.asset('assets/images/status (1).png')),
                      SizedBox(width: 10),
                      Text(
                        testDate.isBefore(oneMonthAgo) ? 'Expired' : 'Valid',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Spacer(flex: 1),
          Container(
            height: 40,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Color(0xff00466B),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: Center(
                child: Text(
              'View Test Details',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Myriad'),
            )),
          ),
        ],
      ),
    );
  }
}
