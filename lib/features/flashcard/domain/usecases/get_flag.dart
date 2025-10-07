import 'package:cardify/core/error/failures.dart';
import 'package:cardify/features/flashcard/domain/repositories/flashcard_repository.dart';
import 'package:dartz/dartz.dart';

class GetFlag {
  final FlashcardRepository flashcardRepository;

  GetFlag({required this.flashcardRepository});

  Future<Either<Failure, int>> call(int cardId) async {
    final response = await flashcardRepository.getFlag(cardId);
    return response.fold((failure) => Left(failure), (flag) => Right(flag));
  }
}
