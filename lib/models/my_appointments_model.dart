class MyUpcomingAppointmentsModel {
  int id;
  String date;
  String time;
  int docId;
  String docName;
  String docLocation;
  String phone;
  String profileImg;

  MyUpcomingAppointmentsModel(
      {required this.id,
      required this.date,
      required this.time,
      required this.docId,
      required this.docName,
      required this.docLocation,
      required this.phone,
      required this.profileImg});

  static List<MyUpcomingAppointmentsModel> fromJson(Map<String, dynamic> json) {
    var list = json['\$values'] as List;
    List<MyUpcomingAppointmentsModel> appointemntsList = [];
    for (var appointment in list) {
      var user = appointment['Doctor']['User'];
      if (user.containsKey('\$ref')) {
        var refId = user['\$ref'];

        for (var item in list) {
          var potentialUser = item['Doctor']['User'];
          if (potentialUser['\$id'] == refId) {
            user = potentialUser;
            break;
          }
        }
      }
      appointemntsList.add(MyUpcomingAppointmentsModel(
          id: appointment['Id'],
          date: appointment['date'],
          time: appointment['Time'],
          docId: appointment['DoctorId'],
          docName: appointment['Doctor']['Name'],
          docLocation: appointment['Doctor']['Location'],
          phone: user['PhoneNumber'],
          profileImg: user['ProfileImg']));
    }
    return appointemntsList;
  }
}

class MyCanceledAppointmentsModel {
  int id;
  String date;
  String time;
  int docId;
  String docName;
  // String docLocation;
  String phone;
  String profileImg;

  MyCanceledAppointmentsModel(
      {required this.id,
      required this.date,
      required this.time,
      required this.docId,
      required this.docName,
      // required this.docLocation,
      required this.phone,
      required this.profileImg});

  static List<MyCanceledAppointmentsModel> fromJson(Map<String, dynamic> json) {
    var list = json['\$values'] as List;
    List<MyCanceledAppointmentsModel> appointemntsList = [];
    for (var appointment in list) {
      if (appointment['IsAccepted'] == false) {
        var user = appointment['Doctor']['User'];
        if (user.containsKey('\$ref')) {
          var refId = user['\$ref'];

          for (var item in list) {
            var potentialUser = item['Doctor']['User'];
            if (potentialUser['\$id'] == refId) {
              user = potentialUser;
              break;
            }
          }
        }
        appointemntsList.add(MyCanceledAppointmentsModel(
            id: appointment['Id'],
            date: appointment['Date'],
            time: appointment['Time'],
            docId: appointment['DoctorId'],
            docName: appointment['Doctor']['Name'],
            // docLocation: appointment['Doctor']['Location'],
            phone: user['PhoneNumber'],
            profileImg: user['ProfileImg']));
      }
    }
    return appointemntsList;
  }
}

class MyCompletedAppointmentsModel {
  int id;
  String date;
  String time;
  int docId;
  String docName;
  // String docLocation;
  String phone;
  String profileImg;

  MyCompletedAppointmentsModel(
      {required this.id,
      required this.date,
      required this.time,
      required this.docId,
      required this.docName,
      // required this.docLocation,
      required this.phone,
      required this.profileImg});

  static List<MyCompletedAppointmentsModel> fromJson(
      Map<String, dynamic> json) {
    var list = json['\$values'] as List;
    List<MyCompletedAppointmentsModel> appointemntsList = [];
    for (var appointment in list) {
      if (appointment['IsAccepted'] == true) {
        var user = appointment['Doctor']['User'];
        if (user.containsKey('\$ref')) {
          var refId = user['\$ref'];

          for (var item in list) {
            var potentialUser = item['Doctor']['User'];
            if (potentialUser['\$id'] == refId) {
              user = potentialUser;
              break;
            }
          }
        }
        appointemntsList.add(MyCompletedAppointmentsModel(
            id: appointment['Id'],
            date: appointment['Date'],
            time: appointment['Time'],
            docId: appointment['DoctorId'],
            docName: appointment['Doctor']['Name'],
            // docLocation: appointment['Doctor']['Location'],
            phone: user['PhoneNumber'],
            profileImg: user['ProfileImg']));
      }
    }
    return appointemntsList;
  }
}
