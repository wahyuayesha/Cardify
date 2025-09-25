import 'package:cardify/core/error/failures.dart';
import 'package:cardify/features/flashcard/data/models/pack_model.dart';
import 'package:cardify/features/generate_flashcard/data/datasource/generate_remote_datasource.dart';
import 'package:cardify/features/generate_flashcard/domain/repositories/generate_repository.dart';
import 'package:dartz/dartz.dart';

class GenerateRepoImpl implements GenerateRepository {
  final GenerateRemoteDatasource remoteDatasource;

  GenerateRepoImpl({required this.remoteDatasource});

  @override
  Future<Either<Failure, PackModel>> generateFlashcard(String content) async {
    try {
      final pack = await remoteDatasource.generateFlashcard(content);
      return Right(pack);
    } catch (e) {
      return Left(ServerFailure('$e'));
    }
  }
}
