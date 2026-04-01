import 'package:flutter/material.dart';
import 'dart:io';
import 'package:heart_disease_prediction/screens/welcome_page.dart';

var globalToken;
var roles;
var email;
var name;
var docImage;
var labImage;
var oneOrTwo;
void main() async {
  //
  runApp(const HeartDiseasePredictor());
}

class HeartDiseasePredictor extends StatelessWidget {
  const HeartDiseasePredictor();
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
