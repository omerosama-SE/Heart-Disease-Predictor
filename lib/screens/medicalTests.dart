import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_disease_prediction/Components/empty_pages.dart';
import 'package:heart_disease_prediction/Components/medical_Tests_cards.dart';
import 'package:heart_disease_prediction/Services/AppoitnmentService.dart';
import 'package:heart_disease_prediction/main.dart';
import 'package:heart_disease_prediction/models/medical_tests_model.dart';
import 'package:heart_disease_prediction/screens/appoitments.dart';
import 'package:heart_disease_prediction/screens/doctorScreens/doctor_appoitnments.dart';
import 'package:heart_disease_prediction/screens/medicalTests_info.dart';

//Medical Test View from patient pov
class UserMedicalTests extends StatefulWidget {
  const UserMedicalTests({super.key});

  @override
  State<UserMedicalTests> createState() => _UserMedicalTestsState();
}

class _UserMedicalTestsState extends State<UserMedicalTests> {
  final borderStyle = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(7)),
    borderSide: BorderSide(color: Colors.grey, width: 1.5),
  );

  bool isEmpty = false;
  bool isLoading = true;
  int selectedRadio = 0;
  TextEditingController searchController = TextEditingController();
  List<MedicalTestsModel> medicalTests = [];
  List<MedicalTestsModel> searchList = [];
  List<int> searchedTestsIds = [];
  List<int> testsIds = [];

  final AppoitnmentsService service = AppoitnmentsService(Dio());

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      onSearchChanged();
    });
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _showLoadingIndicator();
      fetchMedicalTests();
    });
  }

  void fetchMedicalTests() async {
    final fetchedTests = await service.getMedicalTests();
    isLoading = false;
    if (fetchedTests.isEmpty) {
      isEmpty = true;
    }
    if (_overlayEntry != null) {
      _hideLoadingIndicator();
    }
    setState(() {
      medicalTests = fetchedTests;
      searchList = medicalTests;
      searchedTestsIds = searchList.map((test) => test.id).toList();
    });
  }

