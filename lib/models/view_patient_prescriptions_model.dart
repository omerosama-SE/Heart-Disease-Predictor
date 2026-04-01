class ViewPatientPrescriptionsModel {
  int id;
  String date;
  String docName;

  ViewPatientPrescriptionsModel(
      {required this.date, required this.id, required this.docName});

  static List<ViewPatientPrescriptionsModel> fromJson(
      Map<String, dynamic> json) {
    var list = json['\$values'] as List; //casting the json list to a list
    List<ViewPatientPrescriptionsModel> prescriptionsList = [];
    for (var appoitnment in list) {
      prescriptionsList.add(ViewPatientPrescriptionsModel(
          id: appoitnment['Id'],
          date: appoitnment['date'],
          docName: appoitnment['Doctorr']['Name']));
    }
    return prescriptionsList;
  }
}

//Doctor
class ViewAllDoctorPrescriptionsModel {
  int id;
  String date;
  String patientEmail;
  int patientSSN;
  int doctorId;
  String firstName;
  String lastName;
  int age;
  int gender;

  ViewAllDoctorPrescriptionsModel({
    required this.id,
    required this.date,
    required this.patientEmail,
    required this.patientSSN,
    required this.doctorId,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.gender,
  });

//This if ref is exists
  static List<ViewAllDoctorPrescriptionsModel> fromJson(
      Map<String, dynamic> json) {
    var list = json['\$values'] as List;
    List<ViewAllDoctorPrescriptionsModel> prescriptionsList = [];
    for (var appointment in list) {
      var user = appointment['Patient']['User'];
      if (user.containsKey('\$ref')) {
        var refId = user['\$ref'];
        // Iterate over the \$values list again to find the user with the matching id
        for (var item in list) {
          var potentialUser = item['Patient']['User'];
          if (potentialUser['\$id'] == refId) {
            user = potentialUser;
            break;
          }
        }
      }
      prescriptionsList.add(ViewAllDoctorPrescriptionsModel(
          id: appointment['Id'],
          date: appointment['date'],
          patientEmail: appointment['PatientEmail'],
          patientSSN: appointment['PatientSSN'],
          doctorId: appointment['DoctorId'],
          firstName: user['FirstName'],
          lastName: user['LastName'],
          age: user['Age'],
          gender: user['Gender']));
    }
    return prescriptionsList;
  }
}

// Patient
class ViewAllPatientPrescriptionsModel {
  int id;
  String date;
  String name;

  ViewAllPatientPrescriptionsModel(
      {required this.id, required this.date, required this.name});

  static List<ViewAllPatientPrescriptionsModel> fromJson(
      Map<String, dynamic> json) {
    var list = json['\$values'] as List; //casting the json list to a list
    List<ViewAllPatientPrescriptionsModel> prescriptionsList = [];
    for (var appoitnment in list) {
      prescriptionsList.add(ViewAllPatientPrescriptionsModel(
          id: appoitnment['Id'],
          date: appoitnment['date'],
          name: appoitnment['Doctorr']['Name']));
    }
    return prescriptionsList;
  }
}
