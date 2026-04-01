import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:heart_disease_prediction/screens/predictions_info.dart';

class Predictions extends StatefulWidget {
  const Predictions({super.key});

  @override
  State<Predictions> createState() => _PredictionsState();
}

class _PredictionsState extends State<Predictions> {
  final borderStyle = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(7)),
    borderSide: BorderSide(color: Colors.grey, width: 1.5),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF0F4F7),
      appBar: AppBar(
        backgroundColor: Color(0xffD7E8F0),
        title: Text(
          'Prediction Results',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        leadingWidth: 30,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 10),
            SizedBox(
              height: 50,
              width: 370,
              child: TextField(
                  cursorColor: Color(0xff004670),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 20),
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      border: borderStyle,
                      focusedBorder: borderStyle,
                      enabledBorder: borderStyle)),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) {
                //   return PredictionsInfo();
                // }));
              },
              child: Container(
                width: 370,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey
                          .withOpacity(0.3), // More transparent shadow
                      spreadRadius: 2, // Reduced spread radius
                      blurRadius: 4, // Reduced blur radius
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    SizedBox(width: 10),
                    SizedBox(
                        width: 70,
                        height: 70,
                        child: Image.asset('assets/images/healthcare.png')),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 13),
                        Text(
                          'Lab Name :',
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Supervisor :',
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Referred By : ',
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Date :',
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
