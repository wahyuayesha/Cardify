class FlashcardEntity {
  final int id;
  final String front;
  final String back;
  final bool isFlagged;

  FlashcardEntity({
    required this.id,
    required this.front,
    required this.back,
    required this.isFlagged,
  });
}
