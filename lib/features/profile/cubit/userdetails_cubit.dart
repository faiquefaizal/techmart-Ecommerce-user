import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techmart/features/authentication/model/user_model.dart';
import 'package:techmart/features/authentication/service/Auth_service.dart';

class UserCubit extends Cubit<UserModel?> {
  UserCubit() : super(null);

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? id = AuthService().getUserId();

  Future<void> fetchUser() async {
    try {
      final doc = await _firestore.collection("Users").doc(id).get();
      if (doc.exists) {
        emit(UserModel.fromMap(doc.data()!));
      }
    } catch (e) {
      print("Error fetching user: $e");
    }
  }

  Future<void> updateUser(UserModel user) async {
    try {
      log(user.uid);
      await _firestore.collection("Users").doc(user.uid).update(user.toMap());
      emit(user);
    } catch (e) {
      print("Error updating user: $e");
    }
  }
}
