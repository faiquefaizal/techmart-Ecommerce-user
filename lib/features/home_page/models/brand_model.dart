import 'package:equatable/equatable.dart';

class BrandModel extends Equatable {
  final String brandUid;
  final String name;
  final String imageUrl;

  BrandModel({
    required this.brandUid,
    required this.name,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {"brandUid": brandUid, "name": name, "imageUrl": imageUrl};
  }

  @override
  List<Object> get props => [brandUid];
  factory BrandModel.fromMap(Map<String, dynamic> map) {
    return BrandModel(
      brandUid: map["brandUid"] ?? '', // Provide default if missing
      name: map["name"] ?? '', // Provide default if missing
      imageUrl: map["imageUrl"] ?? '', // Provide default if missing
    );
  }
}
