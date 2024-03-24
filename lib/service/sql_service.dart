import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite2/model/model.dart';

class DatabaseService {
  // Singleton pattern
  static final DatabaseService _databaseService = DatabaseService._internal();
  factory DatabaseService() => _databaseService;
  DatabaseService._internal();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    // Initialize the DB first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();

    final path = join(databasePath, 'todoapp.db');

    return await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
    );
  }

  static Future<void> _onCreate(Database db, int version) async {
    // Run the CREATE {dogs} TABLE statement on the database.
    await db.execute(
      'CREATE TABLE ToDoList(id INTEGER PRIMARY KEY, title TEXT, detail TEXT, date TEXT )',
    );
  }

  static Future<dynamic> insertToDoList({required ToDoModel todomodel}) async {
    final db = await _databaseService.database;
    await db.insert(
      'ToDoList',
      todomodel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<ToDoModel>> getToDoList() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query('ToDoList');
    return List.generate(maps.length, (i) {
      return ToDoModel(
        id: maps[i]['id'] as int,
        title: maps[i]['title'] as String,
        detail: maps[i]['detail'] as String,
        date: DateTime.parse(maps[i]['date']),
      );
    }
        //  =>
        // ToDoModel.fromMap(maps[index]),
        );
  }

  static Future<void> updateToDoList({required ToDoModel todomodel}) async {
    final db = await _databaseService.database;
    await db.update('ToDoList', todomodel.toMap(),
        where: 'id = ?', whereArgs: [todomodel.id]);
  }

  // A method that deletes the data
  static Future<dynamic> deleteToDoList({required ToDoModel todomodel}) async {
    // Get a reference to the database.
    final db = await _databaseService.database;

    await db.delete(
      'ToDoList',
      where: 'id = ?',
      whereArgs: [todomodel.id],
    );
  }
}