// Loading indicator
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
          ]),
        ),
      ),
    );

    Overlay.of(context)?.insert(_overlayEntry!);
  }

  void _hideLoadingIndicator() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  onSearchChanged() {
    searchQuery(searchController.text);
  }

  searchQuery(String query) {
    if (query.isNotEmpty) {
      setState(() {
        searchList = medicalTests
            .where((item) =>
                item.labName.toLowerCase().contains(query.toLowerCase()))
            .toList();
        searchedTestsIds = searchList.map((test) => test.id).toList();
      });
    } else {
      searchList = medicalTests;
      searchedTestsIds = searchList.map((test) => test.id).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF0F4F7),
      appBar: AppBar(
          leadingWidth: 30,
          backgroundColor: Color(0xffD7E8F0),
          title: Text(
            'Medical Tests',
            style: TextStyle(color: Colors.black),
          )),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 5),
            if (medicalTests.isNotEmpty)
              Container(
                width: MediaQuery.of(context).size.width * 0.97,
                height: MediaQuery.of(context).size.height * 0.065,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    Row(
                      children: [
                        SizedBox(width: 10),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.61,
                          height: MediaQuery.of(context).size.width * 0.1,
                          child: TextField(
                              controller: searchController,
                              cursorColor: Color(0xff004670),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 20),
                                  hintText: 'Search By Name',
                                  prefixIcon: Icon(Icons.search),
                                  border: borderStyle,
                                  focusedBorder: borderStyle,
                                  enabledBorder: borderStyle)),
                        ),
                        SizedBox(width: 5),
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
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Spacer(flex: 1),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .pop();
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
                                                        fontSize: 20,
                                                        fontFamily: 'Myriad'),
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
                                                style: TextStyle(
                                                    fontFamily: 'Myriad'),
                                              ),
                                            ]),
                                            onChanged: (value) {
                                              Navigator.pop(context);
                                              setState(() {
                                                selectedRadio = 0;
                                                searchList.sort(((a, b) =>
                                                    a.id.compareTo(b.id)));
                                                searchedTestsIds = searchList
                                                    .map((prescription) =>
                                                        prescription.id)
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
                                                style: TextStyle(
                                                    fontFamily: 'Myriad'),
                                              ),
                                            ]),
                                            onChanged: (value) {
                                              Navigator.pop(context);
                                              setState(() {
                                                selectedRadio = 1;
                                                searchList.sort(((b, a) =>
                                                    DateTime.parse(a.date)
                                                        .compareTo(
                                                            DateTime.parse(
                                                                b.date))));
                                                searchedTestsIds = searchList
                                                    .map((prescription) =>
                                                        prescription.id)
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
                                                style: TextStyle(
                                                    fontFamily: 'Myriad'),
                                              ),
                                            ]),
                                            onChanged: (value) {
                                              Navigator.pop(context);
                                              setState(() {
                                                selectedRadio = 2;
                                                searchList.sort(((a, b) =>
                                                    DateTime.parse(a.date)
                                                        .compareTo(
                                                            DateTime.parse(
                                                                b.date))));
                                                searchedTestsIds = searchList
                                                    .map((prescription) =>
                                                        prescription.id)
                                                    .toList();
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                            },
                            child: Row(
                              children: [
                                SizedBox(
                                    width: 25,
                                    height: 25,
                                    child: Image.asset(
                                        'assets/images/transfer.png')),
                                SizedBox(width: 10),
                                Text(
                                  'Sort',
                                  style: TextStyle(
                                      color: Colors.grey[700], fontSize: 18),
                                ),
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7)),
                                backgroundColor: Colors.white,
                                fixedSize: Size(
                                    MediaQuery.of(context).size.width * 0.3,
                                    MediaQuery.of(context).size.width * 0.1),
                                side: BorderSide(
                                    color: Color(0xff969696), width: 1.5))),
                        // Spacer(flex: 2),

                        // Spacer(flex: 1),
                      ],
                    ),
                  ],
                ),
              ),
            SizedBox(height: 10),
            oneOrTwo == 2
                ? medicalTests.isEmpty && isLoading == false
                    ? EmptyPage(text: 'Tests')
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
                                      return GetTestById(id: testsIds[index]);
                                    }));
                                  },
                                  child: MedicalTestsCards(
                                    test: medicalTests[index],
                                  ));
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 5);
                            },
                          ),
                        ),
                      )
                : searchList.isEmpty && isLoading == false
                    ? EmptyForNothing(text: 'No Tests Found', height: 0.4)
                    : Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: ListView.separated(
                            itemCount: searchList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return GetTestById(
                                          id: searchedTestsIds[index]);
                                    }));
                                  },
                                  child: MedicalTestsCards(
                                    test: searchList[index],
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

//Medical Test View from Doctor and Medical Analyst pov
class DoctorMedicalAnalystMedicalTests extends StatefulWidget {
  const DoctorMedicalAnalystMedicalTests({super.key});

  @override
  State<DoctorMedicalAnalystMedicalTests> createState() =>
      _DoctorMedicalAnalystUserMedicalTestsState();
}

class _DoctorMedicalAnalystUserMedicalTestsState
    extends State<DoctorMedicalAnalystMedicalTests> {
  final borderStyle = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(7)),
    borderSide: BorderSide(color: Colors.grey, width: 1.5),
  );

  bool isEmpty = false;
  bool isLoading = true;
  int selectedRadio = 0;
  TextEditingController searchController = TextEditingController();
  List<MedicalTestsModelLab> tests = [];
  List<MedicalTestsModelLab> searchList = [];
  List<int> searchedtestsIds = [];
  final AppoitnmentsService service = AppoitnmentsService(Dio());

  void initState() {
    super.initState();
    searchController.addListener(() {
      onSearchChanged();
    });
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _showLoadingIndicator();
      fetchPrescriptions();
    });
  }

  void fetchPrescriptions() async {
    final fetchedTests = await service.getAllTests();
    isLoading = false;
    if (_overlayEntry != null) {
      _hideLoadingIndicator();
    }
    setState(() {
      tests = fetchedTests;
      searchList = tests;
      searchedtestsIds = tests.map((test) => test.id).toList();
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

  onSearchChanged() {
    searchQuery(searchController.text);
  }

  searchQuery(String query) {
    if (query.isNotEmpty) {
      setState(() {
        searchList = tests
            .where((test) =>
                test.patientName.toLowerCase().contains(query.toLowerCase()))
            .toList();
        searchedtestsIds = searchList.map((test) => test.id).toList();
      });
    } else {
      searchList = tests;
      searchedtestsIds = searchList.map((test) => test.id).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF0F4F7),
      appBar: AppBar(
          leadingWidth: 30,
          backgroundColor: Color(0xffD7E8F0),
          title: Text(
            'Medical Tests',
            style: TextStyle(color: Colors.black),
          )),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 5),
            if (tests.isNotEmpty)
              Container(
                width: MediaQuery.of(context).size.width * 0.97,
                height: MediaQuery.of(context).size.height * 0.065,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    Row(
                      children: [
                        SizedBox(width: 10),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.61,
                          height: MediaQuery.of(context).size.width * 0.1,
                          child: TextField(
                              controller: searchController,
                              cursorColor: Color(0xff004670),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 20),
                                  hintText: 'Search By Name',
                                  prefixIcon: Icon(Icons.search),
                                  border: borderStyle,
                                  focusedBorder: borderStyle,
                                  enabledBorder: borderStyle)),
                        ),
                        SizedBox(width: 5),
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
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Spacer(flex: 1),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .pop();
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
                                                        fontSize: 20,
                                                        fontFamily: 'Myriad'),
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
                                                style: TextStyle(
                                                    fontFamily: 'Myriad'),
                                              ),
                                            ]),
                                            onChanged: (value) {
                                              Navigator.pop(context);
                                              setState(() {
                                                selectedRadio = 0;
                                                searchList.sort(((a, b) =>
                                                    a.id.compareTo(b.id)));
                                                searchedtestsIds = searchList
                                                    .map((test) => test.id)
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
                                                style: TextStyle(
                                                    fontFamily: 'Myriad'),
                                              ),
                                            ]),
                                            onChanged: (value) {
                                              Navigator.pop(context);
                                              setState(() {
                                                selectedRadio = 1;
                                                searchList.sort(((b, a) =>
                                                    DateTime.parse(a.date)
                                                        .compareTo(
                                                            DateTime.parse(
                                                                b.date))));
                                                searchedtestsIds = searchList
                                                    .map((test) => test.id)
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
                                                style: TextStyle(
                                                    fontFamily: 'Myriad'),
                                              ),
                                            ]),
                                            onChanged: (value) {
                                              Navigator.pop(context);
                                              setState(() {
                                                selectedRadio = 2;
                                                searchList.sort(((a, b) =>
                                                    DateTime.parse(a.date)
                                                        .compareTo(
                                                            DateTime.parse(
                                                                b.date))));
                                                searchedtestsIds = searchList
                                                    .map((test) => test.id)
                                                    .toList();
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                            },
                            child: Row(
                              children: [
                                SizedBox(
                                    width: 25,
                                    height: 25,
                                    child: Image.asset(
                                        'assets/images/transfer.png')),
                                SizedBox(width: 10),
                                Text(
                                  'Sort',
                                  style: TextStyle(
                                      color: Colors.grey[700], fontSize: 18),
                                ),
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7)),
                                backgroundColor: Colors.white,
                                fixedSize: Size(
                                    MediaQuery.of(context).size.width * 0.3,
                                    MediaQuery.of(context).size.width * 0.1),
                                side: BorderSide(
                                    color: Color(0xff969696), width: 1.5))),
                        // Spacer(flex: 2),

                        // Spacer(flex: 1),
                      ],
                    ),
                  ],
                ),
              ),
            SizedBox(height: 5),
            searchList.isEmpty && isLoading == false
                ? EmptyForNothing(text: 'No Tests Found', height: 0.4)
                : Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: ListView.separated(
                        itemCount: searchList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return GetTestById(
                                      id: searchedtestsIds[index]);
                                }));
                              },
                              child: MedicalTestsCards(
                                test2: searchList[index],
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
