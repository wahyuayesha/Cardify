
import 'package:cardify/core/error/failures.dart';
import 'package:cardify/features/flashcard/domain/entities/pack_entity.dart';
import 'package:cardify/features/flashcard/domain/usecases/delete_flashcard.dart';
import 'package:cardify/features/flashcard/domain/usecases/get_flag.dart';
import 'package:cardify/features/flashcard/domain/usecases/get_flashcards.dart';
import 'package:cardify/features/flashcard/domain/usecases/update_flag.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

class FlashcardController extends GetxController {
  final DeleteFlashcard deleteFlashcard;
  final GetFlashcards getFlashcards;
  final GetFlag getFlag;
  final UpdateFlag updateFlag;

  FlashcardController({
    required this.deleteFlashcard,
    required this.getFlashcards,
    required this.getFlag,
    required this.updateFlag,
  });

  var userPacks = RxList<PackEntity>();

 var recentPacks = RxList<PackEntity>();


  bool isLoading = false;
  String? errormessage = '';

  String sortBy = 'created';
  String keywords = '';

  Future<void> getUserFlashcards() async {
    isLoading = true;
    errormessage = '';
    final response = await getFlashcards(keywords, sortBy);
    response.fold((failure) => errormessage = failure.message, (packs) {
      print('📚 CARD PACKS : ${packs.length}');
      userPacks.value = packs;
    });

    isLoading = false;
  }

  Future<void> getRecentUserFlashcards() async {
    isLoading = true;
    errormessage = '';
    final response = await getFlashcards('', 'created');
    response.fold(
      (failure) => errormessage = failure.message,
      (packs) => recentPacks.value = packs,
    );
    isLoading = false;
  }

  Future<void> deleteFlashcardsPack(int packId) async {
    isLoading = true;
    errormessage = '';
    final response = await deleteFlashcard(packId);
    response.fold((failure) => errormessage = failure.message, (unit) => unit);
    await getUserFlashcards();
    await getRecentUserFlashcards();
    isLoading = false;
  }

  Future<Either<Failure, int>> getCardFlag(int cardId) async {
    isLoading = true;
    errormessage = '';

    final response = await getFlag(cardId);

    // supaya isLoading false tetap jalan, jangan return langsung fold
    final Either<Failure, int> result = response.fold((failure) {
      errormessage = failure.message;
      return Left(failure);
    }, (flag) => Right(flag));

    isLoading = false;
    return result;
  }

  Future<void> updateCardFlag(int cardId, int newValue) async {
    isLoading = true;
    errormessage = '';
    final response = await updateFlag(cardId, newValue);

    response.fold((failure) => errormessage = failure.message, (_) {
      // Update data di variabel
      userPacks.value = userPacks.map((pack) {
        final updatedFlashcards = pack.flashcards.map((card) {
          return card.id == cardId ? card.copyWith(flag: newValue) : card;
        }).toList();
        return pack.copyWith(flashcards: updatedFlashcards);
      }).toList();

      recentPacks.value = recentPacks.map((pack) {
        final updatedFlashcards = pack.flashcards.map((card) {
          return card.id == cardId ? card.copyWith(flag: newValue) : card;
        }).toList();
        return pack.copyWith(flashcards: updatedFlashcards);
      }).toList();
    });
    isLoading = false;
  }

  Future<void> toggleFlag(int cardId) async {
    isLoading = true;
    errormessage = '';

    final response = await getCardFlag(cardId);

    response.fold((failure) => errormessage = failure.message, (flag) async {
      final newflag = flag == 0 ? 1 : 0;
      print('🚩 Flag di rubah dari $flag menjadi $newflag');
      await updateCardFlag(cardId, newflag);
    });
    isLoading = false;
  }
}
