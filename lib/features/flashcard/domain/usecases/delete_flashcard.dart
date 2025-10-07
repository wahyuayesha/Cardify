import 'package:cardify/core/error/failures.dart';
import 'package:cardify/features/flashcard/domain/repositories/flashcard_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteFlashcard {
  final FlashcardRepository flashcardRepository;

  DeleteFlashcard({required this.flashcardRepository});

  Future<Either<Failure, Unit>> call(int packId) async {
    final response = await flashcardRepository.deleteFlashcard(packId);
    return response.fold((failure) => Left(failure), (unit) => Right(unit));
  }
}
