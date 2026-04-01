import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:dio/dio.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:heart_disease_prediction/Services/AppoitnmentService.dart';
import 'package:heart_disease_prediction/models/doctor_profile_model.dart';
import 'package:heart_disease_prediction/screens/all_profiles.dart';
import 'package:heart_disease_prediction/screens/appoitnment_confirmation.dart';
import 'package:intl/intl.dart';
import 'package:simple_toast_message/simple_toast.dart';

class DoctorsProfile extends StatefulWidget {
  DoctorsProfile({required this.docProfile, required this.id});

  DoctorProfileModel docProfile;
  int id;

  @override
  State<DoctorsProfile> createState() => _DoctorsProfileState();
}

class _DoctorsProfileState extends State<DoctorsProfile> {
  DateTime _focusedDay = DateTime.now();

  DateTime _selectedDay = DateTime.now();

  List<String> timeSlots = [
    '08:00 PM To 08:30 PM',
    '08:30 PM To 09:00 PM',
    '09:00 PM To 09:30 PM',
    '09:30 PM To 10:00 PM',
    '10:00 PM To 10:30 PM',
    '10:30 PM To 11:00 PM',
  ];

  String? _selectedTimeSlot;

  String? userSelectedDate;
  String? userSelectedTime;
  DateTime selectedDateTime = DateTime.now();
  String? dateToString;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 90,
              height: 90,
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
                        image: NetworkImage(widget.docProfile.profilePicture),
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.fill),
                  )),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          'Dr. ${widget.docProfile.name.split(" ").map((str) => str[0].toUpperCase() + str.substring(1)).join(" ")}',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          'Cardiologist',
          style: TextStyle(fontSize: 20, color: Colors.grey),
        ),
        SizedBox(height: 10),
        Container(
            height: 657.4,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Color(0xffD7E8F0),
                // color: Colors.black,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: 23,
                          height: 23,
                          child: Image.asset(
                              'assets/images/stethoscope-medical-tool.png')),
                      SizedBox(width: 7),
                      Text(
                        'Specialist',
                        style: TextStyle(fontSize: 15),
                      ),
                      Spacer(flex: 1),
                      SizedBox(
                          width: 23,
                          height: 23,
                          child: Image.asset('assets/images/pin.png')),
                      SizedBox(width: 7),
                      Text(
                        widget.docProfile.zone,
                        style: TextStyle(fontSize: 15),
                      ),
                      Spacer(flex: 1),
                      SizedBox(
                          width: 23,
                          height: 23,
                          child:
                              Image.asset('assets/images/payment-method.png')),
                      SizedBox(width: 7),
                      Text(
                        '${widget.docProfile.price} EGP',
                        style: TextStyle(fontSize: 15),
                      ),
                      Spacer(flex: 1),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  // height: 450,
                  height: 599,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'About',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 20),
                          ),
                          SizedBox(height: 5),
                          // Text(
                          //   style: TextStyle(color: Colors.grey.shade700),
                          //   'Dr. ${widget.docProfile.name} is a highly respected physician with over 20 years of experience in the field of internal medicine. He earned his medical degree from the prestigious XYZ University.',
                          // ),
                          ExpandableText(
                            '${widget.docProfile.about}',
                            expandText: 'see more',
                            collapseText: 'see less',
                            maxLines: 3,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Location',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 20),
                          ),
                          SizedBox(height: 5),
                          // Text(
                          //   style: TextStyle(color: Colors.grey.shade700),
                          //   'Dr. ${widget.docProfile.name} is a highly respected physician with over 20 years of experience in the field of internal medicine. He earned his medical degree from the prestigious XYZ University.',
                          // ),
                          ExpandableText(
                            '${widget.docProfile.location}',
                            expandText: 'see more',
                            collapseText: 'see less',
                            maxLines: 5,
                          ),
                          SizedBox(height: 10),
                          // Text(
                          //   'Available',
                          //   style: TextStyle(
                          //       fontWeight: FontWeight.w500, fontSize: 20),
                          // ),
                          // SizedBox(height: 10),
                          // Text(
                          //   'Mon - Tue',
                          // ),
                          // Text('7:00 PM - 10:00 PM'),
                          // SizedBox(height: 20),
                          Text(
                            'Select Date',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 20),
                          ),
                          SizedBox(height: 10),
                          EasyDateTimeLine(
                            initialDate: DateTime.now(),
                            onDateChange: (selectedDate) {
                              setState(() {
                                // convert date from 2024-3-5 into special format ex: tuesday 29 march
                                userSelectedDate =
                                    '${DateFormat('EEEE').format(selectedDate)} ${DateFormat('d').format(selectedDate)} ${DateFormat('MMMM').format(selectedDate)}';
                                dateToString = DateFormat('yyyy-MM-dd')
                                    .format(selectedDate);
                                // print(userSelectedDate);
                                print(dateToString);
                              });
                            },
                            activeColor: const Color(0xffD7E8F0),
                            headerProps: const EasyHeaderProps(
                              showHeader: false,
                              dateFormatter: DateFormatter.monthOnly(),
                            ),
                            dayProps: const EasyDayProps(
                              height: 100.0,
                              width: 56.0,
                              dayStructure: DayStructure.dayNumDayStr,
                              inactiveDayStyle: DayStyle(
                                dayNumStyle: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              activeDayStyle: DayStyle(
                                dayNumStyle: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Select Time Slot',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 20),
                          ),
                          SizedBox(height: 10),
                          Wrap(
                            direction: Axis.horizontal,
                            spacing: 10,
                            runSpacing: 4,
                            children: timeSlots.map((e) {
                              return Container(
                                height: 50,
                                width: 180,
                                child: ChoiceChip(
                                  showCheckmark: false,
                                  label: SizedBox(
                                    width: 150,
                                    height: 20,
                                    child: Text(
                                      e,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                  selected: _selectedTimeSlot == e,
                                  onSelected: (bool selected) {
                                    setState(() {
                                      _selectedTimeSlot = selected ? e : null;
                                      userSelectedTime = _selectedTimeSlot;
                                      print(userSelectedTime);
                                    });
                                  },
                                  selectedColor: Color(0xffD7E8F0),
                                  disabledColor: Colors.grey,
                                ),
                              );
                            }).toList(), // Convert Iterable to List
                          ),
                          // Spacer(flex: 1),
                          SizedBox(height: 10),
                          SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.88,
                            child: ElevatedButton(
                                onPressed: () {
                                  if (userSelectedDate == null ||
                                      userSelectedTime == null) {
                                    setState(() {
                                      CherryToast.error(
                                              toastPosition: Position.top,
                                              title: Text(
                                                  "Missing date or time",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              description: Text(
                                                  "Please select date and time",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15)),
                                              animationType:
                                                  AnimationType.fromRight,
                                              animationDuration:
                                                  Duration(milliseconds: 1000),
                                              autoDismiss: true)
                                          .show(context);
                                    });
                                  } else {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return AppoitnmentConfimrationPage(
                                        doctorProfile: widget.docProfile,
                                        SelectedDate: userSelectedDate!,
                                        SelectedTime: userSelectedTime!,
                                        id: widget.id,
                                        dateToString: dateToString!,
                                      );
                                    }));
                                  }
                                },
                                child: Text(
                                  'Book an appointment',
                                  style: TextStyle(
                                      color: Color(0xff00466B), fontSize: 18),
                                ),
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(7)),
                                    backgroundColor: Color(0xffD7E8F0),
                                    side: BorderSide())),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ))
      ],
    );
  }
}

