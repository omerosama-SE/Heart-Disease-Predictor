import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_disease_prediction/screens/appoitments.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'package:heart_disease_prediction/Services/AppoitnmentService.dart';
import 'package:heart_disease_prediction/models/prediction_details.dart';
import 'package:heart_disease_prediction/models/test_details_model.dart';

class PredictionsInfo extends StatefulWidget {
  PredictionsInfo(
      {required this.predictionModel,
      required this.testDetails,
      required this.id});

  PredictionResultModel predictionModel;
  TestDetailsModel testDetails;
  int id;

  @override
  State<PredictionsInfo> createState() => _PredictionsInfoState();
}

class _PredictionsInfoState extends State<PredictionsInfo> {
  final AppoitnmentsService service = AppoitnmentsService(Dio());
  Future<Response> savePredictionResult() async {
    return service.SavePredictionResult(
        id: widget.id,
        gender: widget.testDetails.gender,
        age: widget.testDetails.age,
        smoking: widget.testDetails.smoker,
        numberOfCigarettes: widget.testDetails.numberOfCigarettes,
        bloodPressureMedicine: widget.testDetails.bloodPressureMedicine,
        prevalentStroke: widget.testDetails.prevalentStroke,
        prevalentHyperTension: widget.testDetails.prevalentHypertension,
        diabetes: widget.testDetails.diabatesLevel,
        cholesterolLevel: widget.testDetails.cholesterolLevel,
        systolicBloodPressure: widget.testDetails.systolicBloodPressure,
        diastolicBloodPressure: widget.testDetails.diastolicBloodPressure,
        bMI: widget.testDetails.bmi,
        heartRate: widget.testDetails.heartRate,
        glucoseLevel: widget.testDetails.glucoseLevel,
        predictionResult:
            widget.predictionModel.result == 'Has Heart Disease' ? 1 : 0,
        probability: widget.predictionModel.precent);
  }

  @override
  void initState() {
    super.initState();
    savePredictionResult();
  }

  @override
  Widget build(BuildContext context) {
    String date = DateTime.now().toString();
    String generatingDate = date.split('T')[0];

    double precent = widget.predictionModel.precent;
    return Column(
      children: [
        Divider(
          indent: 15,
          endIndent: 15,
          thickness: 1.5,
          color: Colors.black,
        ),
        Row(
          children: [
            SizedBox(width: 20),
            Text(
              'Patient Name : ',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            Text(
              '${widget.testDetails.patientName}',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(width: 20),
            Text(
              'Gender : ',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            Text(
              widget.testDetails.gender == 0 ? 'Male' : 'Female',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(width: 20),
            Text(
              'Age : ',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            Text(
              '${widget.testDetails.age}',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(width: 20),
            Text(
              'Generating Date : ',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            Text(
              '${generatingDate}',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ],
        ),
        Divider(
          indent: 20,
          endIndent: 20,
          thickness: 1.5,
          color: Colors.black,
        ),

        Text(
          'Heart Disease Detection Summary',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Divider(
          indent: 20,
          endIndent: 20,
          thickness: 1.5,
          color: Colors.black,
        ),
        // SizedBox(
        //     width: 180,
        //     height: 180,
        //     child: Image.asset(
        //       'assets/images/heart-beat0.png',
        //     )),
        SizedBox(height: 20),
        Text(
          widget.predictionModel.result == 'Has Heart Disease'
              ? 'Heart Disease Detected'
              : 'Heart Disease Not Detected',
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: widget.predictionModel.result == 'Has Heart Disease'
                  ? Colors.red
                  : Colors.green[800]),
        ),
        SizedBox(height: 30),
        CircularPercentIndicator(
          radius: 100,
          lineWidth: 20,
          percent: widget.predictionModel.precent / 100,
          progressColor: widget.predictionModel.precent / 100 < 0.3
              ? Colors.green
              : (widget.predictionModel.precent / 100 < 0.7
                  ? Colors.yellow
                  : Colors.red),
          circularStrokeCap: CircularStrokeCap.round,
          center: Text(
            '${(widget.predictionModel.precent / 100 * 100)}%',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          footer: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 20),
              Text(
                'Heart Disease Risk Level',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Tips'),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Good : From 0% to 29%'),
                                Text('Moderate : From 30% to 69%'),
                                Text('Bad : From 70% to 100%'),
                              ],
                            ),
                          );
                        });
                  },
                  icon: Icon(Icons.info_outline))
            ],
          ),
        ),
        widget.predictionModel.result == 'Has Heart Disease'
            ? HasHeartDisease()
            : NoHeartDisease()
      ],
    );
  }
}

class GetPredictionResult extends StatefulWidget {
  GetPredictionResult({required this.testDetails, required this.id});

