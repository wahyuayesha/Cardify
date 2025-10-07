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

  FlashcardEntity copyWith({String? front, String? back, int? flag}) {
    return FlashcardEntity(
      id: id,
      front: front ?? this.front,
      back: back ?? this.back,
      flag: flag ?? this.flag,
    );
  }
}
