import 'dart:ffi';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:heart_disease_prediction/Components/empty_pages.dart';
import 'package:heart_disease_prediction/Components/find_doctor_filters.dart';
import 'package:heart_disease_prediction/Services/AppoitnmentService.dart';
import 'package:heart_disease_prediction/models/my_appointments_model.dart';
import 'package:heart_disease_prediction/screens/doctors_profile.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

List<MyUpcomingAppointmentsModel> myAppointmets = [];
List<MyCompletedAppointmentsModel> myCompletedAppointmets = [];
List<MyCanceledAppointmentsModel> myCanceledAppointmets = [];

class ViewAppoitments extends StatefulWidget {
  const ViewAppoitments({super.key});

  @override
  State<ViewAppoitments> createState() => _ViewAppoitmentsState();
}

class _ViewAppoitmentsState extends State<ViewAppoitments> {
  int upcoming = 1;
  int compeleted = 0;
  int cancelled = 0;

  bool isPage2Visible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffD7E8F0),
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'My Appointments',
                  style: TextStyle(fontFamily: 'Myriad', fontSize: 20),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                FindDoctorsFilters(
                  text: 'Upcoming',
                  onTap: () {
                    setState(() {
                      upcoming = 1;
                      compeleted = 0;
                      cancelled = 0;
                    });
                  },
                  textColor: upcoming == 1 ? Colors.white : Colors.black,
                  backgroundColor: upcoming == 1
                      ? const Color(0xff00466D)
                      : const Color(0xffD7E8F0),
                ),
                FindDoctorsFilters(
                  text: 'Completed',
                  onTap: () {
                    setState(() {
                      compeleted = 1;
                      upcoming = 0;
                      cancelled = 0;
                    });
                  },
                  textColor: compeleted == 1 ? Colors.white : Colors.black,
                  backgroundColor: compeleted == 1
                      ? const Color(0xff00466D)
                      : const Color(0xffD7E8F0),
                ),
                FindDoctorsFilters(
                  text: 'Cancelled',
                  onTap: () {
                    setState(() {
                      cancelled = 1;
                      upcoming = 0;
                      compeleted = 0;
                    });
                  },
                  textColor: cancelled == 1 ? Colors.white : Colors.black,
                  backgroundColor: cancelled == 1
                      ? const Color(0xff00466D)
                      : const Color(0xffD7E8F0),
                ),
              ],
            )
          ],
        ),
      ),
      backgroundColor: const Color(0xffF0F4F7),
      body: Column(
        children: [
          SizedBox(height: 10),
          //sol 1

          // upcoming == 1
          //     ? ifUpcomingClicked()
          //     : compeleted == 1
          //         ? ifCompletedClicked()
          //         : cancelled == 1
          //             ? ifCanceledClicked()
          //             : SizedBox(),

          // sol 2

          // if (upcoming == 1 && myAppointmets.isEmpty) Spacer(flex: 1),
          // if (compeleted == 1 && myCompletedAppointmets.isEmpty)
          //   Spacer(flex: 1),
          // if (cancelled == 1 && myCanceledAppointmets.isEmpty) Spacer(flex: 1),
          // if (upcoming == 1) ifUpcomingClicked(),
          // if (compeleted == 1) ifCompletedClicked(),
          // if (cancelled == 1) ifCanceledClicked(),
          // if (upcoming == 1 && myAppointmets.isEmpty) Spacer(flex: 1),
          // if (compeleted == 1 && myCompletedAppointmets.isEmpty)
          //   Spacer(flex: 1),
          // if (cancelled == 1 && myCanceledAppointmets.isEmpty) Spacer(flex: 1),

          //sol 3

          // if (upcoming == 1 && myAppointmets.isEmpty) Spacer(flex: 1),
          // if (upcoming == 1) ifUpcomingClicked(),
          // if (upcoming == 1 && myAppointmets.isEmpty) Spacer(flex: 1),

          // if (compeleted == 1 && myCompletedAppointmets.isEmpty)
          //   Spacer(flex: 1),
          // if (compeleted == 1) ifCompletedClicked(),
          // if (compeleted == 1 && myCompletedAppointmets.isEmpty)
          //   Spacer(flex: 1),

          // if (cancelled == 1 && myCanceledAppointmets.isEmpty) Spacer(flex: 1),
          // if (cancelled == 1) ifCanceledClicked(),
          // if (cancelled == 1 && myCanceledAppointmets.isEmpty) Spacer(flex: 1),

          if (upcoming == 1) const ifUpcomingClicked(),
          if (compeleted == 1) const ifCompletedClicked(),
          if (cancelled == 1) const ifCanceledClicked()
        ],
      ),
    );
  }
}

