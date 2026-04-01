import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:heart_disease_prediction/Components/labs_cards.dart';
import 'package:heart_disease_prediction/Services/AppoitnmentService.dart';
import 'package:heart_disease_prediction/main.dart';
import 'package:heart_disease_prediction/models/test_details_model.dart';
import 'package:heart_disease_prediction/screens/predictions_info.dart';

class MedicalTestsInfo extends StatefulWidget {
  MedicalTestsInfo({
    required this.testDetails,
    required this.id,
  });

  TestDetailsModel testDetails;
  int id;

  @override
  State<MedicalTestsInfo> createState() => _MedicalTestsInfoState();
}

class _MedicalTestsInfoState extends State<MedicalTestsInfo> {
  TextStyle style = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    DateTime testtDate = DateTime.parse(widget.testDetails.date);
    DateTime oneMonthAgo = DateTime.now().subtract(Duration(days: 30));

    return SingleChildScrollView(
      child: Center(
        child: Column(
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
                  'Reporting Date : ',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                Text(
                  '${testtDate.toIso8601String().substring(0, 10)}',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            Divider(
              indent: 15,
              endIndent: 15,
              thickness: 1.5,
              color: Colors.black,
            ),
            if (roles != 'User') SizedBox(height: 10),
            if (roles == 'User')
              ElevatedButton(
                  onPressed: () {
                    if (testtDate.isBefore(oneMonthAgo)) {
                      CherryToast.error(
                              toastPosition: Position.top,
                              title: Text("This Test Is Expired",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              description: Text(
                                  "Prediction option is not available",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15)),
                              animationType: AnimationType.fromRight,
                              animationDuration: Duration(milliseconds: 1000),
                              autoDismiss: true)
                          .show(context);
                    } else {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return GetPredictionResult(
                          testDetails: widget.testDetails,
                          id: widget.id,
                        );
                      }));
                    }
                  },
                  child: Text(
                    'Make a prediction',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontFamily: 'Myriad'),
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: Color(0xff00466B),
                      fixedSize:
                          Size(MediaQuery.of(context).size.width * 0.93, 50))),
            SizedBox(height: 10),
            Text(
              'Cardiology Diagnostic Report',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline),
            ),
            SizedBox(height: 10),
            DataTable(
                dataTextStyle:
                    TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                border: TableBorder.all(color: Colors.black),
                dividerThickness: 3,
                headingTextStyle: style,
                columns: <DataColumn>[
                  DataColumn(
                      label: Text(
                    'Test',
                  )),
                  DataColumn(
                      label: Text(
                    'Result',
                  )),
                  DataColumn(
                      label: Text(
                    'Normal',
                  ))
                ],
                rows: <DataRow>[
                  DataRow(cells: <DataCell>[
                    DataCell(Text('Diabetes')),
                    DataCell((Text(widget.testDetails.diabatesLevel == 0
                        ? 'Negative'
                        : 'Positive'))),
                    DataCell(Text('')),
                  ]),
                  DataRow(cells: <DataCell>[
                    DataCell(Text('Cholesterol Level')),
                    DataCell((Text('${widget.testDetails.cholesterolLevel}'))),
                    DataCell(Text('> 200')),
                  ]),
                  DataRow(cells: <DataCell>[
                    DataCell(Text('Systolic Blood Pressure')),
                    DataCell(
                        (Text('${widget.testDetails.systolicBloodPressure}'))),
                    DataCell(Text('120')),
                  ]),
                  DataRow(cells: <DataCell>[
                    DataCell(Text('Diastolic Blood Pressure')),
                    DataCell(
                        (Text('${widget.testDetails.diastolicBloodPressure}'))),
                    DataCell(Text('80')),
                  ]),
                  DataRow(cells: <DataCell>[
                    DataCell(Text('Body Mass Index (BMI)')),
                    DataCell((Text('${widget.testDetails.bmi}'))),
                    DataCell(Text('18.5-24.9')),
                  ]),
                  DataRow(cells: <DataCell>[
                    DataCell(Text('Heart Rate')),
                    DataCell((Text('${widget.testDetails.heartRate}'))),
                    DataCell(Text('60-100')),
                  ]),
                  DataRow(cells: <DataCell>[
                    DataCell(Text('Glucose Level')),
                    DataCell((Text('${widget.testDetails.glucoseLevel}'))),
                    DataCell(Text('70-100')),
                  ]),
                  if (roles != 'User')
                    DataRow(cells: <DataCell>[
                      DataCell(Text('Prediction Result')),
                      DataCell((widget.testDetails.predictionResult == 0
                          ? Text('Negative')
                          : Text('Positive'))),
                      DataCell(Text('')),
                    ]),
                  if (roles != 'User')
                    DataRow(cells: <DataCell>[
                      DataCell(Text('Prediction Percentage')),
                      DataCell(
                          (Text('${widget.testDetails.predictionPrecentage}'))),
                      DataCell(Text('')),
                    ]),
                ]),
            SizedBox(height: 10),
            Text(
              'Additional Information',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline),
            ),
            SizedBox(height: 10),
            DataTable(
                dataTextStyle:
                    TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                border: TableBorder.all(color: Colors.black),
                dividerThickness: 3,
                headingTextStyle: style,
                columns: <DataColumn>[
                  DataColumn(
                      label: Text(
                    'Information',
                  )),
                  DataColumn(
                      label: Text(
                    'Y/N',
                  ))
                ],
                rows: <DataRow>[
                  DataRow(cells: <DataCell>[
                    DataCell(Text('Smoker')),
                    DataCell(
                        (Text(widget.testDetails.smoker == 0 ? 'No' : 'Yes'))),
                  ]),
                  DataRow(cells: <DataCell>[
                    DataCell(Text('Cigarettes Per Day')),
                    DataCell((Text(widget.testDetails.smoker == 0
                        ? 'None'
                        : '${widget.testDetails.numberOfCigarettes}'))),
                  ]),
                  DataRow(cells: <DataCell>[
                    DataCell(Text('Blood Pressure Medicine ')),
                    DataCell((Text(widget.testDetails.bloodPressureMedicine == 0
                        ? 'No'
                        : 'Yes'))),
                  ]),
                  DataRow(cells: <DataCell>[
                    DataCell(Text('Prevalent Stroke')),
                    DataCell((Text(widget.testDetails.prevalentStroke == 0
                        ? 'No'
                        : 'Yes'))),
                  ]),
                  DataRow(cells: <DataCell>[
                    DataCell(Text('Prevalent Hypertension')),
                    DataCell((Text(widget.testDetails.prevalentHypertension == 0
                        ? 'No'
                        : 'Yes'))),
                  ]),
                ]),
          ],
        ),
      ),
    );
  }
}

class GetTestById extends StatefulWidget {
  GetTestById({required this.id});

  int id;

  @override
  State<GetTestById> createState() => _GetTestByIdState();
}

class _GetTestByIdState extends State<GetTestById> {
  TestDetailsModel? labProfileModel;
  final AppoitnmentsService service = AppoitnmentsService(Dio());

  Future<TestDetailsModel> fetchTestDetails() async {
    return await service.getTestDetails(widget.id);
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
            'Info',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: FutureBuilder<TestDetailsModel>(
            future: fetchTestDetails(),
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
                return MedicalTestsInfo(
                  testDetails: snapshot.data!,
                  id: widget.id,
                );
              }
            }));
  }
}
