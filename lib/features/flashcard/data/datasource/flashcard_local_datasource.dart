// *
// FUNGSI:
// 1. Simpan flashcard hasil api gemini ke database sqflite (return void)
// 2. Ambil flashcard, bisa difilter judul dan urutan tampil (return list model)
// 3. Update kolom flag card tertentu
// 4. Hapus flashcard tertentu
// 5. Edit flashcard (coming soon)
// 6. Buat flashcard sendiri (coming soon)
// *//

import 'package:cardify/features/flashcard/data/datasource/database_service.dart';
import 'package:cardify/features/flashcard/data/models/flashcard_model.dart';
import 'package:cardify/features/flashcard/data/models/pack_model.dart';

class FlashcardLocalDataSource {
  final DatabaseService databaseService;

  FlashcardLocalDataSource({required this.databaseService});

  // SIMPAN PACK & FLASHCARD KE DATABASE
  Future<void> saveFlashcard(PackModel pack) async {
    try {
      final db = await databaseService.database;

      // simpan pack dulu
      final packId = await db.insert('packs', {
        'title': pack.title,
        'description': pack.description,
        'category': pack.category,
        'createdAt': pack.createdAt,
      });

      // simpan setiap flashcards
      for (var flashcard in pack.flashcards) {
        await db.insert('flashcards', {
          'id_pack': packId,
          'front': flashcard.front,
          'back': flashcard.back,
          'flag': flashcard.flag,
        });
      }
    } catch (e) {
      throw Exception('Save new card pack is failed:\n$e');
    }
  }

  // AMBIL PACK & FLASHCARD DARI DATABASE
  Future<List<PackModel>> getFlashcards(String? keyword, String? sortBy) async {
    try {
      final db = await databaseService.database;

      // buat query dasar
      String whereClause = '';
      List<Object?> whereArgs = [];
      String orderBy = 'createdAt DESC'; // default sort

      // filter keyword
      if (keyword != null && keyword.isNotEmpty) {
        whereClause = 'title LIKE ?';
        whereArgs.add('%$keyword%');
      }

      // tentukan sort
      if (sortBy != null && sortBy.isNotEmpty) {
        if (sortBy == 'title') {
          orderBy = 'title ASC';
        } else if (sortBy == 'category') {
          orderBy = 'category ASC';
        }
      }

      // ambil data packs
      final List<Map<String, dynamic>> packMaps = await db.query(
        'packs',
        where: whereClause.isNotEmpty ? whereClause : null,
        whereArgs: whereArgs.isNotEmpty ? whereArgs : null,
        orderBy: orderBy,
      );

      // ubah ke model
      List<PackModel> packs = [];
      for (var packMap in packMaps) {
        // ambil flashcards sesuai pack_id
        final flashcards = await db.query(
          'flashcards',
          where: 'pack_id = ?',
          whereArgs: [packMap['id']],
        );

        packs.add(
          PackModel.fromMap(packMap).copyWith(
            flashcards: flashcards
                .map((f) => FlashcardModel.fromMap(f))
                .toList(),
          ),
        );
      }

      return packs;
    } catch (e) {
      print("error getFlashcards: $e");
      return [];
    }
  }

  // AMBIL FLAG CARD
  Future<int> getFlag(int cardId) async {
    try {
      final db = await databaseService.database;
      final result = await db.query(
        'flashcards',
        columns: ['flag'],
        where: 'id = ?',
        whereArgs: [cardId],
      );
      return result.isNotEmpty ? result.first['flag'] as int : 0;
    } catch (e) {
      throw Exception('Failed to get flag card id $cardId:\n$e');
    }
  }

  // UPDATE FLAG CARD
  Future<void> updateFlag(int cardId, int newValue) async {
    try {
      final db = await databaseService.database;
      await db.update('flashcards', {'flag': newValue});
    } catch (e) {
      throw Exception('Failed to update flag:\n$e');
    }
  }

  // HAPUS CARD
  Future<void> deleteCard(int cardId) async {
    try {
      final db = await databaseService.database;
      await db.delete('flashcards', where: 'id = ?', whereArgs: [cardId]);
    } catch (e) {
      throw Exception('Failed to delete card:\n$e');
    }
  }
}
