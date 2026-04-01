class NotificationsModel {
  int id;
  String content;
  String date;
  String location;
  String docName;
  String phone;

  NotificationsModel({
    required this.id,
    required this.content,
    required this.date,
    required this.location,
    required this.docName,
    required this.phone,
  });

  static List<NotificationsModel> fromJson(Map<String, dynamic> json) {
    var list = json['\$values'] as List;
    List<NotificationsModel> notificationsList = [];
    for (var notification in list) {
      var doctor = notification['Doctor'];
      if (doctor.containsKey('\$ref')) {
        var refId = doctor['\$ref'];

        for (var item in list) {
          var potentialDoctor = item['Doctor'];
          if (potentialDoctor['\$id'] == refId) {
            doctor = potentialDoctor;
            break;
          }
        }
      }
      notificationsList.add(NotificationsModel(
          id: notification['Id'],
          content: notification['Messages'],
          date: notification['Date'],
          location: doctor['Location'],
          docName: doctor['Name'],
          phone: doctor['PhoneNumber']));
    }
    return notificationsList;
  }
}
