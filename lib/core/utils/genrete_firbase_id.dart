import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

String genertateFirebase() {
  final id = FirebaseFirestore.instance.collection("kjl").doc();
  log(id.id ?? "nogentrated");
  return id.id;
}