class ifUpcoming extends StatelessWidget {
  ifUpcoming(
      {required this.myAppointments,
      required this.reschedule,
      required this.remove});

  MyUpcomingAppointmentsModel myAppointments;
  VoidCallback reschedule;
  VoidCallback remove;

// post
  AppoitnmentsService service = AppoitnmentsService(Dio());

  void CancelAppointment() async {
    await service.CancelAppointment(myAppointments.id);
  }
  /////////////

  @override
  Widget build(BuildContext context) {
    String input = myAppointments.date;
    String datePart = input.split("T")[0];

    DateTime tempDate = DateFormat("yyyy-MM-dd").parse(datePart);
    String formattedDate = DateFormat("dd MMMM yyyy").format(tempDate);

    return Container(
      width: 370,
      height: 190,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3), // More transparent shadow
          spreadRadius: 1, // Reduced spread radius
          blurRadius: 2, // Reduced blur radius
          offset: const Offset(0, 2), // changes position of shadow
        ),
      ], color: Colors.white, borderRadius: BorderRadius.circular(7)),
      child: Column(
        children: [
          Container(
            height: 40,
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Color(0xff00466D),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(7), topRight: Radius.circular(7))),
            child: Row(
              children: [
                const SizedBox(width: 10),
                const Text(
                  'Visit Date',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(width: 10),
                Text(
                  // variable text (from database)
                  '$formattedDate ${myAppointments.time}',
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        width: 1,
                        color: Color(0xffC1D0D8),
                      )),
                  child: Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        image: DecorationImage(
                            image: NetworkImage(myAppointments.profileImg),
                            filterQuality: FilterQuality.high,
                            fit: BoxFit.fill)),
                  ),
                ),
                const SizedBox(width: 15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Dr. ',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          //variable from database
                          '${myAppointments.docName.split(" ").map((str) => str[0].toUpperCase() + str.substring(1)).join(" ")}',
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      //variable from database
                      'Cardiologist',
                      style:
                          TextStyle(fontSize: 15, color: Colors.grey.shade600),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      //variable from database
                      '${myAppointments.docLocation}',
                      style:
                          TextStyle(fontSize: 15, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,
                width: 190, //95
                child: ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                        isDismissible: false,
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
                                            Navigator.of(context).pop();
                                          },
                                          child: Icon(
                                            Icons.close,
                                            size: 25,
                                          ),
                                        ),
                                        Spacer(flex: 7),
                                        Text(
                                          'Edit',
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
                                ListTile(
                                  leading: Icon(Icons.loop),
                                  title: Text(
                                    'Reschedule Appointment',
                                    style: TextStyle(fontFamily: 'Myriad'),
                                  ),
                                  onTap: () {
                                    reschedule();
                                  },
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.close,
                                    color: Colors.red.shade700,
                                  ),
                                  title: Text(
                                    'Cancel Appointment',
                                    style: TextStyle(
                                        color: Colors.red.shade700,
                                        fontFamily: 'Myriad'),
                                  ),
                                  onTap: () {
                                    DialougBuilder(
                                        context, remove, CancelAppointment);
                                  },
                                ),
                              ],
                            ),
                          );
                        });
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.edit,
                        color: Color(0xFF00466B),
                        size: 20,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Edit',
                        style:
                            TextStyle(color: Color(0xff00466B), fontSize: 15),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7)),
                    backgroundColor: const Color(0xffD7E8F0),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                height: 40,
                width: 190, //130
                child: ElevatedButton(
                  onPressed: () async {
                    final Uri url = Uri(
                      scheme: 'tel',
                      path: "${myAppointments.phone}",
                    );
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      print('Cannot Lanch This URL');
                    }
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.call,
                        color: Color(0xff00466B),
                        size: 20, //18
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Call Clinic',
                        style: TextStyle(
                            color: Color(0xff00466B), fontSize: 15), //13
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7)),
                    backgroundColor: const Color(0xffD7E8F0),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ifUpcomingClicked extends StatefulWidget {
  const ifUpcomingClicked({super.key});

  @override
  State<ifUpcomingClicked> createState() => _ifUpcomingClickedState();
}

