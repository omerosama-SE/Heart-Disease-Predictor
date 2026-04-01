import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:heart_disease_prediction/Services/AppoitnmentService.dart';
import 'package:heart_disease_prediction/screens/medicalAnalystScreens/lab_appointments.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:simple_toast_message/simple_toast.dart';

class AddMedicalTest extends StatefulWidget {
  AddMedicalTest({
    required this.id,
    required this.age,
    required this.gender,
  });
  int id;
  int age;
  int gender;
  @override
  State<AddMedicalTest> createState() => _AddMedicalTestState();
}

class _AddMedicalTestState extends State<AddMedicalTest> {
  int isSmoker = -1;
  int hasBPM = -1;
  int hasPS = -1;
  int hasPH = -1;
  int hasDiabetes = -1;
  var cpd = TextEditingController();
  var cL = TextEditingController();
  var sbp = TextEditingController();
  var dbp = TextEditingController();
  var bmi = TextEditingController();
  var hr = TextEditingController();
  var gL = TextEditingController();
  var superVisor = TextEditingController();

  //Post Method
  AppoitnmentsService service = AppoitnmentsService(Dio());

  void handleAddTest() async {
    try {
      Response response = await service.AddMedcialTest(
          id: widget.id,
          age: widget.age,
          gender: widget.gender,
          smoking: isSmoker,
          numberOfCigarettes: isSmoker == 0 ? 0 : cpd.text,
          bloodPressureMedicine: hasBPM,
          prevalentStroke: hasPS,
          prevalentHyperTension: hasPH,
          diabetes: hasDiabetes,
          cholesterolLevel: cL.text,
          systolicBloodPressure: sbp.text,
          diastolicBloodPressure: dbp.text,
          bMI: bmi.text,
          heartRate: hr.text,
          glucoseLevel: gL.text,
          superVisorName: superVisor.text,
          date: "2024-04-24T22:21:59.748Z");

      if (response.statusCode == 200) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: 'Test Added Successfully!',
          barrierDismissible: false,
          confirmBtnText: 'OK',
          confirmBtnColor: Color(0xff14C06A),
          onConfirmBtnTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        );
      }
    } catch (e) {
      print(e);
    } finally {
      _hideLoadingIndicator();
    }
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
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xffF0F4F7),
      appBar: AppBar(
        backgroundColor: Color(0xffD7E8F0),
        title: Text(
          'Add Medical Test',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        leadingWidth: 30,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            Row(
              children: [
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Supervisor',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextField(
                          controller: superVisor,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff00466B)),
                                  borderRadius: BorderRadius.circular(7)),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Enter your name',
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7)))),
                        )),
                  ],
                )
              ],
            ),
            SizedBox(height: 10),

            Text(
              'Heart Disease Risk Factors',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                SizedBox(width: 20),
                Text(
                  'Smoker',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                // SizedBox(width: 147),
                Spacer(flex: 12),
                SizedBox(
                  height: 30,
                  width: 80,
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isSmoker = 1;
                        });
                      },
                      child: Text(
                        'Yes',
                        style: TextStyle(
                            color: isSmoker == 1
                                ? Colors.white
                                : Color(0xff00466B),
                            fontSize: 15),
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7)),
                          backgroundColor: isSmoker == 1
                              ? Color(0xff00466B)
                              : Color(0xffD7E8F0),
                          fixedSize: Size(130, 50),
                          side: BorderSide(color: Color(0xff00466B)))),
                ),
                SizedBox(width: 10),
                SizedBox(
                  height: 30,
                  width: 70,
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isSmoker = 0;
                        });
                      },
                      child: Text(
                        'No',
                        style: TextStyle(
                            color: isSmoker == 0
                                ? Colors.white
                                : Color(0xff00466B),
                            fontSize: 15),
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7)),
                          backgroundColor: isSmoker == 0
                              ? Color(0xff00466B)
                              : Color(0xffD7E8F0),
                          fixedSize: Size(130, 50),
                          side: BorderSide(color: Color(0xff00466B)))),
                ),
                Spacer(flex: 1),
              ],
            ),
            SizedBox(height: 10),
            RangeFields(
              controller: cpd,
              testName: 'Cigarettes Per Day',
              startSpacerFlex: 6,
              endSpacerFlex: 1,
              smoker: isSmoker == 1 ? false : true,
            ),
            SizedBox(height: 10),
            Row(
              children: [
                SizedBox(width: 20),
                Text(
                  'Blood Pressure Medicine',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                Spacer(flex: 3),
                SizedBox(
                  height: 30,
                  width: 80,
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          hasBPM = 1;
                        });
                      },
                      child: Text(
                        'Yes',
                        style: TextStyle(
                            color:
                                hasBPM == 1 ? Colors.white : Color(0xff00466B),
                            fontSize: 15),
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7)),
                          backgroundColor: hasBPM == 1
                              ? Color(0xff00466B)
                              : Color(0xffD7E8F0),
                          fixedSize: Size(130, 50),
                          side: BorderSide(color: Color(0xff00466B)))),
                ),
                SizedBox(width: 10),
                SizedBox(
                  height: 30,
                  width: 70,
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          hasBPM = 0;
                        });
                      },
                      child: Text(
                        'No',
                        style: TextStyle(
                            color:
                                hasBPM == 0 ? Colors.white : Color(0xff00466B),
                            fontSize: 15),
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7)),
                          backgroundColor: hasBPM == 0
                              ? Color(0xff00466B)
                              : Color(0xffD7E8F0),
                          fixedSize: Size(130, 50),
                          side: BorderSide(color: Color(0xff00466B)))),
                ),
                Spacer(flex: 1),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(width: 20),
                Text(
                  'Prevalent Stroke',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                Spacer(flex: 7),
                SizedBox(
                  height: 30,
                  width: 80,
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          hasPS = 1;
                        });
                      },
                      child: Text(
                        'Yes',
                        style: TextStyle(
                            color:
                                hasPS == 1 ? Colors.white : Color(0xff00466B),
                            fontSize: 15),
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7)),
                          backgroundColor: hasPS == 1
                              ? Color(0xff00466B)
                              : Color(0xffD7E8F0),
                          fixedSize: Size(130, 50),
                          side: BorderSide(color: Color(0xff00466B)))),
                ),
                SizedBox(width: 10),
                SizedBox(
                  height: 30,
                  width: 70,
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          hasPS = 0;
                        });
                      },
                      child: Text(
                        'No',
                        style: TextStyle(
                            color:
                                hasPS == 0 ? Colors.white : Color(0xff00466B),
                            fontSize: 15),
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7)),
                          backgroundColor: hasPS == 0
                              ? Color(0xff00466B)
                              : Color(0xffD7E8F0),
                          fixedSize: Size(130, 50),
                          side: BorderSide(color: Color(0xff00466B)))),
                ),
                Spacer(flex: 1),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(width: 20),
                Text(
                  'Prevalent Hypertension',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                Spacer(flex: 4),
                SizedBox(
                  height: 30,
                  width: 80,
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          hasPH = 1;
                        });
                      },
                      child: Text(
                        'Yes',
                        style: TextStyle(
                            color:
                                hasPH == 1 ? Colors.white : Color(0xff00466B),
                            fontSize: 15),
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7)),
                          backgroundColor: hasPH == 1
                              ? Color(0xff00466B)
                              : Color(0xffD7E8F0),
                          fixedSize: Size(130, 50),
                          side: BorderSide(color: Color(0xff00466B)))),
                ),
                SizedBox(width: 10),
                SizedBox(
                  height: 30,
                  width: 70,
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          hasPH = 0;
                        });
                      },
                      child: Text(
                        'No',
                        style: TextStyle(
                            color:
                                hasPH == 0 ? Colors.white : Color(0xff00466B),
                            fontSize: 15),
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7)),
                          backgroundColor: hasPH == 0
                              ? Color(0xff00466B)
                              : Color(0xffD7E8F0),
                          fixedSize: Size(130, 50),
                          side: BorderSide(color: Color(0xff00466B)))),
                ),
                Spacer(flex: 1),
              ],
            ),
            // SizedBox(height: 10),
            // Text(
            //   'Relevant Information',
            //   style: TextStyle(
            //       fontSize: 20,
            //       fontWeight: FontWeight.bold,
            //       decoration: TextDecoration.underline),
            // ),
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(width: 20),
                Text(
                  'Diabetes',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                Spacer(flex: 10),
                SizedBox(
                  height: 30,
                  width: 80,
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          hasDiabetes = 1;
                        });
                      },
                      child: Text(
                        'Yes',
                        style: TextStyle(
                            color: hasDiabetes == 1
                                ? Colors.white
                                : Color(0xff00466B),
                            fontSize: 15),
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7)),
                          backgroundColor: hasDiabetes == 1
                              ? Color(0xff00466B)
                              : Color(0xffD7E8F0),
                          fixedSize: Size(130, 50),
                          side: BorderSide(color: Color(0xff00466B)))),
                ),
                SizedBox(width: 10),
                SizedBox(
                  height: 30,
                  width: 70,
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          hasDiabetes = 0;
                        });
                      },
                      child: Text(
                        'No',
                        style: TextStyle(
                            color: hasDiabetes == 0
                                ? Colors.white
                                : Color(0xff00466B),
                            fontSize: 15),
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7)),
                          backgroundColor: hasDiabetes == 0
                              ? Color(0xff00466B)
                              : Color(0xffD7E8F0),
                          fixedSize: Size(130, 50),
                          side: BorderSide(color: Color(0xff00466B)))),
                ),
                Spacer(flex: 1),
              ],
            ),
            SizedBox(height: 10),
            RangeFields(
              controller: cL,
              testName: 'Cholesterol Level',
              startSpacerFlex: 6,
              endSpacerFlex: 1,
            ),
            SizedBox(height: 10),
            RangeFields(
              controller: gL,
              testName: 'Glucose Level',
              startSpacerFlex: 7,
              endSpacerFlex: 1,
            ),
            SizedBox(height: 10),
            RangeFields(
              controller: sbp,
              testName: 'Systolic Blood Pressure',
              startSpacerFlex: 3,
              endSpacerFlex: 1,
            ),
            SizedBox(height: 10),
            RangeFields(
              controller: dbp,
              testName: 'Diastolic Blood Pressure',
              startSpacerFlex: 5,
              endSpacerFlex: 2,
            ),
            SizedBox(height: 10),
            RangeFields(
              controller: bmi,
              testName: 'Body Mass Index (BMI)',
              startSpacerFlex: 8,
              endSpacerFlex: 3,
            ),
            SizedBox(height: 10),
            RangeFields(
              controller: hr,
              testName: 'Heart Rate',
              startSpacerFlex: 6,
              endSpacerFlex: 1,
            ),
            // Spacer(flex: 7),
            SizedBox(height: 20),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.9,
              child: ElevatedButton(
                onPressed: () {
                  if (isSmoker == -1 ||
                      hasBPM == -1 ||
                      hasPS == -1 ||
                      hasPH == -1 ||
                      hasDiabetes == -1 ||
                      cL.text.isEmpty ||
                      gL.text.isEmpty ||
                      sbp.text.isEmpty ||
                      dbp.text.isEmpty ||
                      bmi.text.isEmpty ||
                      hr.text.isEmpty ||
                      superVisor.text.isEmpty) {
                    CherryToast.error(
                            toastPosition: Position.bottom,
                            title: Text("Missing Input",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold)),
                            description: Text("Please fill all fields",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15)),
                            animationType: AnimationType.fromRight,
                            animationDuration: Duration(milliseconds: 1000),
                            autoDismiss: true)
                        .show(context);
                  } else if (isSmoker == 1 && cpd.text.isEmpty) {
                    CherryToast.error(
                            toastPosition: Position.bottom,
                            title: Text("Missing Input",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold)),
                            description: Text("Please fill all fields",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15)),
                            animationType: AnimationType.fromRight,
                            animationDuration: Duration(milliseconds: 1000),
                            autoDismiss: true)
                        .show(context);
                  } else {
                    _showLoadingIndicator();
                    handleAddTest();
                  }
                },
                child: Text(
                  'Add Test',
                  style: TextStyle(color: Color(0xff00466B), fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7)),
                    backgroundColor: Color(0xffD7E8F0),
                    fixedSize: Size(130, 50),
                    side: BorderSide(color: Color(0xff00466B))),
              ),
            ),
            // Spacer(flex: 5),
          ],
        ),
      ),
    );
  }
}

