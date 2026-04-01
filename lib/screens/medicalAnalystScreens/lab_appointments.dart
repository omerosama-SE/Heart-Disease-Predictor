import 'package:dio/dio.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:heart_disease_prediction/Components/lab_patients_cards.dart';
import 'package:heart_disease_prediction/Services/AppoitnmentService.dart';
import 'package:heart_disease_prediction/models/patients_list_model.dart';
import 'package:heart_disease_prediction/screens/doctorScreens/doctor_appoitnments.dart';

class LabAppointments extends StatefulWidget {
  const LabAppointments({super.key});

  @override
  State<LabAppointments> createState() => _LabAppointmentsState();
}

class _LabAppointmentsState extends State<LabAppointments> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  AppoitnmentsService service = AppoitnmentsService(Dio());
  List<PatientsListForLabModel> patients = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance?.addPostFrameCallback((_) {
    //   _showLoadingIndicator();

    // });
    fetchReservedPatients();
  }

  void fetchReservedPatients() async {
    var fetchedPatients = await service.getReservedPatientsForLab();
    // if (_overlayEntry != null) {
    //   _hideLoadingIndicator();
    // }
    isLoading = false;
    setState(() {
      for (int x = 0; x < fetchedPatients.length; x++) {
        var patientsForSelectedDay = fetchedPatients[x];
        DateTime date = DateTime.parse(patientsForSelectedDay.date);
        DateTime now = DateTime.now();
        if (date.day == now.day &&
            date.month == now.month &&
            date.year == now.year) {
          patients.add(patientsForSelectedDay);
        }
      }
    });
  }

  void fetchPatientsForDay(DateTime selectedDay) async {
    var fetchedPatients = await service.getReservedPatientsForLab();
    isLoading = false;
    patients.clear();
    setState(() {
      for (int x = 0; x < fetchedPatients.length; x++) {
        var patientsForSelectedDay = fetchedPatients[x];
        DateTime date = DateTime.parse(patientsForSelectedDay.date);
        if (date.day == selectedDay.day &&
            date.month == selectedDay.month &&
            date.year == selectedDay.year) {
          patients.add(patientsForSelectedDay);
        }
      }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF0F4F7),
      appBar: AppBar(
        backgroundColor: Color(0xffD7E8F0),
        title: Text(
          'Lab Appointments',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        leadingWidth: 30,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 10),
            EasyInfiniteDateTimeLine(
              activeColor: Color(0xffD7E8F0),
              focusDate: _focusedDay,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(Duration(days: 15)),
              onDateChange: (selectedDate) {
                setState(() {
                  _focusedDay = selectedDate;
                  isLoading = true;
                  fetchPatientsForDay(selectedDate);
                });
              },
            ),
            SizedBox(height: 10),
            isLoading
                ? CircularProgressIndicator(
                    color: Color(0xff00466B),
                  )
                : patients.isEmpty && isLoading == false
                    ? EmptyForNothing(
                        text: 'No Appointments Today',
                        height: 0.25,
                      )
                    : Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: ListView.separated(
                            itemCount: patients.length,
                            itemBuilder: (context, index) {
                              return PatientCardsForLab(
                                patientCards: patients[index],
                                onDelete: () {
                                  setState(() {
                                    patients.removeAt(index);
                                  });
                                },
                              );
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
