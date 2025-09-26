import 'package:cardify/core/error/failures.dart';
import 'package:cardify/features/flashcard/domain/repositories/flashcard_repository.dart';
import 'package:cardify/features/generate_flashcard/domain/repositories/generate_repository.dart';
import 'package:dartz/dartz.dart';

class CreateFlashcardText {
  final GenerateRepository generateRepository;
  final FlashcardRepository flashcardRepository;

  CreateFlashcardText({
    required this.generateRepository,
    required this.flashcardRepository,
  });

  Future<Either<Failure, Unit>> call(String content) async {
    // Validasi panjang note/konten
    if (content.length <= 100) {
      return Left(
        ValidationFailure(
          'Note or content must be not least than 100 characters',
        ),
      );
    }

    // Generate flashcard
    final generateResult = await generateRepository.generateFlashcard(content);

    return generateResult.fold((failure) => Left(failure), (pack) async {
      // Simpan hasil generate ke database
      print('❔PACK: $pack');
      return await flashcardRepository.saveFlashcard(pack);
    });
  }
}
