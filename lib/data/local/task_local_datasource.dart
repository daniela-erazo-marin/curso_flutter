// data/local/task_local_datasource.dart
import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import '../../models/task.dart';
import 'task_db.dart';

class TaskLocalDataSource {
  final TaskDB _db = TaskDB.instance;

  Future<List<TaskModel>> getTasks() async {
    final database = await _db.database;
    final res = await database.query('tasks', where: 'deleted = 0', orderBy: 'updated_at DESC');
    return res.map((e) => TaskModel.fromJson(e)).toList();
  }

  Future<TaskModel?> getTaskById(String id) async {
    final db = await _db.database;
    final res = await db.query('tasks', where: 'id = ?', whereArgs: [id]);
    if (res.isEmpty) return null;
    return TaskModel.fromJson(res.first);
  }

  Future<void> insertTask(TaskModel t) async {
    final db = await _db.database;
    await db.insert('tasks', t.toJsonForDb(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateTask(TaskModel t) async {
    final db = await _db.database;
    await db.update('tasks', t.toJsonForDb(), where: 'id = ?', whereArgs: [t.id]);
  }

  Future<void> softDelete(String id) async {
    final db = await _db.database;
    await db.update('tasks', {'deleted': 1}, where: 'id = ?', whereArgs: [id]);
  }

  // Queue operations
  Future<void> addToQueue(Map<String, dynamic> op) async {
    final db = await _db.database;
    await db.insert('queue_operations', op);
  }

  Future<List<Map<String, dynamic>>> getQueue() async {
    final db = await _db.database;
    return db.query('queue_operations', orderBy: 'created_at ASC');
  }

  Future<void> updateQueueAttempt(String id, int attempt, String lastError) async {
    final db = await _db.database;
    await db.update('queue_operations', {'attempt_count': attempt, 'last_error': lastError}, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> removeQueueItem(String id) async {
    final db = await _db.database;
    await db.delete('queue_operations', where: 'id = ?', whereArgs: [id]);
  }
}
