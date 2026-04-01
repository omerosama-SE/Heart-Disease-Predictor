import 'package:flutter/material.dart';

class AppoitnmentsModel {
  int id;
  String name;
  String location;
  String zone;
  String profilePicture;
  String price;
  String about;
  int gender;
  String startTime;
  String finishTime;
  bool isAvailable;

  AppoitnmentsModel(
      {required this.name,
      required this.location,
      required this.price,
      required this.isAvailable,
      required this.id,
      required this.zone,
      required this.profilePicture,
      required this.about,
      required this.gender,
      required this.startTime,
      required this.finishTime});

  static List<AppoitnmentsModel> fromJson(Map<String, dynamic> json) {
    var list = json['\$values'] as List; //casting the json list to a list
    List<AppoitnmentsModel> doctorsList = [];
    for (var appoitnment in list) {
      doctorsList.add(AppoitnmentsModel(
          name: appoitnment['User']['Name'],
          location: appoitnment['Location'],
          price: appoitnment['Price'],
          isAvailable: appoitnment['IsAvailable'],
          id: appoitnment['Id'],
          zone: appoitnment['Zone'],
          profilePicture: appoitnment['User']['ProfileImg'],
          about: appoitnment['User']['About'],
          gender: appoitnment['User']['Gender'],
          startTime: appoitnment['User']['StartTime'],
          finishTime: appoitnment['User']['EndTime']));
    }
    return doctorsList;
    // return AppoitnmentsModel(
    //     name: json['\$values'][0]['Name'],
    //     location: json['\$values'][0]['Location'],
    //     price: json['\$values'][0]['Price'],
    //     isAvailable: json['\$values'][0]['IsAvailable']);
  }
}
