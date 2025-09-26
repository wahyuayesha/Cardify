import 'dart:io';

import 'package:cardify/core/error/failures.dart';
import 'package:cardify/features/flashcard/domain/repositories/flashcard_repository.dart';
import 'package:cardify/features/generate_flashcard/domain/repositories/generate_repository.dart';
import 'package:cardify/features/ocr/domain/repository/ocr_repository.dart';
import 'package:dartz/dartz.dart';

class CreateFlashcardImage {
  final GenerateRepository generateRepository;
  final OcrRepository ocrRepository;
  final FlashcardRepository flashcardRepository;

  CreateFlashcardImage({
    required this.generateRepository,
    required this.ocrRepository,
    required this.flashcardRepository,
  });

  Future<Either<Failure, Unit>> call(File imageFile) async {
    // ekstrak teks
    final result = await ocrRepository.extractText(imageFile);
    print('🗒️HASIL OCR: $result');

    return result.fold((failure) => Left(failure), (textContent) async {
      // Validasi panjang note/konten
      if (textContent.length <= 100) {
        return Left(
          ValidationFailure(
            'Note or content must be not least than 100 characters',
          ),
        );
      }

      // generate flashcard pack
      final generateResult = await generateRepository.generateFlashcard(
        textContent,
      );

      return generateResult.fold((failure) => Left(failure), (pack) {
        // Simpan hasil generate ke database
        print('❔PACK: $pack');
        return flashcardRepository.saveFlashcard(pack);
      });
    });
  }
}
