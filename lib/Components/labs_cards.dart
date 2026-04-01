import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:heart_disease_prediction/models/labs_model.dart';

class LabsCards extends StatelessWidget {
  LabsCards({required this.lab});

  getLabsModel lab;
  @override
  Widget build(BuildContext context) {
    // String baseUrl = 'http://heartdiseasepredictionapi.runasp.net';
    // String imagePath = '${lab.labLogo}';
    // String fullImageUrl = baseUrl + imagePath;
    return Container(
        width: 370,
        height: 250,
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
                  SizedBox(width: 20),
                  Column(
                    children: [
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              width: 1,
                              color: Color(0xffC1D0D8),
                            )),
                        child: Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: NetworkImage(lab.labLogo),
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
                      Text(
                        '${lab.name}',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
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
                            'Laboratory',
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
                                'assets/images/location (1).png',
                                filterQuality: FilterQuality.high,
                              )),
                          SizedBox(width: 10),
                          Text(
                            '${lab.location}',
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
                            '${lab.price} EGP',
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02),
                          GestureDetector(
                            onTap: () async {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                        'Heart Disease Prediction Group',
                                        style: TextStyle(
                                            fontSize: 23,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      content: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(children: [
                                            Text('\u2022'),
                                            SizedBox(width: 5),
                                            Text(
                                              'Hemoglobin A1c (HbA1c) test',
                                              style: TextStyle(fontSize: 18),
                                            )
                                          ]),
                                          Row(children: [
                                            Text('\u2022'),
                                            SizedBox(width: 5),
                                            Text(
                                              'Lipid Profile',
                                              style: TextStyle(fontSize: 18),
                                            )
                                          ]),
                                          Row(children: [
                                            Text('\u2022'),
                                            SizedBox(width: 5),
                                            Text(
                                              'Fasting Blood Sugar (FBS) test',
                                              style: TextStyle(fontSize: 18),
                                            )
                                          ]),
                                          Row(children: [
                                            Text('\u2022'),
                                            SizedBox(width: 5),
                                            Text(
                                              'Electrocardiogram (ECG) test',
                                              style: TextStyle(fontSize: 18),
                                            )
                                          ]),
                                        ],
                                      ),
                                    );
                                  });
                            }, //call the doctor function
                            child: Icon(Icons.info_outline_rounded,
                                size: 20, color: Color(0xff00466D)),
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
                            '${lab.startTime} To ${lab.finishTime}',
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
                              child: Image.asset('assets/images/phone.png')),
                          SizedBox(width: 10),
                          Text(
                            '${lab.phone}',
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
