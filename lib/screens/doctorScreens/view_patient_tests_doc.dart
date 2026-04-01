import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_disease_prediction/Components/medical_Tests_cards.dart';
import 'package:heart_disease_prediction/Services/AppoitnmentService.dart';
import 'package:heart_disease_prediction/models/medical_tests_model.dart';
import 'package:heart_disease_prediction/screens/doctorScreens/doctor_appoitnments.dart';
import 'package:heart_disease_prediction/screens/medicalTests_info.dart';

class ViewPatientMedicalTestsDoc extends StatefulWidget {
  ViewPatientMedicalTestsDoc({required this.id});

  int id;

  @override
  State<ViewPatientMedicalTestsDoc> createState() =>
      _ViewPatientMedicalTestsDocState();
}

class _ViewPatientMedicalTestsDocState
    extends State<ViewPatientMedicalTestsDoc> {
  @override
  final borderStyle = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(7)),
    borderSide: BorderSide(color: Colors.grey, width: 1.5),
  );

//get request
  bool isLoading = true;
  int selectedRadio = 0;
  TextEditingController searchController = TextEditingController();
  List<int> testsIds = [];
  List<MedicalTestsModelDoc> medicalTests = [];
  final AppoitnmentsService service = AppoitnmentsService(Dio());

  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _showLoadingIndicator();
      fetchPrescriptions();
    });
  }

  void fetchPrescriptions() async {
    final fetchedTests = await service.getPatientMedicalTestsDoc(widget.id);
    isLoading = false;
    if (_overlayEntry != null) {
      _hideLoadingIndicator();
    }
    setState(() {
      medicalTests = fetchedTests;
      testsIds = medicalTests.map((test) => test.id).toList();
    });
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

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF0F4F7),
      appBar: AppBar(
        leadingWidth: 30,
        backgroundColor: Color(0xffD7E8F0),
        title: Row(
          children: [
            Text(
              'Medical Tests',
              style: TextStyle(color: Colors.black),
            ),
            Spacer(flex: 1),
            ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                      isDismissible: true,
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          child: Wrap(
                            children: [
                              Column(
                                children: [
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Spacer(flex: 1),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Icon(
                                          Icons.close,
                                          size: 25,
                                        ),
                                      ),
                                      Spacer(flex: 7),
                                      Text(
                                        'Sort',
                                        style: TextStyle(
                                            fontSize: 20, fontFamily: 'Myriad'),
                                      ),
                                      Spacer(flex: 10),
                                    ],
                                  ),
                                ],
                              ),
                              Divider(
                                indent: 20,
                                endIndent: 20,
                              ),
                              RadioListTile(
                                activeColor: Color(0xff00466D),
                                value: 0,
                                groupValue: selectedRadio,
                                title: Row(children: [
                                  Text(
                                    'Default',
                                    style: TextStyle(fontFamily: 'Myriad'),
                                  ),
                                ]),
                                onChanged: (value) {
                                  Navigator.pop(context);
                                  setState(() {
                                    selectedRadio = 0;
                                    medicalTests
                                        .sort(((a, b) => a.id.compareTo(b.id)));
                                    testsIds = medicalTests
                                        .map((prescription) => prescription.id)
                                        .toList();
                                  });
                                },
                              ),
                              RadioListTile(
                                activeColor: Color(0xff00466D),
                                value: 1,
                                groupValue: selectedRadio,
                                title: Row(children: [
                                  Text(
                                    'Newset',
                                    style: TextStyle(fontFamily: 'Myriad'),
                                  ),
                                ]),
                                onChanged: (value) {
                                  Navigator.pop(context);
                                  setState(() {
                                    selectedRadio = 1;
                                    medicalTests.sort(((b, a) =>
                                        DateTime.parse(a.date).compareTo(
                                            DateTime.parse(b.date))));
                                    testsIds = medicalTests
                                        .map((prescription) => prescription.id)
                                        .toList();
                                  });
                                },
                              ),
                              RadioListTile(
                                activeColor: Color(0xff00466D),
                                value: 2,
                                groupValue: selectedRadio,
                                title: Row(children: [
                                  Text(
                                    'Oldest',
                                    style: TextStyle(fontFamily: 'Myriad'),
                                  ),
                                ]),
                                onChanged: (value) {
                                  Navigator.pop(context);
                                  setState(() {
                                    selectedRadio = 2;
                                    medicalTests.sort(((a, b) =>
                                        DateTime.parse(a.date).compareTo(
                                            DateTime.parse(b.date))));
                                    testsIds = medicalTests
                                        .map((prescription) => prescription.id)
                                        .toList();
                                  });
                                },
                              ),
                            ],
                          ),
                        );
                      });
                },
                child: SizedBox(
                    width: 25,
                    height: 25,
                    child: Image.asset('assets/images/transfer.png')),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  backgroundColor: Color(0xffD7E8F0),
                )),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 10),
            medicalTests.isEmpty && isLoading == false
                ? EmptyForNothing(
                    text: 'No Tests Found',
                    height: 0.4,
                  )
                : Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: ListView.separated(
                        itemCount: medicalTests.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return GetTestById(
                                    id: testsIds[index],
                                  );
                                }));
                              },
                              child: MedicalTestsCards(
                                test3: medicalTests[index],
                              ));
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 5);
                        },
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
