import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:heart_disease_prediction/Components/home_page_containers.dart';
import 'package:heart_disease_prediction/main.dart';
import 'package:heart_disease_prediction/screens/all_profiles.dart';
import 'package:heart_disease_prediction/screens/appointments_labs.dart';
import 'package:heart_disease_prediction/screens/appoitments.dart';
import 'package:heart_disease_prediction/screens/medicalTests.dart';
import 'package:heart_disease_prediction/screens/predictions.dart';
import 'package:heart_disease_prediction/screens/prescriptions.dart';
import 'package:heart_disease_prediction/screens/view_appoitments_page.dart';
import 'package:heart_disease_prediction/screens/view_notifications.dart';
import 'package:heart_disease_prediction/screens/welcome_page.dart';
import 'package:http/http.dart';

//patient home page

final screens = [
  const PatientMainPageV2(),
  const ViewAppoitments(),
  const ViewNotificationsPage(),
  const UserProfile()
];

class PatientHomePage extends StatefulWidget {
  const PatientHomePage({super.key});

  @override
  State<PatientHomePage> createState() => _PatientHomePageState();
}

class _PatientHomePageState extends State<PatientHomePage> {
  @override
  final borderStyle = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(7)),
    borderSide: BorderSide(color: Colors.grey, width: 1.5),
  );

  int index = 0;

  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: NavigationBarTheme(
            data:
                const NavigationBarThemeData(indicatorColor: Color(0xffD7E8F0)),
            child: NavigationBar(
              elevation: 0,
              selectedIndex: index,
              onDestinationSelected: (index) =>
                  setState(() => this.index = index),
              height: 70,
              backgroundColor: Colors.white,
              destinations: const [
                NavigationDestination(
                    icon: Icon(Icons.home_outlined), label: 'Home'),
                // NavigationDestination(icon: Icon(Icons.face), label: 'Home'),
                NavigationDestination(
                    icon: Icon(Icons.event_note), label: 'Appointments'),
                NavigationDestination(
                    icon: Icon(Icons.notifications_outlined),
                    label: 'Notifications'),
                NavigationDestination(
                    icon: Icon(Icons.person_outline_outlined),
                    label: 'My Profile'),
              ],
            )),
        backgroundColor: const Color(0xffF0F4F7),
        body: screens[index]);
  }
}

//Home Page in navgation bar
class PatientMainPage extends StatefulWidget {
  const PatientMainPage({super.key});

  @override
  State<PatientMainPage> createState() => _PatientMainPageState();
}

class _PatientMainPageState extends State<PatientMainPage> {
  @override
  final borderStyle = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(7)),
    borderSide: BorderSide(color: Colors.grey, width: 1.5),
  );

  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffF0F4F7),
      appBar: AppBar(
        backgroundColor: const Color(0XFFD7E8F0),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Heart Disease Prediction',
              style: TextStyle(
                  fontSize: 30, fontFamily: 'Myriad', color: Color(0xff00466D)),
            )
          ],
        ),
      ),
      body: Center(
        child: Column(children: [
          // Spacer(flex: 1),
          BouncingLogo(
            height: height * 0.45,
          ),
          Text(
            'Welcome $name!',
            style: TextStyle(
                fontFamily: 'Myriad',
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Color(0xff00466D)),
          ),
          SizedBox(height: height * 0.01),
          const Text(
            'How are you feeling today!',
            style: TextStyle(
                fontFamily: 'Myriad',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey),
          ),
          SizedBox(height: height * 0.009),
          const Text(
            'Our system helps you keep your heart healthy and',
            style: TextStyle(
                fontFamily: 'Myriad',
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.grey),
          ),
          SizedBox(height: height * 0.009),
          const Text(
            'predict any heart diseases that could affect it early,',
            style: TextStyle(
                fontFamily: 'Myriad',
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.grey),
          ),
          SizedBox(height: height * 0.009),
          const Text(
            'Let\'s start this journey for a healthier heart!',
            style: TextStyle(
                fontFamily: 'Myriad',
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.grey),
          ),
          const Spacer(flex: 2),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const UserMedicalTests();
                }));
              },
              child: const Row(
                children: [
                  Spacer(flex: 1),
                  Text(
                    'Get Started',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontFamily: 'Myriad'),
                  ),
                  SizedBox(width: 10),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                  Spacer(flex: 1),
                ],
              ),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7)),
                  backgroundColor: const Color(0xff00466B),
                  fixedSize: Size(width * 0.6, height * 0.055))),
          SizedBox(height: height * 0.01),
          ElevatedButton(
              onPressed: () {
                DialougBuilder(context);
              },
              child: const Row(
                children: [
                  Spacer(flex: 1),
                  Text(
                    'Exit',
                    style: TextStyle(
                        color: Color(0xff00466B),
                        fontSize: 25,
                        fontFamily: 'Myriad'),
                  ),
                  SizedBox(width: 10),
                  Icon(
                    Icons.exit_to_app_rounded,
                    color: Color(0xff00466B),
                  ),
                  Spacer(flex: 1),
                ],
              ),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7)),
                  backgroundColor: const Color(0xffD7E8F0),
                  fixedSize: Size(width * 0.6, height * 0.055),
                  side: BorderSide(color: Color(0xff00466B)))),

          const Spacer(flex: 10),
        ]),
      ),
    );
  }
}

