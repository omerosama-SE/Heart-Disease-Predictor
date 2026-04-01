import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:dio/dio.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:heart_disease_prediction/Services/AppoitnmentService.dart';
import 'package:heart_disease_prediction/main.dart';
import 'package:heart_disease_prediction/models/lab_profile_model.dart';
import 'package:heart_disease_prediction/screens/appoitnment_confirmation.dart';
import 'package:intl/intl.dart';
import 'package:simple_toast_message/simple_toast.dart';

class LabProfile extends StatefulWidget {
  LabProfile({required this.labProfile, required this.id});

  LabProfileModel labProfile;
  int id;

  @override
  State<LabProfile> createState() => _LabProfileState();
}

class _LabProfileState extends State<LabProfile> {
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
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    width: 1,
                    color: Color(0xffC1D0D8),
                  )),
              child: Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: NetworkImage(widget.labProfile.logo),
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.fill)),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          '${widget.labProfile.name}',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
            height: 683,
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
                        'Laboratory',
                        style: TextStyle(fontSize: 15),
                      ),
                      Spacer(flex: 1),
                      SizedBox(
                          width: 23,
                          height: 23,
                          child: Image.asset('assets/images/pin.png')),
                      SizedBox(width: 7),
                      Text(
                        widget.labProfile.zone,
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
                        '${widget.labProfile.price} EGP',
                        style: TextStyle(fontSize: 15),
                      ),
                      Spacer(flex: 1),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  // height: 450,
                  height: 625,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
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
                          '${widget.labProfile.name} is the largest private medical laboratory testing company in the Middle East, providing diagnostic laboratory services, pathological and clinical tests for medical communities in Egypt.',
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
                        SizedBox(height: 20),
                        EasyInfiniteDateTimeLine(
                          dayProps: const EasyDayProps(
                              height: 100.0,
                              width: 56.0,
                              dayStructure: DayStructure.dayStrDayNumMonth,
                              inactiveDayStyle: DayStyle(
                                dayNumStyle: TextStyle(
                                  fontSize: 20,
                                ),
                              )),
                          showTimelineHeader: false,
                          activeColor: Color(0xffD7E8F0),
                          focusDate: _focusedDay,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(Duration(days: 15)),
                          onDateChange: (selectedDate) {
                            setState(() {
                              _focusedDay = selectedDate;
                              // convert date from 2024-3-5 into special format ex: tuesday 29 march
                              userSelectedDate =
                                  '${DateFormat('EEEE').format(selectedDate)} ${DateFormat('d').format(selectedDate)} ${DateFormat('MMMM').format(selectedDate)}';
                              dateToString =
                                  DateFormat('yyyy-MM-dd').format(selectedDate);
                              // print(userSelectedDate);
                              print(dateToString);
                            });
                          },
                        ),
                        SizedBox(height: 20),
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
                        Spacer(flex: 1),
                        SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: ElevatedButton(
                              onPressed: () {
                                if (userSelectedDate == null ||
                                    userSelectedTime == null) {
                                  setState(() {
                                    CherryToast.error(
                                            toastPosition: Position.top,
                                            title: Text("Missing Date or Time",
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
                                      labProfile: widget.labProfile,
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
                                  fixedSize: Size(130, 50),
                                  side: BorderSide(color: Color(0xff00466B)))),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ))
      ],
    );
  }
}

class GetLabProfileById extends StatefulWidget {
  GetLabProfileById({required this.id});

  int id;

  @override
  State<GetLabProfileById> createState() => _GetLabProfileByIdState();
}

class _GetLabProfileByIdState extends State<GetLabProfileById> {
  LabProfileModel? labProfileModel;
  final AppoitnmentsService service = AppoitnmentsService(Dio());

  Future<LabProfileModel> fetchLabProfile() async {
    return await service.getLabProfile(widget.id);
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
          backgroundColor: Color(0xffD7E8F0),
          title: Text(
            'Lab Profile',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: FutureBuilder<LabProfileModel>(
            future: fetchLabProfile(),
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
                return LabProfile(
                  labProfile: snapshot.data!,
                  id: widget.id,
                );
              }
            }));
  }
}

//another way

class GetLabProfileByIdV2 extends StatefulWidget {
  GetLabProfileByIdV2({required this.id});

  int id;

  @override
  State<GetLabProfileByIdV2> createState() => _GetLabProfileByIdV2State();
}

class _GetLabProfileByIdV2State extends State<GetLabProfileByIdV2> {
  LabProfileModel? profile;
  bool isLoading = true;

  List<int> doctorIds = [];
  final AppoitnmentsService service = AppoitnmentsService(Dio());

  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      //this to ensure that the build phase that dart going into to build the ui is done and after that call back the methods i need
      //build phase this is the inital phase that app goes through to build the ui
      //and i was trying a solution that change the build phase which is not allowed
      //so this method checks if the build phase is done and then call back the required method
      _showLoadingIndicator();
      fetchLabProfile();
    });
  }

  void fetchLabProfile() async {
    final fetchedProfile = await service.getLabProfile(widget.id);
    if (_overlayEntry != null) {
      //here in previous solution i was trying to remove the loading indicator before it was added
      //and this caused an error so this is check if the loading indicator is already exists before removing it.
      _hideLoadingIndicator();
    }
    setState(() {
      profile = fetchedProfile;
      isLoading = false;
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

  @override
  Widget build(BuildContext context) {
    return isLoading == false
        ? LabProfile(labProfile: profile!, id: widget.id)
        : SizedBox.shrink();
  }
}
