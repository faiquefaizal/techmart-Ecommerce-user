import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class ReturnService {
  final CollectionReference _orderRef = FirebaseFirestore.instance.collection(
    "Orders",
  );

  Future<void> requestReturn(String id, String reason) async {
    try {
      await _orderRef.doc(id).update({
        "status": "returnRequest",
        "returnReason": reason,
      });
    } catch (e) {
      log(e.toString());
    }
  }
}
