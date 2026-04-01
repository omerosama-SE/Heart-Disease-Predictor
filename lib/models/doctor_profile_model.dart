class DoctorProfileModel {
  String name;
  String location;
  String price;
  String zone;
  String about;
  String profilePicture;

  DoctorProfileModel(
      {required this.name,
      required this.location,
      required this.price,
      required this.about,
      required this.zone,
      required this.profilePicture});

  factory DoctorProfileModel.fromJson(Map<String, dynamic> json) {
    return DoctorProfileModel(
        name: json['Name'],
        location: json['Location'],
        price: json['Price'],
        zone: json['Zone'],
        about: json['About'],
        profilePicture: json['ProfileImg']);
  }
}
