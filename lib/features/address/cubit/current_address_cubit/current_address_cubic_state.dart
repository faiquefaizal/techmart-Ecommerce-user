part of 'current_address_cubic_cubit.dart';

class CurrentAddressCubicState extends Equatable {
  final String? id;
  final String fullName;
  final String phoneNumber;
  final String pinCode;
  final String state;
  final String city;
  final String houseNo;
  final String area;
  final bool isDefault;

  const CurrentAddressCubicState({
    this.id,
    this.fullName = '',
    this.phoneNumber = '',
    this.pinCode = '',
    this.state = '',
    this.city = '',
    this.houseNo = '',
    this.area = '',
    this.isDefault = false,
  });

  CurrentAddressCubicState copyWith({
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
    return CurrentAddressCubicState(
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
    fullName,
    phoneNumber,
    pinCode,
    state,
    city,
    houseNo,
    area,
    isDefault,
  ];
}
