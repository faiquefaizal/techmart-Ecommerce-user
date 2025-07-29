import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class BannerService {
  static final bannerref = FirebaseFirestore.instance.collection("Banners");
  static Future<List<List<String>>> getAllBaners() async {
    final data = await bannerref.get();
    log("Document count: ${data.docs.length}");

    return data.docs.map((doc) {
      final rawImages = doc.data()["images"];
      log("images type: ${rawImages.runtimeType} => $rawImages");

      return List<String>.from(rawImages ?? []);
    }).toList();
  }
}