class RangeFields extends StatefulWidget {
  RangeFields(
      {required this.controller,
      // required this.sizedBoxWidth,
      required this.startSpacerFlex,
      required this.endSpacerFlex,
      required this.testName,
      this.smoker = false});

  var controller = TextEditingController();
  int startSpacerFlex;
  int endSpacerFlex;
  // double sizedBoxWidth;
  String testName;
  bool smoker;

  @override
  State<RangeFields> createState() => _RangeFieldsState();
}

class _RangeFieldsState extends State<RangeFields> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 20),
        Text(
          '${widget.testName}',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        // SizedBox(width: widget.sizedBoxWidth),
        Spacer(flex: widget.startSpacerFlex),
        SizedBox(
            height: 45,
            width: 160,
            child: TextField(
              controller: widget.controller,
              textAlignVertical: TextAlignVertical.top,
              keyboardType: TextInputType.number,
              readOnly: widget.smoker,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff00466B)),
                      borderRadius: BorderRadius.circular(7)),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7)))),
            )),
        Spacer(flex: widget.endSpacerFlex)
      ],
    );
  }
}

class YN extends StatefulWidget {
  YN({required this.yn, required this.testName, required this.sizedBoxWidth});
  int yn;
  String testName;
  double sizedBoxWidth;
  @override
  State<YN> createState() => _YNState();
}

