// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService _instance = DatabaseService._constructor();

  DatabaseService._constructor();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, 'cardify.db');
    final database = await openDatabase(
      databasePath,
      onCreate: (db, version) async {
        // parent: packs
        await db.execute('''
          CREATE TABLE packs (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            description TEXT
            category TEXT,
            createdAt TEXT,
          )
        ''');

        // child: flashcards
        await db.execute('''
          CREATE TABLE flashcards (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            id_pack INTEGER,
            front TEXT,
            back TEXT,
            flag INTEGER DEFAULT 0,,
            FOREIGN KEY (id_pack) REFERENCES packs (id) ON DELETE CASCADE
          )
        ''');
      },
    );
    return database;
  }
}
