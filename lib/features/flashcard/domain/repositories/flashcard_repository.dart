import 'package:cardify/core/error/failures.dart';
import 'package:cardify/features/flashcard/data/models/pack_model.dart';
import 'package:dartz/dartz.dart';

abstract class FlashcardRepository {
  // // remote
  // Future<Either<Failure, String>> generateFlashcard(String topic);

  // // local
  // Future<Either<Failure, Unit>> saveFlashcard(
  //   String title,
  //   String description,
  //   String category,
  // );

  Future<Either<Failure, Unit>> saveFlashcard(PackModel pack);
  Future<Either<Failure, List<PackModel>>> getFlashcards(
    String? keyword,
    String? sortBy,
  );
  Future<Either<Failure, int>> getFlag(int cardId);
  Future<Either<Failure, Unit>> updateFlag(int cardId, int newValue);
  Future<Either<Failure, Unit>> deleteFlashcard(int cardId);
}
