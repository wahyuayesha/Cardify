import 'package:cardify/features/flashcard/data/models/flashcard_model.dart';
import 'package:cardify/features/flashcard/domain/entities/pack_entity.dart';

class PackModel {
  final int? id;
  final String? title;
  final String? description;
  final String? category;
  final String? createdAt;
  final String? origin;
  final List<FlashcardModel> flashcards;

  PackModel({
    this.id,
    this.title,
    this.description,
    this.category,
    this.createdAt,
    this.origin,
    this.flashcards = const [],
  });

  factory PackModel.fromMap(Map<String, dynamic> map) {
    return PackModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      category: map['category'],
      createdAt: map['createdAt'],
      origin: map['origin'],
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
      'origin': origin,
      'flashcards': flashcards.map((f) => f.toMap()).toList(),
    };
  }

  PackModel copyWith({
    int? id,
    String? title,
    String? description,
    String? category,
    String? createdAt,
    String? origin,
    List<FlashcardModel>? flashcards,
  }) {
    return PackModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
      origin: origin ?? this.origin,
      flashcards: flashcards ?? this.flashcards,
    );
  }

  PackEntity toEntity() {
    return PackEntity(
      id: id ?? 0,
      title: title ?? '',
      description: description ?? '',
      category: category ?? '',
      createdAt: DateTime.tryParse(createdAt ?? '') ?? DateTime.now(),
      origin: origin ?? '',
      flashcards: flashcards
          .map((f) => f.toEntity())
          .toList(), // ✅ map flashcards
    );
  }

  static PackModel fromEntity(PackEntity entity) {
    return PackModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      category: entity.category,
      createdAt: entity.createdAt.toIso8601String(),
      origin: entity.origin,
      flashcards: entity.flashcards
          .map((f) => FlashcardModel.fromEntity(f))
          .toList(), // ✅ map flashcards
    );
  }
}
