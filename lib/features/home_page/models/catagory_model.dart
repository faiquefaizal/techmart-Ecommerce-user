import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  String categoryuid;
  String name;
  String imageurl;
  List<CatagoryVarient> varientOptions;
  CategoryModel({
    required this.categoryuid,
    required this.imageurl,
    required this.name,
    required this.varientOptions,
  });
  @override
  List<Object> get props => [categoryuid];
  Map<String, dynamic> toMap() {
    return {
      "CatagoryUid": categoryuid,
      "Name": name,
      "imageurl": imageurl,
      "varientOptions": varientOptions.map((e) => e.toMap()).toList(),
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      categoryuid: map["CatagoryUid"],
      imageurl: map["imageurl"],
      name: map["Name"],
      varientOptions:
          (map["varientOptions"] as List<dynamic>)
              .map((e) => CatagoryVarient.fromMap(e as Map<String, dynamic>))
              .toList(),
    );
  }
}

class CatagoryVarient {
  String name;
  List<String> options;
  CatagoryVarient({required this.name, required this.options});

  Map<String, dynamic> toMap() {
    return {"name": name, "options": options};
  }

  factory CatagoryVarient.fromMap(Map<String, dynamic> map) {
    return CatagoryVarient(
      name: map["name"] ?? "",
      options: List<String>.from(map["options"] ?? []),
    );
  }
}
