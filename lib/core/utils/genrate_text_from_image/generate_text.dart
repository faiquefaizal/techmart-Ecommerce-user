import 'dart:developer';

import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import 'package:techmart/core/utils/pick_image/image_picker.dart';

Future<String?> generateText() async {
  String? pickedImage = await pickImage();
  if (pickedImage != null) {
    InputImage inputImage = InputImage.fromFilePath(pickedImage);
    TextRecognizer textRecognizer = TextRecognizer();
    RecognizedText recognizedText = await textRecognizer.processImage(
      inputImage,
    );
    textRecognizer.close();
    log(recognizedText.text);
    return recognizedText.text;
  }
  return null;
}
