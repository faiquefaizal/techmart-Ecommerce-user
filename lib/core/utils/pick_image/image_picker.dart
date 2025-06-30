import 'package:image_picker/image_picker.dart';

Future<String?> pickImage() async {
  final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
  return pickedImage?.path;
}
