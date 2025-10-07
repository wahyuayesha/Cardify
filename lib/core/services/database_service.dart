// lib/core/services/database_service.dart
// import yang diperlukan
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Database? _db;

  // public constructor supaya mudah di-inject
  DatabaseService();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _getDatabase();
    return _db!;
  }

  // jika mau pre-initialize, panggil init() dari luar
  Future<void> init() async {
    await database;
  }

  Future<Database> _getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, 'cardify.db');

    final database = await openDatabase(
      databasePath,
      version: 1,
      onConfigure: (db) async {
        // aktifkan foreign keys
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: (db, version) async {
        // parent: packs
        await db.execute('''
          CREATE TABLE packs (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            description TEXT,
            category TEXT,
            createdAt TEXT,
            origin TEXT
          )
        ''');

        // child: flashcards
        await db.execute('''
          CREATE TABLE flashcards (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            id_pack INTEGER,
            front TEXT,
            back TEXT,
            flag INTEGER DEFAULT 0,
            FOREIGN KEY (id_pack) REFERENCES packs (id) ON DELETE CASCADE
          )
        ''');
      },
    );

    return database;
  }
}
