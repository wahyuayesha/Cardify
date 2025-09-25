import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class OcrLocalDatasource {
  final textRecognizer = TextRecognizer();

   // Ekstrak gambar menjadi teks
  Future<String> extractText(File imageFile) async {
    try {
      final inputImage = InputImage.fromFile(imageFile);
      final recognizedText = await textRecognizer.processImage(inputImage);
      return recognizedText.text;
    } catch (e) {
      throw Exception('Failed to scan the image:\n$e');
    }
  }
}
