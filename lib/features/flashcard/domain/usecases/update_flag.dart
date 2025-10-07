import 'package:cardify/core/error/failures.dart';
import 'package:cardify/features/flashcard/domain/repositories/flashcard_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateFlag {
  final FlashcardRepository flashcardRepository;

  UpdateFlag({required this.flashcardRepository});
  
  Future<Either<Failure, Unit>> call(int cardId, int newValue) async {
    final response = await flashcardRepository.updateFlag(cardId, newValue);
    return response.fold((failure) => Left(failure), (unit) => Right(unit));
  }
}
