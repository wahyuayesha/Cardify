import 'package:cardify/core/error/failures.dart';
import 'package:cardify/features/flashcard/data/models/pack_model.dart';
import 'package:dartz/dartz.dart';

abstract class GenerateRepository {
  Future<Either<Failure, PackModel>> generateFlashcard(String content);
}
