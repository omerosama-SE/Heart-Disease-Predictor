import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:heart_disease_prediction/Components/empty_pages.dart';
import 'package:heart_disease_prediction/Components/prescriptions_cards.dart';
import 'package:heart_disease_prediction/Services/AppoitnmentService.dart';
import 'package:heart_disease_prediction/models/view_patient_prescriptions_model.dart';
import 'package:heart_disease_prediction/screens/doctorScreens/doctor_appoitnments.dart';
import 'package:heart_disease_prediction/screens/prescriptions_info.dart';

class Prescriptions extends StatefulWidget {
  const Prescriptions({super.key});

  @override
  State<Prescriptions> createState() => _PrescriptionsState();
}

class _PrescriptionsState extends State<Prescriptions> {
  final borderStyle = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(7)),
    borderSide: BorderSide(color: Colors.grey, width: 1.5),
  );

//get Prescriptions//////////////////////
  bool isLoading = true;
  List<int> prescriptionsIds = [];
  List<ViewAllPatientPrescriptionsModel> allPrescriptions = [];
  List<String> patientEmails = [];
  List<int> patientSSN = [];
  List<int> doctorIds = [];
  int selectedRadio = 0;
  TextEditingController searchController = TextEditingController();
  List<ViewAllPatientPrescriptionsModel> searchList = [];
  List<int> searchedPrescriptionsIds = [];
  List<ViewAllPatientPrescriptionsModel> prescriptions = [];
  final AppoitnmentsService service = AppoitnmentsService(Dio());

  void initState() {
    super.initState();
    searchController.addListener(() {
      onSearchChanged();
    });
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _showLoadingIndicator();
      fetchAllPrescriptions();
    });
  }

  void fetchAllPrescriptions() async {
    final fetchedAllPrescriptions = await service.getAllPatientPrescriptions();
    isLoading = false;
    if (_overlayEntry != null) {
      _hideLoadingIndicator();
    }
    setState(() {
      allPrescriptions = fetchedAllPrescriptions;
      searchList = allPrescriptions;
      searchedPrescriptionsIds =
          searchList.map((prescription) => prescription.id).toList();
    });
  }

  onSearchChanged() {
    searchQuery(searchController.text);
  }

  searchQuery(String query) {
    if (query.isNotEmpty) {
      setState(() {
        searchList = allPrescriptions
            .where(
                (item) => item.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
        searchedPrescriptionsIds =
            searchList.map((doctor) => doctor.id).toList();
      });
    } else {
      searchList = allPrescriptions;
      searchedPrescriptionsIds = searchList.map((doctor) => doctor.id).toList();
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

  ////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF0F4F7),
      appBar: AppBar(
          leadingWidth: 30,
          backgroundColor: Color(0xffD7E8F0),
          title: Text(
            'Prescriptions',
            style: TextStyle(color: Colors.black),
          )),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 5),
            if (allPrescriptions.isNotEmpty)
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
                                                searchedPrescriptionsIds =
                                                    searchList
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
                                                searchedPrescriptionsIds =
                                                    searchList
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
                                                searchedPrescriptionsIds =
                                                    searchList
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
            SizedBox(height: 5),
            searchList.isEmpty && isLoading == false
                ? EmptyForNothing(
                    text: 'No Prescriptions Found',
                    height: 0.4,
                  )
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
                                  return GetPrescriptionByIdForPatient(
                                    id: searchedPrescriptionsIds[index],
                                  );
                                }));
                              },
                              child: ViewPatientPrescriptionsCards(
                                allPrescriptions: searchList[index],
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
