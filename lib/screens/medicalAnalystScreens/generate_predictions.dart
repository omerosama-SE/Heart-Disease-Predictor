import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:simple_toast_message/simple_toast.dart';

class GeneratePrediction extends StatefulWidget {
  const GeneratePrediction({super.key});

  @override
  State<GeneratePrediction> createState() => _GeneratePredictionState();
}

class _GeneratePredictionState extends State<GeneratePrediction> {
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
  var patientSSN = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      'Patient SSN',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                        height: 50,
                        width: 350,
                        child: TextField(
                          controller: patientSSN,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff00466B)),
                                  borderRadius: BorderRadius.circular(7)),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Enter Patient\'s ID',
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
                SizedBox(width: 147),
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
              ],
            ),
            SizedBox(height: 10),
            RangeFields(
              controller: cpd,
              testName: 'Cigarettes Per Day',
              sizedBoxWidth: 60,
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
                SizedBox(width: 10),
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
                SizedBox(width: 75),
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
                SizedBox(width: 20),
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
                SizedBox(width: 138),
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
              ],
            ),
            SizedBox(height: 10),
            RangeFields(
              controller: cL,
              testName: 'Cholesterol Level',
              sizedBoxWidth: 70,
            ),
            SizedBox(height: 10),
            RangeFields(
              controller: gL,
              testName: 'Glucose Level',
              sizedBoxWidth: 95,
            ),
            SizedBox(height: 10),
            RangeFields(
              controller: sbp,
              testName: 'Systolic Blood Pressure',
              sizedBoxWidth: 18,
            ),
            SizedBox(height: 10),
            RangeFields(
              controller: dbp,
              testName: 'Diastolic Blood Pressure',
              sizedBoxWidth: 10,
            ),
            SizedBox(height: 10),
            RangeFields(
              controller: bmi,
              testName: 'Body Mass Index (BMI)',
              sizedBoxWidth: 20,
            ),
            SizedBox(height: 10),
            RangeFields(
              controller: hr,
              testName: 'Heart Rate',
              sizedBoxWidth: 118,
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 50,
              width: 370,
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
                      patientSSN.text.isEmpty) {
                    SimpleToast.showErrorToast(context, "Missing Values",
                        "Please fill all the fields");
                  } else if (isSmoker == 1 && cpd.text.isEmpty) {
                    SimpleToast.showErrorToast(context, "Missing Values",
                        "Please fill all the fields");
                  } else {
                    print(isSmoker);
                    print(cpd.text);
                    print(hasBPM);
                    print(hasPS);
                    print(hasPH);
                    print(hasDiabetes);
                    print(cL.text);
                    print(gL.text);
                    print(sbp.text);
                    print(dbp.text);
                    print(bmi.text);
                    print(hr.text);
                  }
                },
                child: Text(
                  'Make A Prediction',
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
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class RangeFields extends StatefulWidget {
  RangeFields(
      {required this.controller,
      required this.sizedBoxWidth,
      required this.testName,
      this.smoker = false});

  var controller = TextEditingController();
  double sizedBoxWidth;
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
        SizedBox(width: widget.sizedBoxWidth),
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
            ))
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
