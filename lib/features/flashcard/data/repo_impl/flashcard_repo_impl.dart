import 'package:cardify/core/error/failures.dart';
import 'package:cardify/features/flashcard/data/datasource/flashcard_local_datasource.dart';
import 'package:cardify/features/flashcard/data/models/pack_model.dart';
import 'package:cardify/features/flashcard/domain/entities/pack_entity.dart';
import 'package:cardify/features/flashcard/domain/repositories/flashcard_repository.dart';
import 'package:dartz/dartz.dart';

class FlashcardRepoImpl implements FlashcardRepository {
  final FlashcardLocalDataSource localDataSource;

  FlashcardRepoImpl({required this.localDataSource});

  //simpan flashcard
  @override
  Future<Either<Failure, Unit>> saveFlashcard(PackEntity pack) async {
    try {
      // convert entity ke model untuk dibawa ke data layer
      final model = PackModel.fromEntity(pack);
      // save flashcard
      await localDataSource.saveFlashcard(model);
      return Right(unit);
    } catch (e) {
      return Left(CacheFailure('$e'));
    }
  }

  // ambil flashcard
  @override
  Future<Either<Failure, List<PackEntity>>> getFlashcards(
    String? keyword,
    String sortBy,
  ) async {
    try {
      final packs = await localDataSource.getFlashcards(keyword, sortBy);
      final packsEntity = packs.map((p) => p.toEntity()).toList();
      return Right(packsEntity);
    } catch (e) {
      return Left(CacheFailure('$e'));
    }
  }

  // delete flashcard
  @override
  Future<Either<Failure, Unit>> deleteFlashcard(int packId) async {
    try {
      await localDataSource.deleteCard(packId);
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure('$e'));
    }
  }

  // get flag
  @override
  Future<Either<Failure, int>> getFlag(int cardId) async {
    try {
      final flag = await localDataSource.getFlag(cardId);
      return Right(flag);
    } catch (e) {
      return Left(CacheFailure('$e'));
    }
  }

  // update flag
  @override
  Future<Either<Failure, Unit>> updateFlag(int cardId, int newValue) async {
    try {
      await localDataSource.updateFlag(cardId, newValue);
      return Right(unit);
    } catch (e) {
      return Left(CacheFailure('$e'));
    }
  }
}
