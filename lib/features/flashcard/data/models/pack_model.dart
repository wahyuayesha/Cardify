import 'package:cardify/features/flashcard/data/models/flashcard_model.dart';

class PackModel {
  final int? id;
  final String title;
  final String? description;
  final String? category;
  final String? createdAt;
  final List<FlashcardModel> flashcards;

  PackModel({
    this.id,
    required this.title,
    this.description,
    this.category,
    this.createdAt,
    this.flashcards = const [],
  });

  factory PackModel.fromMap(Map<String, dynamic> map) {
    return PackModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      category: map['category'],
      createdAt: map['createdAt'],
      flashcards: (map['flashcards'] as List<dynamic>? ?? [])
          .map((f) => FlashcardModel.fromMap(f))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'createdAt': createdAt,
      'flashcards': flashcards.map((f) => f.toMap()).toList(),
    };
  }

  PackModel copyWith({
    int? id,
    String? title,
    String? description,
    String? category,
    String? createdAt,
    List<FlashcardModel>? flashcards,
  }) {
    return PackModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
      flashcards: flashcards ?? this.flashcards,
    );
  }
}
