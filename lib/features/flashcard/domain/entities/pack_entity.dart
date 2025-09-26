import 'package:cardify/features/flashcard/domain/entities/flashcard_entity.dart';

class PackEntity {
  final int id;
  final String title;
  final String description;
  final String category;
  final DateTime createdAt;
  final String origin;
  final List<FlashcardEntity> flashcards; 

  PackEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.createdAt,
    required this.origin,
    this.flashcards = const [], // default kosong
  });
}
