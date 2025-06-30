import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

Future<String?> pickImage() async {
  final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
  return pickedImage?.path;
}

Future<Uint8List?> pickImageAsByte() async {
  final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
  return await pickedImage?.readAsBytes();
}
