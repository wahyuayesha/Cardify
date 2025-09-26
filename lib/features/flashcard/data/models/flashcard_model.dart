import 'package:cardify/features/flashcard/domain/entities/flashcard_entity.dart';

class FlashcardModel {
  final int? id;       
  final String front;
  final String back;
  final int flag;       // default 0 artinya belum diflag
  final int? idPack;    

  FlashcardModel({
    this.id,
    required this.front,
    required this.back,
    this.flag = 0,
    this.idPack,
  });

  factory FlashcardModel.fromMap(Map<String, dynamic> map) {
    return FlashcardModel(
      id: map['id'],
      front: map['front'],
      back: map['back'],
      flag: map['flag'] ?? 0,
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

  // konversi model -> entity
  FlashcardEntity toEntity() {
    return FlashcardEntity(
      id: id ?? 0, // default 0 kalau belum ada id
      front: front,
      back: back,
      flag: flag,
    );
  }

  // konversi entity -> model (kalau butuh simpan lagi ke DB)
  factory FlashcardModel.fromEntity(FlashcardEntity entity, {int? idPack}) {
    return FlashcardModel(
      id: entity.id == 0 ? null : entity.id, // null biar auto-increment di DB
      front: entity.front,
      back: entity.back,
      flag: entity.flag,
      idPack: idPack,
    );
  }
}
