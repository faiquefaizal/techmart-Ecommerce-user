import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techmart/core/utils/genrete_firbase_id.dart';
import 'package:techmart/features/address/models/address_model.dart';
import 'package:techmart/features/authentication/service/Auth_service.dart';

class AddressService {
  static CollectionReference get _addressRef {
    final userid = AuthService().getUserId();
    return FirebaseFirestore.instance
        .collection("Users")
        .doc(userid)
        .collection("Address");
  }

  static Stream<List<AddressModel>> getAllAddress() {
    final addressSnap = _addressRef.snapshots();
    return addressSnap.map(
      (e) =>
          e.docs
              .map(
                (doc) =>
                    AddressModel.fromMap(doc.data() as Map<String, dynamic>),
              )
              .toList(),
    );
  }

  static Future<List<AddressModel>> getAllAddressList() async {
    final addressSnap = await _addressRef.get();
    try {
      return addressSnap.docs
          .map((e) => AddressModel.fromMap(e.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  static Future<AddressModel> getAddressById(String id) async {
    final addressdoc = await _addressRef.doc(id).get();
    return AddressModel.fromMap(addressdoc.data() as Map<String, dynamic>);
  }

  static Future<void> addAddress(AddressModel addressModel) async {
    final addressId = genertateFirebase();
    final updatedAddressModel = addressModel.copyWith(id: addressId);
    await _addressRef.doc(addressId).set(updatedAddressModel.toMap());
  }

  static Future<void> editAddress(AddressModel address) async {
    log(address.id!);
    await _addressRef.doc(address.id).update(address.toMap());
  }

  static Future<void> delete(String addressId) async {
    try {
      await _addressRef.doc(addressId).delete();
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> clearDefaultAddresses() async {
    log('Clearing existing default addresses');
    final snapshot =
        await _addressRef.where('isDefault', isEqualTo: true).get();
    for (var doc in snapshot.docs) {
      log('Resetting isDefault for address id: ${doc.id}');
      await _addressRef.doc(doc.id).update({'isDefault': false});
    }
    log('Cleared ${snapshot.docs.length} default addresses');
  }

  static Future<bool> chechAddressExist() async {
    final addressDocs = await _addressRef.get();
    return addressDocs.docs.isEmpty;
  }

  static Future<List<AddressModel>> addFirstAddress(
    AddressModel address,
  ) async {
    final addressId = genertateFirebase();
    final updatedAddressModel = address.copyWith(
      id: addressId,
      isDefault: true,
    );
    await _addressRef
        .doc(updatedAddressModel.id)
        .set(updatedAddressModel.toMap());
    final addressList = await AddressService.getAllAddressList();
    return addressList;
  }
}
