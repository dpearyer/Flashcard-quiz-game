import 'package:sqflite/sqflite.dart';
import 'flashcard.dart';
import 'package:path/path.dart';


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
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE flashcards(id INTEGER PRIMARY KEY AUTOINCREMENT, term TEXT, definition TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertFlashcard(Flashcard flashcard, int setId) async {
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
        definition: maps[i]['definition'], title: '',
        setId: maps[i]['setId']
      );
    });
  }

  Future<void> deleteSet(Flashcard set) async {
    final Database db = await database;
    await db.delete(
      'flashcard_sets',
      where: 'id = ?',
      whereArgs: [set.id],
    );

    // Delete associated flashcards of the set
    await db.delete(
      'flashcards',
      where: 'set_id = ?',
      whereArgs: [set.id],
    );
  }


  Future<void> insertSet(Flashcard set, int setId) async {
    await _database?.insert(
      'flashcard_sets',
      set.toMap(setId),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

    Future<void> updateFlashcard(Flashcard flashcard, int setId) async {
    await _database?.update(
      'flashcards',
      flashcard.toMap(setId),
      where: 'id = ?',
      whereArgs: [flashcard.id],
    );
  }

}
