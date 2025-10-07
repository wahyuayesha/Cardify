import 'package:cardify/core/error/failures.dart';
import 'package:cardify/features/flashcard/domain/entities/pack_entity.dart';
import 'package:cardify/features/flashcard/domain/repositories/flashcard_repository.dart';
import 'package:dartz/dartz.dart';

class GetFlashcards {
  final FlashcardRepository flashcardRepository;

  GetFlashcards({required this.flashcardRepository});

  Future<Either<Failure, List<PackEntity>>> call(
    String? keyword,
    String sortBy,
  ) async {
    final response = await flashcardRepository.getFlashcards(keyword, sortBy);
    return response.fold((failure) => Left(failure), (packs) => Right(packs));
  }
}
