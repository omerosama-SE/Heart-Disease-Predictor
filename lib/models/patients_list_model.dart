class PatientsListForDoctorModel {
  int id;
  String date;
  String time;
  String name;
  String phone;
  int ssn;
  int age;
  int gender;

  PatientsListForDoctorModel(
      {required this.id,
      required this.date,
      required this.time,
      required this.name,
      required this.phone,
      required this.ssn,
      required this.age,
      required this.gender});

  // factory PatientListModel.fromJson(Map<String, dynamic> json) {
  //   return PatientListModel(
  //       id: json['\$values'][0]['Id'],
  //       date: json['\$values'][0]['date'],
  //       time: json['\$values'][0]['Time'],
  //       name: json['\$values'][0]['PateintName'],
  //       phone: json['\$values'][0]['PhoneNumber'],);
  // }
  // static List<PatientListModel> fromJson(Map<String, dynamic> json) {
  //   List<PatientListModel> doctorsList = [];
  //   var list = json['\$values'][0]['Doctor']['Appointments']['\$values']
  //       as List; //list of bottom appoitnments
  //   doctorsList.add(PatientListModel(
  //       //get the first appoitment
  //       id: json['\$values'][0]['Id'],
  //       date: json['\$values'][0]['date'],
  //       time: json['\$values'][0]['Time'],
  //       name: json['\$values'][0]['PateintName'],
  //       phone: json['\$values'][0]['PhoneNumber'],
  //       ssn: json['\$values'][0]['Patientt']['SSN'],
  //       age: json['\$values'][0]['Patientt']['Age'],
  //       gender: json['\$values'][0]['Patientt']['Gender']));

  //   for (var element in list.sublist(1)) {
  //     var patientData = element['Patientt'];
  //     if (patientData.containsKey('\$ref')) {
  //       var referencedPatientId = patientData['\$ref'];
  //     }
  //   }

  //   for (var element in list.sublist(1)) {
  //     // get the rest appoitments
  //     doctorsList.add(PatientListModel(
  //         id: element['Id'],
  //         date: element['date'],
  //         time: element['Time'],
  //         name: element['PateintName'],
  //         phone: element['PhoneNumber'],
  //         ssn: element['Patientt']['SSN'], // excepect to be null
  //         age: element['Patientt']['Age'], // excepect to be null
  //         gender: element['Patientt']['Gender'])); // excepect to be null
  //   }
  //   return doctorsList;
  // }
  //after update
  static List<PatientsListForDoctorModel> fromJson(Map<String, dynamic> json) {
    var list = json['\$values'] as List; //casting the json list to a list
    List<PatientsListForDoctorModel> patientsList = [];
    for (var appoitnment in list) {
      patientsList.add(PatientsListForDoctorModel(
        id: appoitnment['Id'],
        date: appoitnment['date'],
        time: appoitnment['Time'],
        name: appoitnment['PateintName'],
        phone: appoitnment['PhoneNumber'],
        ssn: appoitnment['Patientt']['SSN'],
        age: appoitnment['Patientt']['Age'],
        gender: appoitnment['Patientt']['Gender'],
      ));
    }
    return patientsList;
  }
}

class PatientsListForLabModel {
  int id;
  String date;
  String time;
  String name;
  String phone;
  int ssn;
  int age;
  int gender;

  PatientsListForLabModel(
      {required this.id,
      required this.date,
      required this.time,
      required this.name,
      required this.phone,
      required this.ssn,
      required this.age,
      required this.gender});

  static List<PatientsListForLabModel> fromJson(Map<String, dynamic> json) {
    var list = json['\$values'] as List;
    List<PatientsListForLabModel> patientsList = [];
    for (var appoitnment in list) {
      patientsList.add(PatientsListForLabModel(
        id: appoitnment['Id'],
        date: appoitnment['date'],
        time: appoitnment['Time'],
        name: appoitnment['PateintName'],
        phone: appoitnment['PhoneNumber'],
        ssn: appoitnment['Patientt']['SSN'],
        age: appoitnment['Patientt']['Age'],
        gender: appoitnment['Patientt']['Gender'],
      ));
    }
    return patientsList;
  }
}
