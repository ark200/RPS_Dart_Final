import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Database2Helper {
  static final _databaseName = "game_log.db";
  static final _databaseVersion = 1;

  static final table = 'gamelogs';
  static final id = 'id';
  static final date = 'date';
  static final result = 'result';
  static final myScore = 'my_score';
  static final oppScore = 'opp_score';

  Database2Helper._privateConstructor();
  static final Database2Helper instance = Database2Helper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    // Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $id INTEGER PRIMARY KEY,
        $date INTEGER NOT NULL,
        $result TEXT NOT NULL,
        $myScore INTEGER NOT NULL,
        $oppScore INTEGER NOT NULL
      )
    ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[Database2Helper.id];
    return await db.update(table, row, where: '$id = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$id = ?', whereArgs: [id]);
  }
}