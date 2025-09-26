import 'package:cardify/core/error/failures.dart';
import 'package:cardify/features/flashcard/domain/entities/pack_entity.dart';
import 'package:dartz/dartz.dart';

abstract class GenerateRepository {
  Future<Either<Failure, PackEntity>> generateFlashcard(String content);
}