class DoctorProfileById extends StatefulWidget {
  DoctorProfileById({required this.id});

  int id;

  @override
  State<DoctorProfileById> createState() => _DoctorProfileByIdState();
}

class _DoctorProfileByIdState extends State<DoctorProfileById> {
  DoctorProfileModel? doctorProfile;
  final AppoitnmentsService service = AppoitnmentsService(Dio());

  @override
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

  Future<DoctorProfileModel> fetchDoctorProfile() async {
    return await service.getDoctorsProfiles(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF0F4F7),
      appBar: AppBar(
        backgroundColor: Color(0xffD7E8F0),
        title: Text(
          'Doctor Profile',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: FutureBuilder<DoctorProfileModel>(
        future: fetchDoctorProfile(),
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
            return DoctorsProfile(
              docProfile: snapshot.data!,
              id: widget.id,
            ); // Data state
          }
        },
      ),
    );
  }
}

class TimeSlots extends StatefulWidget {
  TimeSlots({required this.time});

  String time;

  @override
  State<TimeSlots> createState() => _TimeSlotsState();
}

class _TimeSlotsState extends State<TimeSlots> {
  bool isSelected = false;
  bool isNotSelected = true;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          setState(() {
            isSelected = true;
            print('${widget.time}');
          });
        },
        style: ElevatedButton.styleFrom(
          side: isSelected == false ? BorderSide(color: Colors.grey) : null,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
          backgroundColor:
              isSelected == true ? Color(0xffD7E8F0) : Colors.white,
          fixedSize: Size(110, 20),
        ),
        child: Text(
          '${widget.time}',
          style: TextStyle(
              color: isSelected == true ? Colors.black : Colors.black54,
              fontWeight: isSelected == true ? FontWeight.bold : null),
        ));
  }
}
