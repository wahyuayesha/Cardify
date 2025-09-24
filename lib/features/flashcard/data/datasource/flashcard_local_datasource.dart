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

class FlashcardLocalDataSource {
  final DatabaseService databaseService;

  FlashcardLocalDataSource({required this.databaseService});

  
}
