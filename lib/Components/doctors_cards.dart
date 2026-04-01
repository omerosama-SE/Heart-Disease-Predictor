import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:heart_disease_prediction/models/doctors_list_model.dart';

class DoctorsCards extends StatelessWidget {
  DoctorsCards({required this.doctorCard});

  AppoitnmentsModel doctorCard;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 370,
        height: 220,
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
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 10),
                  Column(
                    children: [
                      SizedBox(height: 10),
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                              width: 1,
                              color: Color(0xffC1D0D8),
                            )),
                        child: Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                              image: DecorationImage(
                                  image:
                                      NetworkImage(doctorCard.profilePicture),
                                  filterQuality: FilterQuality.high,
                                  fit: BoxFit.fill)),
                        ),
                      ),
                      SizedBox(height: 10),
                      // SizedBox(
                      //   height: 20,
                      //   width: 20,
                      //   child: Image.asset('assets/images/star.png'),
                      // ),
                      // Text(
                      //   doctorCard.rating,
                      //   style: TextStyle(fontWeight: FontWeight.bold),
                      // )
                    ],
                  ),
                  SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(height: 10),
                      Row(children: [
                        Text(
                          'Doctor',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xff00466D),
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          '${doctorCard.name.split(" ").map((str) => str[0].toUpperCase() + str.substring(1)).join(" ")}',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff00466D),
                              fontFamily: 'Myriad'),
                        ),
                      ]),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(
                              width: 20,
                              height: 20,
                              child: Image.asset(
                                  'assets/images/stethoscope-medical-tool.png')),
                          SizedBox(width: 10),
                          Text(
                            'Cardiologist',
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
                              child: Image.asset('assets/images/pin.png')),
                          SizedBox(width: 10),
                          Text(
                            doctorCard.zone,
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
                              child: Image.asset(
                                  'assets/images/icons8-money-96(-xxhdpi).png')),
                          SizedBox(width: 10),
                          Text(
                            '${doctorCard.price} EGP',
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
                              child: Image.asset('assets/images/timer.png')),
                          SizedBox(width: 10),
                          Text(
                            '${doctorCard.startTime} To ${doctorCard.finishTime}',
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
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
                  'Make an Appointment',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )),
              ),
            ],
          ),
        ));
  }
}
