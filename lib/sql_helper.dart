import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'my_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS my_table (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        rollNo TEXT,
        branch TEXT,
        marks INTEGER,
        dob TEXT
      )
    ''');
  }

  Future<int> insertRecord(Map<String, dynamic> record) async {
    final db = await database;
    return await db.insert('my_table', record);
  }

  Future<List<Map<String, dynamic>>> getAllRecords() async {
    final db = await database;
    return await db.query('my_table');
  }

  Future<int> updateRecord(Map<String, dynamic> record) async {
    final db = await database;
    return await db
        .update('my_table', record, where: 'id = ?', whereArgs: [record['id']]);
  }

  Future<int> deleteRecord(int id) async {
    final db = await database;
    return await db.delete('my_table', where: 'id = ?', whereArgs: [id]);
  }
}
