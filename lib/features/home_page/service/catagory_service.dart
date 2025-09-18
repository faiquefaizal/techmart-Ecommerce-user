import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techmart/features/cart/bloc/cart_bloc.dart';
import 'package:techmart/features/home_page/models/catagory_model.dart';

class CatagoryService {
  CollectionReference catagoryRef = FirebaseFirestore.instance.collection(
    "Catagory",
  );

  Stream<List<CategoryModel>> fetchCatagories() {
    return catagoryRef.snapshots().map(
      (snap) =>
          snap.docs
              .map(
                (doc) =>
                    CategoryModel.fromMap(doc.data() as Map<String, dynamic>),
              )
              .toList(),
    );
  }

  Future<String> getFirstCat() async {
    final cat = await catagoryRef.get();
    return cat.docs
        .map((doc) => CategoryModel.fromMap(doc.data() as Map<String, dynamic>))
        .first
        .categoryuid;
  }
}
