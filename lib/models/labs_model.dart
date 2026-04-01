class getLabsModel {
  int id;
  String name;
  String phone;
  String location;
  String zone;
  String price;
  String labLogo;
  String startTime;
  String finishTime;

  getLabsModel(
      {required this.id,
      required this.name,
      required this.phone,
      required this.location,
      required this.price,
      required this.labLogo,
      required this.startTime,
      required this.finishTime,
      required this.zone});

  static List<getLabsModel> fromJson(Map<String, dynamic> json) {
    var list = json['\$values'] as List;
    List<getLabsModel> labsList = [];
    for (var lab in list) {
      labsList.add(getLabsModel(
          id: lab['Id'],
          name: lab['Name'],
          phone: lab['PhoneNumber'],
          location: lab['Location'],
          zone: lab['Zone'],
          price: lab['Price'],
          labLogo: lab['LabImage'],
          startTime: lab['StartTime'],
          finishTime: lab['EndTime']));
    }
    return labsList;
  }
}
