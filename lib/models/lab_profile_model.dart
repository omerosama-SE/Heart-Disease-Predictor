class LabProfileModel {
  String logo;
  String name;
  String zone;
  String price;
  // String about;
  // String startTime;
  // String endTime;

  LabProfileModel(
      {required this.logo,
      required this.name,
      required this.zone,
      required this.price});

  factory LabProfileModel.fromJson(Map<String, dynamic> json) {
    return LabProfileModel(
        logo: json['ProfileImg'],
        name: json['Name'],
        zone: json['Zone'],
        price: json['Price']);
  }
}
