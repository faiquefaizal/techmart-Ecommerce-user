class UserModel {
  String name;
  String email;
  String passord;
  //  String? dob;
  //  String? gender;
  String uid;
  String phone;
  UserModel({
    required this.name,
    required this.passord,
    //   this.dob,
    required this.uid,
    required this.email,
    //  this.gender,
    required this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": uid,
      "name": name,
      //    "Date of birth": dob,
      "password": passord,
      "email": email,
      //     "gender": gender,
      "phone": phone,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map["name"] ?? "",
      passord: map["password"],
      //   dob: map["dob"] ?? "",
      uid: map["id"] ?? "",
      email: map["email"] ?? "",
      //     gender: map["gender"] ?? "",
      phone: map["phone"] ?? "",
    );
  }
  UserModel copyWith({
    String? name,
    String? email,
    String? passord,
    String? dob,
    String? gender,
    String? uid,
    String? phone,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      passord: passord ?? this.passord,
      //   dob: dob ?? this.dob,
      //   gender: gender ?? this.gender,
      uid: uid ?? this.uid,
      phone: phone ?? this.phone,
    );
  }

  String toString() {
    return " UserModel(name: $name, passord: passord, uid: $uid, email: $email, phone:$phone)";
  }
}
