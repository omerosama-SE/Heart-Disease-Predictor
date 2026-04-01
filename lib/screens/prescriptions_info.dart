import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_disease_prediction/Services/AppoitnmentService.dart';
import 'package:heart_disease_prediction/models/prescription_info.dart';

class PrescriptionsInfoForDoctor extends StatelessWidget {
  PrescriptionsInfoForDoctor(
      {required this.prescriptionInfo, required this.id, required this.name});

  PrescriptionInfoModel prescriptionInfo;
  int id;
  String name;

  final borderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      borderSide: BorderSide(color: Colors.grey, width: 1.5));

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 15),
          Container(
            width: MediaQuery.of(context).size.width * 0.98,
            height: MediaQuery.of(context).size.height * 0.88,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color:
                      Colors.grey.withOpacity(0.3), // More transparent shadow
                  spreadRadius: 2, // Reduced spread radius
                  blurRadius: 4, // Reduced blur radius
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dr. ${prescriptionInfo.doctorName.split(" ").map((str) => str[0].toUpperCase() + str.substring(1)).join(" ")}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Cardiologist Specialist',
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(height: 5),
                    Divider(
                      endIndent: 15,
                      thickness: 2,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'Name : ',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          '$name',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          'Date : ',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          '${DateTime.parse(prescriptionInfo.date).toIso8601String().substring(0, 10)}',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        SizedBox(
                            width: 50,
                            height: 50,
                            child: Image.asset(
                                'assets/images/prescription (2).png')),
                        Text(
                          '/',
                          style: TextStyle(fontSize: 40),
                        )
                      ],
                    ),
                    // SizedBox(
                    //   height: 100,
                    //   width: 350,
                    //   child: TextField(
                    //       readOnly: true,
                    //       decoration: InputDecoration(
                    //         hintText: 'Treatments',
                    //         border: borderStyle,
                    //         focusedBorder: borderStyle,
                    //         enabledBorder: borderStyle,
                    //       )),
                    // ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 70),
                      child: Text(
                        '${prescriptionInfo.medicineName}',
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GetPrescriptionByIdForDoctor extends StatefulWidget {
  // used in view appointment --> view patient --> view his prescriptions related to specific doctor (DoctorAccount)
  GetPrescriptionByIdForDoctor({required this.id, required this.name});

  int id;
  String name;

  @override
  State<GetPrescriptionByIdForDoctor> createState() =>
      _GetPrescriptionByIdForDoctorState();
}

class _GetPrescriptionByIdForDoctorState
    extends State<GetPrescriptionByIdForDoctor> {
  PrescriptionInfoModel? PrescriptionInfo;
  final AppoitnmentsService service = AppoitnmentsService(Dio());

  Future<PrescriptionInfoModel> fetchPrescriptionInfo() async {
    return await service.getPrescriptionInfo(widget.id);
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
            leadingWidth: 30,
            backgroundColor: Color(0xffD7E8F0),
            title: Text(
              'Info',
              style: TextStyle(color: Colors.black),
            )),
        body: FutureBuilder<PrescriptionInfoModel>(
          future: fetchPrescriptionInfo(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                _showLoadingIndicator();
              });
              return SizedBox.shrink();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}'); // Error state
            } else {
              if (_overlayEntry != null) {
                _hideLoadingIndicator();
              }
              return PrescriptionsInfoForDoctor(
                prescriptionInfo: snapshot.data!,
                id: widget.id,
                name: widget.name,
              ); // Data state
            }
          },
        ));
  }
}

class PrescriptionsInfoForPatient extends StatelessWidget {
  PrescriptionsInfoForPatient({required this.prescriptionInfo});

  PrescriptionInfoModel prescriptionInfo;

  final borderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      borderSide: BorderSide(color: Colors.grey, width: 1.5));

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 15),
          Container(
            width: MediaQuery.of(context).size.width * 0.98,
            height: MediaQuery.of(context).size.height * 0.88,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color:
                      Colors.grey.withOpacity(0.3), // More transparent shadow
                  spreadRadius: 2, // Reduced spread radius
                  blurRadius: 4, // Reduced blur radius
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dr. ${prescriptionInfo.doctorName.split(" ").map((str) => str[0].toUpperCase() + str.substring(1)).join(" ")}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Cardiologist Specialist',
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(height: 5),
                    Divider(
                      endIndent: 15,
                      thickness: 2,
                      color: Colors.grey,
                    ),
                    // SizedBox(height: 10),
                    // Row(
                    //   children: [
                    //     Text(
                    //       'Name : ',
                    //       style: TextStyle(fontSize: 18),
                    //     ),
                    //     Text(
                    //       '$name',
                    //       style: TextStyle(
                    //           fontSize: 20, fontWeight: FontWeight.bold),
                    //     ),
                    //   ],
                    // ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          'Date : ',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          '${DateTime.parse(prescriptionInfo.date).toIso8601String().substring(0, 10)}',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        SizedBox(
                            width: 50,
                            height: 50,
                            child: Image.asset(
                                'assets/images/prescription (2).png')),
                        Text(
                          '/',
                          style: TextStyle(fontSize: 40),
                        ),
                      ],
                    ),
                    // SizedBox(
                    //   height: 100,
                    //   width: 350,
                    //   child: TextField(
                    //       readOnly: true,
                    //       decoration: InputDecoration(
                    //         hintText: 'Treatments',
                    //         border: borderStyle,
                    //         focusedBorder: borderStyle,
                    //         enabledBorder: borderStyle,
                    //       )),
                    // ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 70),
                      child: Text(
                        '${prescriptionInfo.medicineName}',
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GetPrescriptionByIdForPatient extends StatefulWidget {
  //View Prescriptions (PatientAccount)
  GetPrescriptionByIdForPatient({required this.id});

  int id;

  @override
  State<GetPrescriptionByIdForPatient> createState() =>
      _GetPrescriptionByIdForPatientState();
}

class _GetPrescriptionByIdForPatientState
    extends State<GetPrescriptionByIdForPatient> {
  PrescriptionInfoModel? PrescriptionInfo;
  final AppoitnmentsService service = AppoitnmentsService(Dio());

  Future<PrescriptionInfoModel> fetchPrescriptionInfo() async {
    return await service.getPrescriptionInfo(widget.id);
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
          leadingWidth: 30,
          backgroundColor: Color(0xffD7E8F0),
          title: Text(
            'Info',
            style: TextStyle(color: Colors.black),
          )),
      body: FutureBuilder<PrescriptionInfoModel>(
        future: fetchPrescriptionInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              _showLoadingIndicator();
            });
            return SizedBox.shrink();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}'); // Error state
          } else {
            if (_overlayEntry != null) {
              _hideLoadingIndicator();
            }
            return PrescriptionsInfoForPatient(
              prescriptionInfo: snapshot.data!,
            ); // Data state
          }
        },
      ),
    );
  }
}
