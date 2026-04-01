import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_disease_prediction/Components/home_page_containers.dart';
import 'package:heart_disease_prediction/main.dart';
import 'package:heart_disease_prediction/screens/all_profiles.dart';
import 'package:heart_disease_prediction/screens/medicalAnalystScreens/add_medical_Tests.dart';
import 'package:heart_disease_prediction/screens/medicalAnalystScreens/generate_predictions.dart';
import 'package:heart_disease_prediction/screens/medicalAnalystScreens/lab_appointments.dart';
import 'package:heart_disease_prediction/screens/medicalTests.dart';
import 'package:heart_disease_prediction/screens/view_appoitments_page.dart';

class MedicalAnalystHomePage extends StatefulWidget {
  const MedicalAnalystHomePage({super.key});

  @override
  State<MedicalAnalystHomePage> createState() => _MedicalAnalystHomePageState();
}

class _MedicalAnalystHomePageState extends State<MedicalAnalystHomePage> {
  @override
  final borderStyle = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(7)),
    borderSide: BorderSide(color: Colors.grey, width: 1.5),
  );

  int index = 0;
  final screens = [MedicalAnalystMainPage(), MedicalAnalystProfille()];

  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: NavigationBarTheme(
            data: NavigationBarThemeData(indicatorColor: Color(0xffD7E8F0)),
            child: NavigationBar(
              elevation: 0,
              selectedIndex: index,
              onDestinationSelected: (index) =>
                  setState(() => this.index = index),
              height: 70,
              backgroundColor: Colors.white,
              destinations: [
                NavigationDestination(
                    icon: Icon(Icons.home_filled), label: 'Home'),
                // NavigationDestination(icon: Icon(Icons.face), label: 'Home'),
                NavigationDestination(
                    icon: Icon(Icons.person), label: 'Profile')
              ],
            )),
        backgroundColor: Color(0xffF0F4F7),
        body: screens[index]);
  }
}

//Home page in navgation bar
class MedicalAnalystMainPage extends StatefulWidget {
  const MedicalAnalystMainPage({super.key});

  @override
  State<MedicalAnalystMainPage> createState() => _MedicalAnalystMainPageState();
}

class _MedicalAnalystMainPageState extends State<MedicalAnalystMainPage> {
  final borderStyle = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(7)),
    borderSide: BorderSide(color: Colors.grey, width: 1.5),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF0F4F7),
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Spacer(flex: 3),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome, EL-Mokhtabr',
                  style: TextStyle(
                      color: Colors.black, fontSize: 20, fontFamily: 'Myriad'),
                ),
                Text(
                  'Stay Healthy',
                  style: TextStyle(
                      color: Colors.grey, fontSize: 15, fontFamily: 'Myriad'),
                ),
              ],
            ),
            Spacer(flex: 50),
            // IconButton(
            //     onPressed: () {
            //       // setState(() {
            //       //   indeX = 2;
            //       //   screens[indeX];
            //       // });
            //     },
            //     icon: Icon(
            //       Icons.person_outline_rounded,
            //       size: 27,
            //     )),
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    width: 1,
                    color: Color(0xffC1D0D8),
                  )),
              child: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    image: DecorationImage(
                        image: NetworkImage(labImage),
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.fill)),
              ),
            ),
          ],
        ),
        leadingWidth: 30,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 10),
              HomeContainers(
                img: Image.asset('assets/images/calendar.png'),
                text: 'View Appointments',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return LabAppointments();
                  }));
                },
              ),
              // SizedBox(height: 10),
              // HomeContainers(
              //   img: Image.asset('assets/images/bloodTest9.png'),
              //   text: 'Add Medical Tests',
              //   onTap: () {
              //     Navigator.push(context, MaterialPageRoute(builder: (context) {
              //       return AddMedicalTest();
              //     }));
              //   },
              // ),
              SizedBox(height: 10),
              HomeContainers(
                img: Image.asset('assets/images/blood-test.png'),
                text: 'View Medical Tests',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return DoctorMedicalAnalystMedicalTests();
                  }));
                },
              ),
              // SizedBox(height: 10),
              // HomeContainers(
              //   img: Image.asset('assets/images/check (1).png'),
              //   text: 'Generate Predictions',
              //   onTap: () {
              //     Navigator.push(context, MaterialPageRoute(builder: (context) {
              //       return GeneratePrediction();
              //     }));
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