class _YNState extends State<YN> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 20),
        Text(
          '${widget.testName}',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: widget.sizedBoxWidth),
        SizedBox(
          height: 30,
          width: 80,
          child: ElevatedButton(
              onPressed: () {
                setState(() {
                  widget.yn = 1;
                  print('this is ${widget.testName} : ${widget.yn}');
                });
              },
              child: Text(
                'Yes',
                style: TextStyle(
                    color: widget.yn == 1 ? Colors.white : Color(0xff00466B),
                    fontSize: 15),
              ),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7)),
                  backgroundColor:
                      widget.yn == 1 ? Color(0xff00466B) : Color(0xffD7E8F0),
                  fixedSize: Size(130, 50),
                  side: BorderSide(color: Color(0xff00466B)))),
        ),
        SizedBox(width: 10),
        SizedBox(
          height: 30,
          width: 70,
          child: ElevatedButton(
              onPressed: () {
                setState(() {
                  widget.yn = 0;
                  print('this is ${widget.testName} : ${widget.yn}');
                });
              },
              child: Text(
                'No',
                style: TextStyle(
                    color: widget.yn == 0 ? Colors.white : Color(0xff00466B),
                    fontSize: 15),
              ),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7)),
                  backgroundColor:
                      widget.yn == 0 ? Color(0xff00466B) : Color(0xffD7E8F0),
                  fixedSize: Size(130, 50),
                  side: BorderSide(color: Color(0xff00466B)))),
        ),
      ],
    );
  }
}
