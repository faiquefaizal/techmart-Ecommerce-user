import 'package:equatable/equatable.dart';

class AddressModel extends Equatable {
  final String? id;
  final String fullName;
  final String phoneNumber;
  final String pinCode;
  final String state;
  final String city;
  final String houseNo;
  final String area;
  final bool isDefault;

  const AddressModel({
    this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.pinCode,
    required this.state,
    required this.city,
    required this.houseNo,
    required this.area,
    this.isDefault = false,
  });
  String get fulladdress => "$houseNo, $area, $city, $state - $pinCode";
  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      id: map['id'],
      fullName: map['fullName'],
      phoneNumber: map['phoneNumber'],
      pinCode: map['pinCode'],
      state: map['state'],
      city: map['city'],
      houseNo: map['houseNo'],
      area: map['area'],
      isDefault: map['isDefault'] ?? false,
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'fullName': fullName,
    'phoneNumber': phoneNumber,
    'pinCode': pinCode,
    'state': state,
    'city': city,
    'houseNo': houseNo,
    'area': area,
    'isDefault': isDefault,
  };
  AddressModel copyWith({
    String? id,
    String? fullName,
    String? phoneNumber,
    String? pinCode,
    String? state,
    String? city,
    String? houseNo,
    String? area,
    bool? isDefault,
  }) {
    return AddressModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      pinCode: pinCode ?? this.pinCode,
      state: state ?? this.state,
      city: city ?? this.city,
      houseNo: houseNo ?? this.houseNo,
      area: area ?? this.area,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  @override
  List<Object?> get props => [
    id,
    phoneNumber,
    fullName,
    pinCode,
    state,
    houseNo,
    area,
  ];
}