class PatientMainPageV2 extends StatefulWidget {
  const PatientMainPageV2({super.key});

  @override
  State<PatientMainPageV2> createState() => _PatientMainPageStateV2();
}

class _PatientMainPageStateV2 extends State<PatientMainPageV2> {
  @override
  final borderStyle = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(7)),
    borderSide: BorderSide(color: Colors.grey, width: 1.5),
  );

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF0F4F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: 40,
                height: 40,
                child: Image.asset('assets/images/user.png')),
            const Spacer(flex: 3),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello, $name',
                  style: const TextStyle(
                      color: Colors.black, fontSize: 20, fontFamily: 'Myriad'),
                ),
                const Text(
                  'Stay Healthy',
                  style: TextStyle(
                      color: Colors.grey, fontSize: 15, fontFamily: 'Myriad'),
                ),
              ],
            ),
            const Spacer(flex: 50),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_none,
                  size: 27,
                )),
          ],
        ),
        leadingWidth: 30,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const DoctorsListShow();
                  }));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey
                            .withOpacity(0.3), // More transparent shadow
                        spreadRadius: 2, // Reduced spread radius
                        blurRadius: 4, // Reduced blur radius
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  height: 110,
                  width: 400,
                  child: Row(
                    children: [
                      const Spacer(flex: 1),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Spacer(flex: 1),
                          const Text(
                            'Find a Cardiologist',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 50,
                            width: 370,
                            child: TextField(
                                readOnly: true,
                                cursorColor: const Color(0xff004670),
                                decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.only(left: 20),
                                    hintText: 'Search for a doctor',
                                    prefixIcon: const Icon(Icons.search),
                                    border: borderStyle,
                                    focusedBorder: borderStyle,
                                    enabledBorder: borderStyle)),
                          ),
                          const Spacer(flex: 1),
                        ],
                      ),
                      const Spacer(flex: 1),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              HomeContainers(
                img: Image.asset('assets/images/medical-checkup.png'),
                text: 'Book Doctor Appointment',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const DoctorsListShow();
                  }));
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              HomeContainers(
                img: Image.asset('assets/images/microscope (3).png'),
                text: 'Book Lab Appointment',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const LabsList();
                  }));
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              HomeContainers(
                img: Image.asset('assets/images/prescription.png'),
                text: 'View Prescriptions',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const Prescriptions();
                  }));
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              // HomeContainers(
              //   img: Image.asset('assets/images/blood-test.png'),
              //   text: 'View Medical Tests',
              //   onTap: () {
              //     Navigator.push(context, MaterialPageRoute(builder: (context) {
              //       return const UserMedicalTests();
              //     }));
              //   },
              // ),
              // SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              HomeContainers(
                img: Image.asset('assets/images/check (1).png'),
                text: 'View Predictions',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const UserMedicalTests();
                  }));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> DialougBuilder(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: Text(
              'Do you really want to exit the app?',
              style: TextStyle(fontSize: 20),
            ),
            titlePadding: EdgeInsets.all(20),
            insetPadding: EdgeInsets.all(25),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Spacer(flex: 8),
                  TextButton(
                      onPressed: () {
                        SystemNavigator.pop();
                      },
                      child: Text('Yes',
                          style: TextStyle(
                              fontSize: 20,
                              color: Color(0xff00466D),
                              fontWeight: FontWeight.bold))),
                  // Spacer(flex: 1),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'No',
                        style: TextStyle(
                            fontSize: 20,
                            color: Color(0xff00466D),
                            fontWeight: FontWeight.bold),
                      )),
                  // Spacer(flex: 1),
                ],
              ),
            ],
            shape:
                BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)));
      });
}
