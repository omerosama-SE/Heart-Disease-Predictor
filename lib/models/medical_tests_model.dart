class MedicalTestsModel {
  //for patient
  int id;
  String labName;
  String superVisor;
  String date;

  MedicalTestsModel(
      {required this.id,
      required this.labName,
      required this.superVisor,
      required this.date});

  static List<MedicalTestsModel> fromJson(Map<String, dynamic> json) {
    var list = json['\$values'] as List;
    List<MedicalTestsModel> testsList = [];
    for (var test in list) {
      var lab = test['Labb'];
      if (lab.containsKey('\$ref')) {
        var refId = lab['\$ref'];
        for (var item in list) {
          var potentialLab = item['Labb'];
          if (potentialLab['\$id'] == refId) {
            lab = potentialLab;
            break;
          }
        }
      }
      testsList.add(MedicalTestsModel(
          id: test['Id'],
          labName: lab['Name'],
          superVisor: test['MedicalAnalystName'],
          date: test['Date']));
    }
    return testsList;
  }
}

class MedicalTestsModelDoc {
  //for doc
  int id;
  String labName;
  String superVisor;
  String date;

  MedicalTestsModelDoc(
      {required this.id,
      required this.labName,
      required this.superVisor,
      required this.date});

  static List<MedicalTestsModelDoc> fromJson(Map<String, dynamic> json) {
    var list = json['\$values'] as List;
    List<MedicalTestsModelDoc> testsList = [];
    for (var item in list) {
      testsList.add(MedicalTestsModelDoc(
          id: item['Id'],
          labName: item['LabEmail'],
          superVisor: item['MedicalAnalystName'],
          date: item['Date']));
    }
    return testsList;
  }
}

class MedicalTestsModelLab {
  //for lab
  int id;
  String patientName;
  String superVisor;
  String date;

  MedicalTestsModelLab(
      {required this.id,
      required this.patientName,
      required this.superVisor,
      required this.date});

  static List<MedicalTestsModelLab> fromJson(Map<String, dynamic> json) {
    var list = json['\$values'] as List;
    List<MedicalTestsModelLab> testsList = [];
    for (var test in list) {
      var user = test['Patient']['User'];
      if (user.containsKey('\$ref')) {
        var refId = user['\$ref'];
        for (var item in list) {
          var potentialUser = item['Patient']['User'];
          if (potentialUser['\$id'] == refId) {
            user = potentialUser;
            break;
          }
        }
      }
      testsList.add(MedicalTestsModelLab(
          id: test['Id'],
          patientName: test['PatientName'],
          superVisor: test['MedicalAnalystName'],
          date: test['Date']));
    }
    return testsList;
  }
}
