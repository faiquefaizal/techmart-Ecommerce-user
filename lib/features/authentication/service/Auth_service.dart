import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:techmart/features/authentication/service/model/user_model.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  Future<bool> checkUserLogedIn() async {
    try {
      final sharedprec = await SharedPreferences.getInstance();
      if (sharedprec.getBool("_isfirstTIme") != true ||
          sharedprec.getBool("_isfirstTIme") == null) {
        sharedprec.setBool("_isfirstTIme", true);
      }
      return false;
    } catch (e) {
      log(e.toString());
    }
    return true;
  }

  Future<bool> checkUser() async {
    await Future.delayed(Duration(seconds: 2));
    User? logincheck = auth.currentUser;
    log("$logincheck");
    if (logincheck != null) {
      return true;
    }

    return false;
  }

  String? getUserId() {
    try {
      User? user = auth.currentUser;
      if (user != null) {
        return user.uid;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<String?> registerUser({
    required String name,
    required String passord,
    required String dob,
    required String email,
    required String gender,
    required String phone,
  }) async {
    try {
      final UserCredential currentuser = await auth
          .createUserWithEmailAndPassword(email: email, password: passord);
      UserModel newUser = UserModel(
        name: name,
        passord: passord,
        dob: dob,
        email: email,
        gender: gender,
        phone: phone,
        uid: currentuser.user!.uid,
      );
      await db.collection("Users").doc(newUser.uid).set(newUser.toMap());
      return currentuser.user!.uid;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<String?> signInUser({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential currentUser = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return currentUser.user!.uid;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  void signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
