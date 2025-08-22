import 'package:techmart/features/address/models/address_model.dart';

String getDefaultId(List<AddressModel?> addressList) {
  final address = addressList.firstWhere(
    (address) => address!.isDefault == true,
  );
  return address!.id!;
}

AddressModel getAddressByid(String id, List<AddressModel> addressList) {
  return addressList.firstWhere((address) => address.id == id);
}

AddressModel getSelectedAddress(String? id, List<AddressModel> addressList) {
  if (id != null) {
    return addressList.firstWhere((address) => address.id == id);
  }
  return addressList.firstWhere((addressModel) => addressModel.isDefault);
}

String removeException(Object e) {
  return e.toString().replaceFirst("Exception", "");
}