  TestDetailsModel testDetails;
  int id;

  @override
  State<GetPredictionResult> createState() => _GetPredictionResultState();
}

class _GetPredictionResultState extends State<GetPredictionResult> {
  PredictionResultModel? predictionModel;
  final AppoitnmentsService service = AppoitnmentsService(Dio());

  Future<PredictionResultModel> fetchPredictionResult() async {
    return await service.MakePrediction(
        gender: widget.testDetails.gender,
        age: widget.testDetails.age,
        bMI: widget.testDetails.bmi,
        bloodPressureMedicine: widget.testDetails.bloodPressureMedicine,
        cholesterolLevel: widget.testDetails.cholesterolLevel,
        diabetes: widget.testDetails.diabatesLevel,
        diastolicBloodPressure: widget.testDetails.diastolicBloodPressure,
        glucoseLevel: widget.testDetails.glucoseLevel,
        heartRate: widget.testDetails.heartRate,
        numberOfCigarettes: widget.testDetails.numberOfCigarettes,
        prevalentHyperTension: widget.testDetails.prevalentHypertension,
        prevalentStroke: widget.testDetails.prevalentStroke,
        smoking: widget.testDetails.smoker,
        systolicBloodPressure: widget.testDetails.systolicBloodPressure);
  }

  Future<Response> savePredictionResult() async {
    return service.SavePredictionResult(
        id: widget.id,
        gender: widget.testDetails.gender,
        age: widget.testDetails.age,
        smoking: widget.testDetails.smoker,
        numberOfCigarettes: widget.testDetails.numberOfCigarettes,
        bloodPressureMedicine: widget.testDetails.bloodPressureMedicine,
        prevalentStroke: widget.testDetails.prevalentStroke,
        prevalentHyperTension: widget.testDetails.prevalentHypertension,
        diabetes: widget.testDetails.diabatesLevel,
        cholesterolLevel: widget.testDetails.cholesterolLevel,
        systolicBloodPressure: widget.testDetails.systolicBloodPressure,
        diastolicBloodPressure: widget.testDetails.diastolicBloodPressure,
        bMI: widget.testDetails.bmi,
        heartRate: widget.testDetails.heartRate,
        glucoseLevel: widget.testDetails.glucoseLevel,
        predictionResult:
            predictionModel?.result == 'Has Heart Disease' ? 1 : 0,
        probability: predictionModel?.precent);
  }

  //Loading Indicator
  OverlayEntry? _overlayEntry;

  void _showLoadingIndicator() {
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 0,
        left: 0,
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black.withOpacity(0.3),
            child: Column(children: [
              Spacer(flex: 1),
              CircularProgressIndicator(color: Color(0xff00466D)),
              Spacer(flex: 1),
            ])),
      ),
    );

    Overlay.of(context)?.insert(_overlayEntry!);
  }

  void _hideLoadingIndicator() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF0F4F7),
        appBar: AppBar(
          backgroundColor: Color(0xffD7E8F0),
          title: Text(
            'Prediction Result',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: FutureBuilder<PredictionResultModel>(
            future: fetchPredictionResult(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                WidgetsBinding.instance?.addPostFrameCallback((_) {
                  _showLoadingIndicator();
                });
                return SizedBox.shrink();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                if (_overlayEntry != null) {
                  _hideLoadingIndicator();
                }
                return PredictionsInfo(
                  predictionModel: snapshot.data!,
                  testDetails: widget.testDetails,
                  id: widget.id,
                );
              }
            }));
  }
}

class HasHeartDisease extends StatelessWidget {
  const HasHeartDisease({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          endIndent: 15,
          indent: 15,
        ),
        Text(
          'Your health is our priority, The test indicates a high',
          style: TextStyle(
              fontFamily: 'Myriad',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.red),
        ),
        Text(
          'possibility of heart disease, It\'s essential to',
          style: TextStyle(
              fontFamily: 'Myriad',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.red),
        ),
        Text(
          'consult with a doctor immediately.',
          style: TextStyle(
              fontFamily: 'Myriad',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.red),
        ),
        SizedBox(height: 10),
        SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width * 0.8,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return DoctorsListShow();
              }));
            },
            child: Text(
              'Book an appointment',
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

class NoHeartDisease extends StatelessWidget {
  const NoHeartDisease({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          endIndent: 50,
          indent: 50,
        ),
        Text(
            'Congratulations on your healthy heart!\n Here are some tips to keep it that way:\n\n1. Maintain a balanced diet.\n2. Exercise regularly.\n3. Avoid smoking.\n4. Limit alcohol.\n5. Manage stress.\n6. Regular health check-ups.',
            style: TextStyle(
                fontSize: 20, fontFamily: 'Myriad', color: Colors.green[800])),
      ],
    );
  }
}
