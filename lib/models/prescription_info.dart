class PrescriptionInfoModel {
  String medicineName;
  String date;
  String doctorName;

  PrescriptionInfoModel(
      {required this.medicineName,
      required this.date,
      required this.doctorName});

  factory PrescriptionInfoModel.fromJson(Map<String, dynamic> json) {
    return PrescriptionInfoModel(
        medicineName: json['MedicineName'],
        date: json['Date'],
        doctorName: json['DoctorName']);
  }
}
