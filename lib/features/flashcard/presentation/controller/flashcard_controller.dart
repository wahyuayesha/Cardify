import 'package:cardify/features/flashcard/domain/entities/flashcard_entity.dart';
import 'package:cardify/features/flashcard/domain/entities/pack_entity.dart';
import 'package:cardify/features/flashcard/domain/usecases/delete_flashcard.dart';
import 'package:cardify/features/flashcard/domain/usecases/get_flag.dart';
import 'package:cardify/features/flashcard/domain/usecases/get_flashcards.dart';
import 'package:cardify/features/flashcard/domain/usecases/update_flag.dart';
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

  var isLoading = false.obs;
  var errormessage = ''.obs;

  var sortBy = 'created'.obs;
  var keywords = ''.obs;

  // Method untuk menghitung flagged cards dalam satu pack
  int getFlaggedCountForPackById(int packId) {
    // Cari pack terbaru dari userPacks atau recentPacks
    final pack =
        userPacks.firstWhereOrNull((p) => p.id == packId) ??
        recentPacks.firstWhereOrNull((p) => p.id == packId);

    if (pack == null) return 0;

    return pack.flashcards.where((card) => card.flag == 1).length;
  }

  FlashcardEntity? findCardById(int id) {
    for (final pack in [...userPacks, ...recentPacks]) {
      for (final card in pack.flashcards) {
        if (card.id == id) return card;
      }
    }
    print(
      '⚠️ [DEBUG] Card id=$id tidak ditemukan di userPacks maupun recentPacks',
    );
    return null;
  }

  // AMBIL KARTU USER (TERPENGARUH FILTER)
  Future<void> getUserFlashcards() async {
    isLoading.value = true;
    errormessage.value = '';
    final response = await getFlashcards(keywords.value, sortBy.value);
    response.fold(
      (failure) {
        errormessage.value = failure.message;
      },
      (packs) {
        print('📚 CARD PACKS : ${packs.length}');
        userPacks.value = packs;
      },
    );
    isLoading.value = false;
  }

  // AMBIL PACK KARTU USER (URUT BERDASAR WAKTU DIBUAT)
  Future<void> getRecentUserFlashcards() async {
    isLoading.value = true;
    errormessage.value = '';
    final response = await getFlashcards('', 'created');
    response.fold(
      (failure) => errormessage.value = failure.message,
      (packs) => recentPacks.value = packs,
    );
    isLoading.value = false;
  }

  // HAPUS PACK KARTU TERTENTU
  Future<void> deleteFlashcardsPack(int packId) async {
    isLoading.value = true;
    errormessage.value = '';
    final response = await deleteFlashcard(packId);
    response.fold(
      (failure) => errormessage.value = failure.message,
      (unit) => unit,
    );
    await getUserFlashcards();
    await getRecentUserFlashcards();
    isLoading.value = false;
  }

  // TOGGLE FLAG KARTU TERTENTU
  Future<void> toggleFlag(int cardId) async {
    // Cari current flag
    int? currentFlag;

    try {
      currentFlag = userPacks
          .expand((p) => p.flashcards)
          .firstWhere((c) => c.id == cardId)
          .flag;
    } catch (e) {
      try {
        currentFlag = recentPacks
            .expand((p) => p.flashcards)
            .firstWhere((c) => c.id == cardId)
            .flag;
      } catch (e) {
        print('Card dengan id=$cardId tidak ditemukan');
        return;
      }
    }

    final newFlag = currentFlag == 1 ? 0 : 1;

    // Update ke database
    final result = await updateFlag(cardId, newFlag);

    result.fold((failure) => errormessage.value = failure.message, (_) {
      // Update userPacks
      final updatedUserPacks = userPacks.map((pack) {
        final updatedCards = pack.flashcards.map((card) {
          return card.id == cardId ? card.copyWith(flag: newFlag) : card;
        }).toList();
        return pack.copyWith(flashcards: updatedCards);
      }).toList();

      // Update recentPacks
      final updatedRecentPacks = recentPacks.map((pack) {
        final updatedCards = pack.flashcards.map((card) {
          return card.id == cardId ? card.copyWith(flag: newFlag) : card;
        }).toList();
        return pack.copyWith(flashcards: updatedCards);
      }).toList();

      // Apply perubahan
      userPacks.assignAll(updatedUserPacks);
      recentPacks.assignAll(updatedRecentPacks);

      update();
    });
  }
}
