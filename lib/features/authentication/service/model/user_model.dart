class UserModel {
  String name;
  String email;
  String passord;
  String dob;
  String gender;
  String uid;
  String phone;
  UserModel({
    required this.name,
    required this.passord,
    required this.dob,
    required this.uid,
    required this.email,
    required this.gender,
    required this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": uid,
      "name": name,
      "Date of birth": dob,
      "password": passord,
      "email": email,
      "gender": gender,
      "phone": phone,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map["id"],
      passord: map["password"],
      dob: map["dob"],
      uid: map["uid"],
      email: map["email"],
      gender: map["gender"],
      phone: map["phone"],
    );
  }
}
