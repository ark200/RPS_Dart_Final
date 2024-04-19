import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'user_db.db');
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY,
        username TEXT,
        password TEXT
      )
    ''');
  }

  Future<int> insertUser(Map<String, dynamic> user, String password) async {
    Database db = await database;
    return await db.insert('users', user);
  }

  Future<bool> isUsernameTaken(String username) async{
    Database db = await instance.database;
    List<Map<String, dynamic>> result = await db.query('useres',
      where: 'username = ?',
      whereArgs: [username],);
    return result.isNotEmpty;
  }

  Future<List<Map<String, dynamic>>> getUser(String username, String password) async {
    Database db = await database;
    return await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );
  }
}