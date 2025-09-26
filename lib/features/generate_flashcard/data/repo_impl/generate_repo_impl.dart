import 'package:cardify/core/error/failures.dart';
import 'package:cardify/features/flashcard/data/models/pack_model.dart';
import 'package:cardify/features/flashcard/domain/entities/pack_entity.dart';
import 'package:cardify/features/generate_flashcard/data/datasource/generate_remote_datasource.dart';
import 'package:cardify/features/generate_flashcard/domain/repositories/generate_repository.dart';
import 'package:dartz/dartz.dart';

class GenerateRepoImpl implements GenerateRepository {
  final GenerateRemoteDatasource remoteDatasource;

  GenerateRepoImpl({required this.remoteDatasource});

  @override
  Future<Either<Failure, PackEntity>> generateFlashcard(String content) async {
    try {
      // generate
      final PackModel pack = await remoteDatasource.generateFlashcard(content);
      // convert model ke entity
      final PackEntity entityPack = pack.toEntity();
      return Right(entityPack);
    } catch (e) {
      return Left(ServerFailure('$e'));
    }
  }
}
