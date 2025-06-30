class ResponseModel {
  String brandName;
  String modelName;
  String catagory;
  ResponseModel({
    required this.brandName,
    required this.catagory,
    required this.modelName,
  });
  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      brandName: json["brand"] ?? "",
      catagory: json["category"] ?? "",
      modelName: json["model"] ?? "",
    );
  }
  String get safeBrand =>
      (brandName.toLowerCase() == 'unknown') ? '' : brandName;

  String get safeModel =>
      (modelName.toLowerCase() == 'unknown') ? '' : modelName;

  String get safeCategory =>
      (catagory.toLowerCase() == 'unknown') ? '' : catagory;
}
