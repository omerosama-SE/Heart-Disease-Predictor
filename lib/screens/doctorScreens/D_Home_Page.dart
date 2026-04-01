import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_disease_prediction/Components/home_page_containers.dart';
import 'package:heart_disease_prediction/main.dart';
import 'package:heart_disease_prediction/models/doctors_list_model.dart';
import 'package:heart_disease_prediction/screens/all_profiles.dart';
import 'package:heart_disease_prediction/screens/doctorScreens/doctor_appoitnments.dart';
import 'package:heart_disease_prediction/screens/doctorScreens/view_predictions.dart';
import 'package:heart_disease_prediction/screens/doctorScreens/view_prescriptions.dart';
import 'package:heart_disease_prediction/screens/medicalTests.dart';
import 'package:heart_disease_prediction/screens/view_appoitments_page.dart';

class DoctorHomePage extends StatefulWidget {
  const DoctorHomePage({super.key});

  @override
  State<DoctorHomePage> createState() => _HomePageState();
}

class _HomePageState extends State<DoctorHomePage> {
  @override
  final borderStyle = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(7)),
    borderSide: BorderSide(color: Colors.grey, width: 1.5),
  );

  int index = 0;
  final screens = [DoctorMainPage(), DoctorProfile()];

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
                    icon: Icon(Icons.home_outlined), label: 'Home'),
                // NavigationDestination(icon: Icon(Icons.face), label: 'Home'),
                NavigationDestination(
                    icon: Icon(Icons.person_outline_outlined),
                    label: 'My Profile'),
              ],
            )),
        backgroundColor: Color(0xffF0F4F7),
        body: screens[index]);
  }
}

//Home page in navgation bar
class DoctorMainPage extends StatefulWidget {
  const DoctorMainPage({super.key});

  @override
  State<DoctorMainPage> createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorMainPage> {
  final borderStyle = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(7)),
    borderSide: BorderSide(color: Colors.grey, width: 1.5),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Spacer(flex: 3),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello, Dr. $name',
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
                        image: NetworkImage(docImage),
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.fill)),
              ),
            ),
          ],
        ),
        leadingWidth: 30,
      ),
      backgroundColor: Color(0xffF0F4F7),
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
                    return DoctorAppoitnments();
                  }));
                },
              ),
              SizedBox(height: 10),
              HomeContainers(
                img: Image.asset('assets/images/prescription.png'),
                text: 'View Prescriptions',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return DoctorPrescriptions();
                  }));
                },
              ),
              // SizedBox(height: 10),
              // HomeContainers(
              //   //work on it
              //   img: Image.asset('assets/images/blood-test.png'),
              //   text: 'View Medical Tests',
              //   onTap: () {
              //     Navigator.push(context, MaterialPageRoute(builder: (context) {
              //       return DoctorMedicalAnalystMedicalTests();
              //     }));
              //   },
              // ),
              // SizedBox(height: 10),
              // HomeContainers(
              //   img: Image.asset('assets/images/check (1).png'),
              //   text: 'View Predictions',
              //   onTap: () {
              //     Navigator.push(context, MaterialPageRoute(builder: (context) {
              //       return ViewPredictions();
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