class _ifUpcomingClickedState extends State<ifUpcomingClicked> {
  bool isLoading = true;

  List<int> docId = [];
  List<DateTime> dateTime = [];

  final AppoitnmentsService service = AppoitnmentsService(Dio());

  void initState() {
    super.initState();
    fetchMyAppointments();
  }

  void fetchMyAppointments() async {
    final fetchedMyAppointments = await service.getMyAppointments();
    isLoading = false;
    setState(() {
      myAppointmets = fetchedMyAppointments;
      DateTime now = DateTime.now();
      myAppointmets = myAppointmets
          .where((appointment) => DateTime.parse(appointment.date).isAfter(now))
          .toList();
      myAppointmets.sort(
          (a, b) => DateTime.parse(a.date).compareTo(DateTime.parse(b.date)));
      docId = myAppointmets.map((doctor) => doctor.docId).toList();
      // dateTime = dates.map((dateString) => DateTime.parse(dateString)).toList();
      // for (int x = 0; x < dateTime.length; x++) {
      //   print(dateTime[x]);
      // }
      // for (int x = 0; x < docId.length; x++) {
      //   print(docId[x]);
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                width: MediaQuery.of(context).size.width * 1,
              ),
              const CircularProgressIndicator(
                color: Color(0xff00466B),
              ),
            ],
          )
        : myAppointmets.isNotEmpty
            ? Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: ListView.separated(
                    itemCount: myAppointmets.length,
                    itemBuilder: (context, index) {
                      return ifUpcoming(
                        myAppointments: myAppointmets[index],
                        reschedule: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return DoctorProfileById(id: docId[index]);
                          }));
                        },
                        remove: () {
                          setState(() {
                            myAppointmets.removeAt(index);
                          });
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 15);
                    },
                  ),
                ),
              )
            : Empty(text: 'appointments');
  }
}

class ifCompeleted extends StatelessWidget {
  ifCompeleted(
      {required this.completedAppointment, required this.reReservation});

  VoidCallback reReservation;

  MyCompletedAppointmentsModel completedAppointment;
  @override
  Widget build(BuildContext context) {
    String input = completedAppointment.date;
    String datePart = input.split("T")[0];

    DateTime tempDate = DateFormat("yyyy-MM-dd").parse(datePart);
    String formattedDate = DateFormat("dd MMMM yyyy").format(tempDate);
    return Container(
      width: 370,
      height: 185,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3), // More transparent shadow
          spreadRadius: 1, // Reduced spread radius
          blurRadius: 2, // Reduced blur radius
          offset: const Offset(0, 2), // changes position of shadow
        ),
      ], color: Colors.white, borderRadius: BorderRadius.circular(7)),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 10),
              Text(
                'Completed',
                style: TextStyle(color: Colors.green.shade700),
              ),
              const SizedBox(width: 10),
              const Text(
                'Visit Date',
                style: TextStyle(color: Colors.black),
              ),
              const SizedBox(width: 5),
              Text(
                // variable text (from database)
                '$formattedDate ${completedAppointment.time}',
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const Divider(
            indent: 7,
            endIndent: 7,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        width: 1,
                        color: Color(0xffC1D0D8),
                      )),
                  child: Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        image: DecorationImage(
                            image:
                                NetworkImage(completedAppointment.profileImg),
                            filterQuality: FilterQuality.high,
                            fit: BoxFit.fill)),
                  ),
                ),
                const SizedBox(width: 15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dr.',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          //variable from database
                          '${completedAppointment.docName.split(" ").map((str) => str[0].toUpperCase() + str.substring(1)).join(" ")}',
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      //variable from database
                      'Cardiologist',
                      style:
                          TextStyle(fontSize: 15, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width * 0.45,
                child: ElevatedButton(
                  onPressed: () {
                    reReservation();
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.replay,
                        color: Color(0xFF00466B),
                        size: 18,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Book Again',
                        style:
                            TextStyle(color: Color(0xff00466B), fontSize: 13),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7)),
                    backgroundColor: const Color(0xffD7E8F0),
                  ),
                ),
              ),
              const SizedBox(width: 5),
              SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width * 0.45,
                child: ElevatedButton(
                  onPressed: () async {
                    final Uri url = Uri(
                      scheme: 'tel',
                      path: "${completedAppointment.phone}",
                    );
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      print('Cannot Lanch This URL');
                    }
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.call,
                        color: Color(0xff00466B),
                        size: 18,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Call Clinic',
                        style:
                            TextStyle(color: Color(0xff00466B), fontSize: 13),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7)),
                    backgroundColor: const Color(0xffD7E8F0),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ifCompletedClicked extends StatefulWidget {
  const ifCompletedClicked({super.key});

  @override
  State<ifCompletedClicked> createState() => _ifCompletedClickedState();
}

