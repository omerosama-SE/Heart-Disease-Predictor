import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_disease_prediction/screens/appointments_labs.dart';
import 'package:heart_disease_prediction/screens/appoitments.dart';

class EmptyPage extends StatelessWidget {
  EmptyPage({required this.text});
  String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.3),
        Text('You have no $text',
            style: TextStyle(fontSize: 25, fontFamily: 'Myriad')),
        SizedBox(height: 5),
        Text('To predict your heart condition you must provide',
            style: TextStyle(
                fontSize: 20, fontFamily: 'Myriad', color: Colors.grey)),
        Text('your medical tests to do so you must',
            style: TextStyle(
                fontSize: 20, fontFamily: 'Myriad', color: Colors.grey)),
        Text('book an appointment',
            style: TextStyle(
                fontSize: 20, fontFamily: 'Myriad', color: Colors.grey)),
        SizedBox(height: MediaQuery.of(context).size.height * 0.015),
        SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width * 0.7,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return LabsList();
              }));
            },
            child: Text(
              'Book Diagnostic Appointment',
              style: TextStyle(color: Color(0xff00466B), fontSize: 20),
            ),
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7)),
                backgroundColor: Color(0xffD7E8F0),
                side: BorderSide(color: Color(0xff00466B))),
          ),
        ),
      ],
    );
  }
}

class Empty extends StatelessWidget {
  Empty({required this.text});
  String text;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.35),
          Text('You have no $text',
              style: TextStyle(fontSize: 25, fontFamily: 'Myriad')),
        ],
      ),
    );
  }
}
