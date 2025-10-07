import 'package:cardify/core/functions/json_parser.dart';
import 'package:cardify/features/flashcard/data/models/flashcard_model.dart';
import 'package:cardify/features/flashcard/data/models/pack_model.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GenerateRemoteDatasource {
  final GenerativeModel generativeModel;

  GenerateRemoteDatasource({required this.generativeModel});

  Future<PackModel> generateFlashcard(String content) async {
    // generate json flashcards
    final response = await generativeModel.generateContent([
      Content.text('''
      Create a flashcard pack in valid JSON format with the following structure:
      {
        "title": "short pack title",
        "description": "a realy short description of the pack",
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
    
    // validasi hasil
    final generated = response.text;
    if (generated == null || generated.isEmpty) {
      throw Exception("Response is empty");
    }
    
    try {
      // bersihkan hasil generate dari ('''json)
      final Map<String, dynamic> json = parseCleanJson(generated);

      // convert json flashcards ke flashcard model
      final flashcards = (json['flashcards'] as List<dynamic>)
          .map((item) => FlashcardModel.fromMap(item))
          .toList();

      // convert json pack ke pack model
      final pack = PackModel(
        title: json['title'],
        description: json['description'],
        category: json['category'],
        createdAt: DateTime.now().toIso8601String(),
        flashcards: flashcards, // simpan flashcards model
        origin: content // simpan konten/note asli
      );
      
      return pack;
    } catch (e) {
      throw Exception("Failed to parse JSON: $e\n\n$generated");
    }
  }
}
