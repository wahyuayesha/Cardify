import 'dart:convert';
import 'package:cardify/features/flashcard/data/models/flashcard_model.dart';
import 'package:cardify/features/flashcard/data/models/pack_model.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class FlashcardRemoteDataSource {
  final GenerativeModel generativeModel;

  FlashcardRemoteDataSource({required this.generativeModel});

  Future<PackModel> createFlashcard(String content) async {
    final response = await generativeModel.generateContent([
      Content.text('''
      Create a flashcard pack in valid JSON format with the following structure:
      {
        "title": "pack title",
        "description": "a short description of the pack",
        "category": "pack category (e.g., mathematics, coding, chemistry, etc.)",
        "flashcards": [
          {
            "front": "question or prompt",
            "back": "answer"
          }
        ]
      }

      Content: "$content"
      
      Make sure the output is **only valid JSON** with no extra explanation.  
      The number of flashcards should be between 15 and 25 depending on the content.  
      Match the language of the pack and flashcards with the language used in the content.
      '''),
    ]);

    final generated = response.text;
    if (generated == null || generated.isEmpty) {
      throw Exception("Response is empty");
    }

    try {
      final Map<String, dynamic> json = jsonDecode(generated);

      final flashcards = (json['flashcards'] as List<dynamic>)
          .map((item) => FlashcardModel.fromMap(item))
          .toList();

      final pack = PackModel(
        title: json['title'],
        description: json['description'],
        category: json['category'],
        createdAt: DateTime.now().toIso8601String(),
        flashcards: flashcards,
      );

      return pack;
    } catch (e) {
      throw Exception("Failed to parse JSON: $e\n\n$generated");
    }
  }
}
