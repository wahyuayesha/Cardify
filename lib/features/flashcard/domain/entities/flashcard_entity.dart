class FlashcardEntity {
  final int? id;
  final String front;
  final String back;
  final int flag;

  FlashcardEntity({
    this.id,
    required this.front,
    required this.back,
    this.flag = 0,
  });
}