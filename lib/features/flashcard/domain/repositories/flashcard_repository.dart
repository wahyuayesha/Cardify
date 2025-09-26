import 'package:cardify/core/error/failures.dart';
import 'package:cardify/features/flashcard/domain/entities/pack_entity.dart';
import 'package:dartz/dartz.dart';

abstract class FlashcardRepository {
  Future<Either<Failure, Unit>> saveFlashcard(PackEntity pack);
  Future<Either<Failure, List<PackEntity>>> getFlashcards(
    String? keyword,
    String? sortBy,
  );
  Future<Either<Failure, int>> getFlag(int cardId);
  Future<Either<Failure, Unit>> updateFlag(int cardId, int newValue);
  Future<Either<Failure, Unit>> deleteFlashcard(int cardId);
}
