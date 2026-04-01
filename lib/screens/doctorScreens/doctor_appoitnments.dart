import 'package:dio/dio.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:heart_disease_prediction/Components/patients_cards.dart';
import 'package:heart_disease_prediction/Services/AppoitnmentService.dart';
import 'package:heart_disease_prediction/models/patients_list_model.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class DoctorAppoitnments extends StatefulWidget {
  const DoctorAppoitnments({super.key});

  @override
  State<DoctorAppoitnments> createState() => _DoctorAppoitnmentsState();
}

class _DoctorAppoitnmentsState extends State<DoctorAppoitnments> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  bool isAccept = false;
  void acceptAppointment() {
    setState(() {
      isAccept = true;
    });
  }

// String? date;
  bool isLoading = true;
  DateTime now = DateTime.now();

  //Handle Get Request

  void initState() {
    // DateTime now = DateTime.now();
    // String date = DateFormat('yyyy-MM-dd').format(now);
    super.initState();
    fetchPatients();
  }

  var patientId;
  List<String> appointmentDate = [];
  List<int> patientsSSN = [];
  List<int> patientsIds = [];

  //all reserved patients in all days
  List<PatientsListForDoctorModel> patients = [];

  //all reserved patients in specific day
  List<PatientsListForDoctorModel> reserevdPatientsByDay = [];

  List<PatientsListForDoctorModel> filterdAppointmentByDay = [];

  final AppoitnmentsService service = AppoitnmentsService(Dio());

  void fetchPatients() async {
    final fetchedPatients = await service.getReservedPatientsForDoctor();
    isLoading = false;
    setState(() {
      //compare here
      // try {
      //   reserevdPatients = fetchedPatients;

      //   for (int x = 0; x < reserevdPatients.length; x++) {
      //     var patient = reserevdPatients[x];
      //     String datePart = patient.date.split('T')[0];
      //     if (datePart == selectedDay) {
      //       reserevdPatientsByDay.add(reserevdPatients[x]);
      //     } else {}
      //   }
      // } catch (e) {
      //   print(e);
      // }
      // patients = fetchedPatients;
      for (int x = 0; x < fetchedPatients.length; x++) {
        //this solution works
        var todayPatient = fetchedPatients[x];
        DateTime now = DateTime.now();
        DateTime date = DateTime.parse(todayPatient.date);
        if (date.day == now.day &&
            date.month == now.month &&
            date.year == now.year) {
          setState(() {
            patients.add(todayPatient);
          });
        }
      }

      // patientsSSN = patients.map((patient) => patient.ssn).toList();
      // patientsIds = patients.map((patient) => patient.id).toList();
      // appointmentDate = patients.map((patient) => patient.date).toList();
      // for (int x = 0; x < appointmentDate.length; x++) {
      //   // print(patientsIds[x]);
      //   print(appointmentDate[x]);
      //   // patientId = patientId[x];
      //   // print(patientId);
      // }
    });
  }

  void fetchPatientsForDay(DateTime selectedDay) async {
    //this solution works
    final fetchedPatients = await service.getReservedPatientsForDoctor();
    isLoading = false;
    patients.clear();
    setState(() {
      for (int x = 0; x < fetchedPatients.length; x++) {
        var patientsByDaySelected = fetchedPatients[x];
        DateTime date = DateTime.parse(patientsByDaySelected.date);
        if (date.day == selectedDay.day &&
            date.month == selectedDay.month &&
            date.year == selectedDay.year) {
          patients.add(patientsByDaySelected);
        }
      }
      // patients = fetchedPatients;
    });
  }

  // handle AcceptAppointment

  @override
  Widget build(BuildContext context) {
//formatted date

//

    return Scaffold(
      backgroundColor: Color(0xffF0F4F7),
      appBar: AppBar(
        backgroundColor: Color(0xffD7E8F0),
        title: Text(
          'My Appointments',
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
                // setState(() {
                //   String formattedDate =
                //       DateFormat('yyyy-MM-dd').format(selectedDate);
                //   // fetchPatients(formattedDate);
                //   reserevdPatientsByDay.clear();
                //   for (int x = 0; x < reserevdPatients.length; x++) {
                //     var patient = reserevdPatients[x];
                //     String datePart = patient.date.split('T')[0];
                //     if (datePart == formattedDate) {
                //       reserevdPatientsByDay.add(reserevdPatients[x]);
                //     }
                //   }
                // });
                setState(() {
                  // reserevdPatientsByDay.clear();
                  // for (int x = 0; x < patients.length; x++) {
                  //   // print(patients[x].id);
                  //   var todayPatient = patients[x];
                  //   DateTime date = DateTime.parse(todayPatient.date);
                  //   if (date.day == selectedDate.day &&
                  //       date.month == selectedDate.month &&
                  //       date.year == selectedDate.year) {
                  //     setState(() {
                  //       // reserevdPatientsByDay.clear(); //wrong position should be above
                  //       // bool isAccepted = await loadAppoitnmentState(todayPatient.id);
                  //       print(todayPatient.id);
                  //       reserevdPatientsByDay.add(todayPatient);
                  //     });
                  //   }
                  // }
                  //this solution works
                  _focusedDay = selectedDate;
                  isLoading = true;
                  fetchPatientsForDay(selectedDate);
                });
              },
            ),
            SizedBox(height: 20),
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
                              return PatientCards(
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

class EmptyForNothing extends StatelessWidget {
  EmptyForNothing({required this.text, required this.height});

  String text;
  double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * height),
        Text(
          text,
          style: TextStyle(fontFamily: 'Myriad', fontSize: 20),
        ),
      ],
    );
  }
}