class _ifCompletedClickedState extends State<ifCompletedClicked> {
  @override
  DateTime now = DateTime.now();

  bool isLoading = false;

  List<int> docId = [];
  List<DateTime> dates = [];

  final AppoitnmentsService service = AppoitnmentsService(Dio());

  void initState() {
    super.initState();
    fetchMyAppointments();
  }

  void fetchMyAppointments() async {
    final fetchedMyCompletedAppointments =
        await service.getMyCompletedAppointments();
    isLoading = false;
    if (mounted) {
      setState(() {
        myCompletedAppointmets = fetchedMyCompletedAppointments;
        DateTime now = DateTime.now();
        myCompletedAppointmets = myCompletedAppointmets
            .where(
                (appointment) => DateTime.parse(appointment.date).isBefore(now))
            .toList();
        myCompletedAppointmets.sort(
            (a, b) => DateTime.parse(a.date).compareTo(DateTime.parse(b.date)));

        docId = myCompletedAppointmets.map((doctor) => doctor.docId).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                width: MediaQuery.of(context).size.width * 1,
              ),
              const CircularProgressIndicator(
                color: Color(0xff00466B),
              ),
            ],
          )
        : myCompletedAppointmets.isNotEmpty
            ? Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: ListView.separated(
                    itemCount: myCompletedAppointmets.length,
                    itemBuilder: (context, index) {
                      return ifCompeleted(
                        completedAppointment: myCompletedAppointmets[index],
                        reReservation: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return DoctorProfileById(id: docId[index]);
                          }));
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 10);
                    },
                  ),
                ),
              )
            : Empty(text: 'appointments');
  }
}

class ifCancelled extends StatelessWidget {
  ifCancelled(
      {required this.myCanceledAppointment, required this.reReservation});

  VoidCallback reReservation;

