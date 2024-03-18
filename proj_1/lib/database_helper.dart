import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'flashcard.dart';

class DatabaseHelper {
  static Database? _database;
  static const String dbName = 'flashcards.db';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final String path = join(await getDatabasesPath(), dbName);
    return openDatabase(
      path,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE flashcards(id INTEGER PRIMARY KEY AUTOINCREMENT, term TEXT, definition TEXT)',
        );
        await db.execute(
          'CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, email TEXT, password TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertFlashcard(Flashcard flashcard, int setId ) async {
    final Database db = await database;
    await db.insert(
      'flashcards',
      flashcard.toMap(setId),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Flashcard>> getFlashcards() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('flashcards');
    return List.generate(maps.length, (i) {
      return Flashcard(
        id: maps[i]['id'],
        term: maps[i]['term'],
        definition: maps[i]['definition'],
      );
    });
  }

  // Method to register a new user
  Future<void> registerUser(String email, String password) async {
    final Database db = await database;
    await db.insert(
      'users',
      {'email': email, 'password': password},
      conflictAlgorithm: ConflictAlgorithm.ignore, // Handle duplicate emails
    );
  }

  // Method to authenticate a user
  Future<bool> authenticateUser(String email, String password) async {
    final Database db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    return result.isNotEmpty;
  }
}
