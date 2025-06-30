import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:techmart/core/utils/pick_image/image_picker.dart';
import 'package:techmart/core/widgets/snakbar_widgert.dart';
import 'package:techmart/features/home_page/features/visual_search/model/response_model.dart';

Future<ResponseModel?> runVisualSearch() async {
  final gemini = Gemini.instance;

  final image = await pickImageAsByte();
  if (image != null) {
    final respose = await gemini.prompt(
      parts: [
        Part.text('''
From this product image, extract the following fields and return only this JSON format:

{
  "brand": "Brand Name",
  "model": "Model Name",
  "category": "Product Category"
}
'''),

        Part.inline(
          InlineData(data: base64Encode(image), mimeType: "image/jpeg"),
        ),
      ],
    );

    final output = respose?.output;
    if (output != null) {
      try {
        log(output);
        final jsonStart = output.indexOf("{");
        final jsonEnd = output.lastIndexOf("}");
        final json = output.substring(jsonStart, jsonEnd + 1);
        final jsonText = jsonDecode(json);
        final searchModel = ResponseModel.fromJson(jsonText);
        log(jsonText.toString());
        return searchModel;
      } catch (e) {
        log(" JSON parse failed: $e");
      }
    } else {
      log(" No response from Gemini.");
    }
  }
}
