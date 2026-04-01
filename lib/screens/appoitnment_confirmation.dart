import 'dart:developer';

import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:dio/dio.dart';
import 'package:expandable_text/text_parser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:heart_disease_prediction/Services/AppoitnmentService.dart';
import 'package:heart_disease_prediction/main.dart';
import 'package:heart_disease_prediction/models/doctor_profile_model.dart';
import 'package:heart_disease_prediction/models/lab_profile_model.dart';
import 'package:heart_disease_prediction/screens/all_profiles.dart';
import 'package:heart_disease_prediction/screens/successfull_appoitments.dart';
import 'package:simple_toast_message/simple_toast.dart';
import 'package:table_calendar/table_calendar.dart';

class AppoitnmentConfimrationPage extends StatefulWidget {
  AppoitnmentConfimrationPage(
      {this.doctorProfile,
      this.labProfile,
      required this.SelectedDate,
      required this.SelectedTime,
      required this.id,
      required this.dateToString});

  DoctorProfileModel? doctorProfile;
  LabProfileModel? labProfile;

  String SelectedDate;
  String SelectedTime;
  int id;
  String dateToString;

  @override
  State<AppoitnmentConfimrationPage> createState() =>
      _AppoitnmentConfimrationPageState();
}

class _AppoitnmentConfimrationPageState
    extends State<AppoitnmentConfimrationPage> {
  final _formKey = GlobalKey<FormState>();
  var fullNameCont = TextEditingController();
  var phoneCont = TextEditingController();
  var ssnCont = TextEditingController();

  String? Function(String?)? fullNameValidator =
      (value) => value!.isEmpty ? 'Full Name is required' : null;
  String? Function(String?)? phoneValidator =
      (value) => value!.isEmpty ? 'Phone Number is required' : null;
  String? Function(String?)? ssnValidator =
      (value) => value!.isEmpty ? 'SSN is required' : null;

  bool isNameEmpty = true;
  bool isPhoneEmpty = true;
  bool isSsnEmpty = true;

  AppoitnmentsService service = AppoitnmentsService(Dio());

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
  //Post Method

  void handlePostDoctorAppointment() async {
    try {
      Response response = await service.PostDoctorAppoitnment(
          widget.id,
          widget.dateToString,
          widget.SelectedTime,
          phoneCont.text,
          fullNameCont.text);

      if (response.statusCode == 200) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return SuccefullAppoitments(
              docProfile: widget.doctorProfile!,
              SelectedDate: widget.SelectedDate,
              SelectedTime: widget.SelectedTime);
        }));
      }
    } catch (e) {
      print(e);
    } finally {
      _hideLoadingIndicator();
    }
  }

  void handlePostLabAppointment() async {
    try {
      Response response = await service.PostLabAppoitnment(
          widget.id,
          widget.dateToString,
          widget.SelectedTime,
          phoneCont.text,
          fullNameCont.text);

      if (response.statusCode == 200) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return SuccefullAppoitments(
              labProfile: widget.labProfile,
              SelectedDate: widget.SelectedDate,
              SelectedTime: widget.SelectedTime);
        }));
      }
    } catch (e) {
      print(e);
    } finally {
      _hideLoadingIndicator();
    }
  }

  @override
  Widget build(BuildContext context) {
    String name;
    String logo;
    String location;
    String price;
    if (widget.doctorProfile != null) {
      name =
          'Dr. ${widget.doctorProfile!.name.split(" ").map((str) => str[0].toUpperCase() + str.substring(1)).join(" ")}';
      location = widget.doctorProfile!.location;
      price = widget.doctorProfile!.price;
      logo = widget.doctorProfile!.profilePicture;
    } else if (widget.labProfile != null) {
      name = '${widget.labProfile!.name}';
      location = widget.labProfile!.zone;
      price = widget.labProfile!.price;
      logo = widget.labProfile!.logo;
    } else {
      throw Exception('Both doctorProfile and labProfile cannot be null');
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xffF0F4F7),
      appBar: AppBar(
        backgroundColor: Color(0xffD7E8F0),
        title: Text(
          'Confirmation',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        widget.doctorProfile == null ? 20 : 50),
                    border: Border.all(
                      width: 1,
                      color: Color(0xffC1D0D8),
                    )),
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                          widget.doctorProfile == null ? 20 : 50),
                      image: DecorationImage(
                          image: NetworkImage(logo),
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.fill)),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            name,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Container(
            width: MediaQuery.of(context).size.width * 0.95,
            height: 390,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(7)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 20),
                    Column(
                      children: [
                        SizedBox(height: 60),
                        SizedBox(
                          height: 30,
                          width: 30,
                          child: Image.asset('assets/images/userrrr (2).png'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 140,
                      width: 30,
                      child: VerticalDivider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          ConfirmationFields(
                            name: 'Full Name',
                            controller: fullNameCont,
                            validator: fullNameValidator,
                          ),
                          SizedBox(height: 20),
                          ConfirmationFields(
                            name: 'Phone Number',
                            controller: phoneCont,
                            validator: phoneValidator,
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 20),
                    Column(
                      children: [
                        SizedBox(height: 13),
                        SizedBox(
                          height: 30,
                          width: 30,
                          child: Image.asset('assets/images/schedule (1).png'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                      width: 30,
                      child: VerticalDivider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.SelectedTime}',
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${widget.SelectedDate}',
                          style: TextStyle(fontSize: 15),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 20),
                    Column(
                      children: [
                        SizedBox(height: 10),
                        SizedBox(
                          height: 30,
                          width: 30,
                          child: Image.asset('assets/images/location.png'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                      width: 30,
                      child: VerticalDivider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                    ),
                    Column(
                      children: [
                        Column(
                          children: [
                            SizedBox(height: 15),
                            Text(
                              location,
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 20),
                    Column(
                      children: [
                        SizedBox(height: 10),
                        SizedBox(
                          height: 30,
                          width: 30,
                          child: Image.asset(
                              'assets/images/icons8-money-96(-xxhdpi).png'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                      width: 30,
                      child: VerticalDivider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                    ),
                    Column(
                      children: [
                        Column(
                          children: [
                            SizedBox(height: 15),
                            Text(
                              '$price EGP',
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          Spacer(flex: 13),
          SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.95,
            child: ElevatedButton(
                onPressed: () {
                  if (fullNameCont.text.isEmpty || phoneCont.text.isEmpty) {
                    SimpleToast.showErrorToast(
                        context, "Missing Values", "Please Fill The Fields");
                  } else {
                    if (widget.doctorProfile != null) {
                      _showLoadingIndicator();
                      handlePostDoctorAppointment();
                    } else if (widget.labProfile != null) {
                      _showLoadingIndicator();
                      handlePostLabAppointment();
                    }
                  }

                  // if (_formKey.currentState!.validate()) {}
                },
                child: Text(
                  'Confirm',
                  style: TextStyle(color: Color(0xff00466B), fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7)),
                    backgroundColor: Color(0xffD7E8F0),
                    fixedSize: Size(130, 50),
                    side: BorderSide())),
          ),
          Spacer(flex: 1),
        ],
      ),
    );
  }
}

class ConfirmationFields extends StatelessWidget {
  ConfirmationFields(
      {required this.name, required this.controller, required this.validator});

  String name;
  var controller = TextEditingController();
  String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 310,
      height: 47,
      // decoration: BoxDecoration(
      //     border: Border.all(color: Colors.grey),
      //     borderRadius: BorderRadius.circular(7)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 15),
              Text(
                name,
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
          SizedBox(height: 10),
          SizedBox(
              width: 300,
              height: 20,
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: validator,
                controller: controller,
                cursorColor: Color(0xff00466D),
                cursorHeight: 20,
                decoration: InputDecoration(),
              ))
        ],
      ),
    );
  }
}

// class SchedulingAppointments extends StatefulWidget {
//   const SchedulingAppointments({super.key});

//   @override
//   State<SchedulingAppointments> createState() => _SchedulingAppointmentsState();
// }

// class _SchedulingAppointmentsState extends State<SchedulingAppointments> {
//   CalendarFormat _calendarFormat = CalendarFormat.month;
//   DateTime _focusedDay = DateTime.now();
//   DateTime _selectedDay = DateTime.now();

//   List<String> _timeSlots = [
//     '09:00 PM',
//     '10:00 PM',
//     '11:00 PM',
//     '12:00 PM',
//     '1:00 PM',
//     '2:00 PM',
//     '3:00 PM',
//     '4:00 PM',
//     '5:00 PM',
//   ];
//   String? _selectedTimeSlot;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xffF0F4F7),
//       appBar: AppBar(
//         backgroundColor: Color(0xffD7E8F0),
//         title: Text(
//           'Schedule an Appointment ',
//           style: TextStyle(color: Colors.black),
//         ),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 10, top: 10),
//             child: Text(
//               'Select Date',
//               style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 15),
//             child: Container(
//               width: 360,
//               height: 350,
//               child: TableCalendar(
//                   calendarFormat: _calendarFormat,
//                   rowHeight: 40,
//                   headerStyle: HeaderStyle(
//                       formatButtonVisible: false, titleCentered: true),
//                   availableGestures: AvailableGestures.all,
//                   focusedDay: _focusedDay,
//                   firstDay: DateTime.now(),
//                   lastDay: DateTime.now().add(Duration(days: 30)),
//                   selectedDayPredicate: (day) {
//                     return isSameDay(_selectedDay, day);
//                   },
//                   onDaySelected: (selectedDay, focusedDay) {
//                     setState(() {
//                       _selectedDay = selectedDay;
//                       _focusedDay = focusedDay;
//                     });
//                   }),
//             ),
//           ),
//           // Text('data = ' + _selectedDay.toString().split(" ")[0])
//           Padding(
//             padding: const EdgeInsets.only(left: 10),
//             child: Text(
//               'Select Time',
//               style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 35, top: 20),
//             child: Wrap(
//               spacing: 8.0,
//               runSpacing: 4.0,
//               children: _timeSlots.map((e) {
//                 return Container(
//                   height: 40,
//                   width: 100,
//                   child: ChoiceChip(
//                     showCheckmark: false,
//                     label: SizedBox(
//                       width: 70,
//                       height: 20,
//                       child: Text(
//                         e,
//                         style: TextStyle(fontSize: 13),
//                       ),
//                     ),
//                     selected: _selectedTimeSlot == e,
//                     onSelected: (bool selected) {
//                       setState(() {
//                         _selectedTimeSlot = selected ? e : null;
//                       });
//                       print('Selected time slot: $_selectedTimeSlot');
//                     },
//                     selectedColor: Color.fromARGB(255, 182, 228, 249),
//                     disabledColor: Colors.grey,
//                   ),
//                 );
//               }).toList(), // Convert Iterable to List
//             ),
//           ),
//           // SizedBox(height: 30),
//           GestureDetector(
//             onTap: () {
//               // Navigator.of(context).pushAndRemoveUntil(
//               //   MaterialPageRoute(
//               //       builder: (context) =>
//               //           SuccefullAppoitments()), // Navigate to HomePage
//               //   (Route<dynamic> route) => false, // Remove all other pages
//               // );
//             },
//             child: Padding(
//               padding: const EdgeInsets.only(left: 35, top: 50),
//               child: Container(
//                 height: 49,
//                 width: 320,
//                 decoration: BoxDecoration(
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey
//                             .withOpacity(0.4), // More transparent shadow
//                         spreadRadius: 2, // Reduced spread radius
//                         blurRadius: 4, // Reduced blur radius
//                         offset: Offset(0, 3), // changes position of shadow
//                       ),
//                     ],
//                     color: Color(0xff00466B),
//                     borderRadius: BorderRadius.circular(7)),
//                 child: Center(
//                     child: Text(
//                   'Make an Appointment',
//                   style: TextStyle(
//                       fontSize: 15,
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold),
//                 )),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
