class TestDetailsModel {
  // int id;
  String date;
  String superVisor;
  String patientName;
  dynamic age;
  dynamic gender;
  dynamic smoker;
  dynamic numberOfCigarettes;
  dynamic bloodPressureMedicine;
  dynamic prevalentStroke;
  dynamic prevalentHypertension;
  dynamic diabatesLevel;
  dynamic cholesterolLevel;
  dynamic glucoseLevel;
  dynamic systolicBloodPressure;
  dynamic diastolicBloodPressure;
  dynamic bmi;
  dynamic heartRate;
  dynamic predictionResult;
  dynamic predictionPrecentage;

  TestDetailsModel({
    // required this.id,
    required this.date,
    required this.superVisor,
    required this.patientName,
    required this.age,
    required this.gender,
    required this.smoker,
    required this.numberOfCigarettes,
    required this.bloodPressureMedicine,
    required this.prevalentStroke,
    required this.prevalentHypertension,
    required this.diabatesLevel,
    required this.cholesterolLevel,
    required this.glucoseLevel,
    required this.systolicBloodPressure,
    required this.diastolicBloodPressure,
    required this.bmi,
    required this.heartRate,
    required this.predictionResult,
    required this.predictionPrecentage,
  });

  factory TestDetailsModel.fromJson(Map<String, dynamic> json) {
    return TestDetailsModel(
        // id: json['Id'],
        date: json['Date'],
        superVisor: json['MedicalAnalystName'],
        patientName: json['PatientName'],
        age: json['Age'],
        gender: json['Gender'],
        smoker: json['Smoking'],
        numberOfCigarettes: json['NumberOfCigarettes'],
        bloodPressureMedicine: json['BloodPressureMedicine'],
        prevalentStroke: json['PrevalentStroke'],
        prevalentHypertension: json['Prevalenthypertension'],
        diabatesLevel: json['Diabetes'],
        cholesterolLevel: json['CholesterolLevel'],
        glucoseLevel: json['GlucoseLevel'],
        systolicBloodPressure: json['SystolicBloodPressure'],
        diastolicBloodPressure: json['DiastolicBloodPressure'],
        bmi: json['BMI'],
        heartRate: json['HeartRate'],
        predictionResult: json['Prediction'],
        predictionPrecentage: json['Probability']);
  }
}