  MyCanceledAppointmentsModel myCanceledAppointment;
  @override
  Widget build(BuildContext context) {
    String input = myCanceledAppointment.date;
    String datePart = input.split("T")[0];

    DateTime tempDate = DateFormat("yyyy-MM-dd").parse(datePart);
    String formattedDate = DateFormat("dd MMMM yyyy").format(tempDate);
    return Container(
      width: 370,
      height: 185,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3), // More transparent shadow
          spreadRadius: 1, // Reduced spread radius
          blurRadius: 2, // Reduced blur radius
          offset: const Offset(0, 2), // changes position of shadow
        ),
      ], color: Colors.white, borderRadius: BorderRadius.circular(7)),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 10),
              Text(
                'Cancelled',
                style: TextStyle(color: Colors.red.shade700),
              ),
              const SizedBox(width: 10),
              const Text(
                'Visit Date',
                style: TextStyle(color: Colors.black),
              ),
              const SizedBox(width: 5),
              Text(
                // variable text (from database)
                '$formattedDate ${myCanceledAppointment.time}',
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const Divider(
            indent: 7,
            endIndent: 7,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        width: 1,
                        color: Color(0xffC1D0D8),
                      )),
                  child: Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        image: DecorationImage(
                            image:
                                NetworkImage(myCanceledAppointment.profileImg),
                            filterQuality: FilterQuality.high,
                            fit: BoxFit.fill)),
                  ),
                ),
                const SizedBox(width: 15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Dr.',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          //variable from database
                          '${myCanceledAppointment.docName.split(" ").map((str) => str[0].toUpperCase() + str.substring(1)).join(" ")}',
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      //variable from database
                      'Cardiologist',
                      style:
                          TextStyle(fontSize: 15, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width * 0.45,
                child: ElevatedButton(
                  onPressed: () {
                    reReservation();
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.replay,
                        color: Color(0xFF00466B),
                        size: 18,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Book Again',
                        style:
                            TextStyle(color: Color(0xff00466B), fontSize: 13),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7)),
                    backgroundColor: const Color(0xffD7E8F0),
                  ),
                ),
              ),
              const SizedBox(width: 5),
              SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width * 0.45,
                child: ElevatedButton(
                  onPressed: () async {
                    final Uri url = Uri(
                      scheme: 'tel',
                      path: "${myCanceledAppointment.phone}",
                    );
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      print('Cannot Lanch This URL');
                    }
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.call,
                        color: Color(0xff00466B),
                        size: 18,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Call Clinic',
                        style:
                            TextStyle(color: Color(0xff00466B), fontSize: 13),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7)),
                    backgroundColor: const Color(0xffD7E8F0),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ifCanceledClicked extends StatefulWidget {
  const ifCanceledClicked({super.key});

  @override
  State<ifCanceledClicked> createState() => _ifCanceledClickedState();
}

class _ifCanceledClickedState extends State<ifCanceledClicked> {
  @override
  bool isLoading = true;

  List<int> docId = [];
  List<String> dates = [];

  final AppoitnmentsService service = AppoitnmentsService(Dio());

  void initState() {
    super.initState();

    fetchMyAppointments();
  }

  void fetchMyAppointments() async {
    final fetchedMyCanceledAppointments =
        await service.getMyCanceledAppointments();
    isLoading = false;
    setState(() {
      myCanceledAppointmets = fetchedMyCanceledAppointments;
      dates = myCanceledAppointmets.map((date) => date.date).toList();
      myCanceledAppointmets.sort(
          (a, b) => DateTime.parse(a.date).compareTo(DateTime.parse(b.date)));

      docId = myCanceledAppointmets.map((doctor) => doctor.docId).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                width: MediaQuery.of(context).size.width * 1,
              ),
              const CircularProgressIndicator(
                color: Color(0xff00466B),
              ),
            ],
          )
        : myCanceledAppointmets.isNotEmpty
            ? Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: ListView.separated(
                    itemCount: myCanceledAppointmets.length,
                    itemBuilder: (context, index) {
                      return ifCancelled(
                        myCanceledAppointment: myCanceledAppointmets[index],
                        reReservation: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return DoctorProfileById(id: docId[index]);
                          }));
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 15);
                    },
                  ),
                ),
              )
            : Empty(text: 'appointments');
  }
}

// warning shows at cancel appointment
Future<void> DialougBuilder(BuildContext context, VoidCallback removeFunction,
    VoidCallback cancelFunction) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
            title: Text(
              'Are you sure you want to cancel this reservation ?',
              style: TextStyle(fontSize: 17),
            ),
            titlePadding: EdgeInsets.all(20),
            insetPadding: EdgeInsets.all(30),
            actionsPadding: EdgeInsets.only(bottom: 10, right: 10),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(flex: 1),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: Text('No',
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.grey.shade800,
                          ))),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        removeFunction();
                        cancelFunction();
                      },
                      child: Text(
                        'Yes',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.grey.shade800,
                        ),
                      )),
                ],
              ),
            ],
            shape:
                BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)));
      });
}
