class FlashcardModel {
  final int id;
  final String front;
  final String back;
  final int flag;
  final int idPack;

  FlashcardModel({
    required this.id,
    required this.front,
    required this.back,
    required this.flag,
    required this.idPack,
  });

  factory FlashcardModel.fromMap(Map<String, dynamic> map) {
    return FlashcardModel(
      id: map['id'],
      front: map['front'],
      back: map['back'],
      flag: map['flag'],
      idPack: map['id_pack'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'front': front,
      'back': back,
      'flag': flag,
      'id_pack': idPack,
    };
  }

  FlashcardModel copyWith({
    int? id,
    String? front,
    String? back,
    int? flag,
    int? idPack,
  }) {
    return FlashcardModel(
      id: id ?? this.id,
      front: front ?? this.front,
      back: back ?? this.back,
      flag: flag ?? this.flag,
      idPack: idPack ?? this.idPack,
    );
  }
}
