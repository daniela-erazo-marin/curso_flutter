// data/local/task_db.dart
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TaskDB {
  static final TaskDB instance = TaskDB._init();
  static Database? _database;

  TaskDB._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('tasks.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        completed INTEGER NOT NULL DEFAULT 0,
        updated_at TEXT NOT NULL,
        deleted INTEGER NOT NULL DEFAULT 0
      );
    ''');

    await db.execute('''
      CREATE TABLE queue_operations (
        id TEXT PRIMARY KEY,
        entity TEXT,
        entity_id TEXT,
        op TEXT,
        payload TEXT,
        created_at INTEGER,
        attempt_count INTEGER,
        last_error TEXT
      );
    ''');
  }
}
