// repositories/task_repository.dart
import 'dart:convert';
import 'package:uuid/uuid.dart';
import '../data/local/task_local_datasource.dart';
import '../data/remote/task_remote_datasource.dart';
import '../models/task.dart';

class TaskRepository {
  final TaskLocalDataSource local;
  final TaskRemoteDataSource remote;
  final _uuid = const Uuid();

  TaskRepository({required this.local, required this.remote});

  Future<List<TaskModel>> getTasks() async {
    // Return local first (offline-first)
    final localList = await local.getTasks();

    // Try refresh in background
    try {
      final remoteList = await remote.fetchTasks();
      for (var t in remoteList) {
        await local.insertTask(t);
      }
      return await local.getTasks();
    } catch (_) {
      return localList;
    }
  }

  Future<void> createTask(TaskModel t) async {
    await local.insertTask(t);

    // enqueue create op
    await local.addToQueue({
      'id': _uuid.v4(),
      'entity': 'task',
      'entity_id': t.id,
      'op': 'CREATE',
      'payload': jsonEncode(t.toJsonForApi()),
      'created_at': DateTime.now().millisecondsSinceEpoch,
      'attempt_count': 0,
      'last_error': ''
    });
  }

  Future<void> updateTask(TaskModel t) async {
    await local.updateTask(t);

    await local.addToQueue({
      'id': _uuid.v4(),
      'entity': 'task',
      'entity_id': t.id,
      'op': 'UPDATE',
      'payload': jsonEncode(t.toJsonForApi()),
      'created_at': DateTime.now().millisecondsSinceEpoch,
      'attempt_count': 0,
      'last_error': ''
    });
  }

  Future<void> deleteTask(String id) async {
    await local.softDelete(id);

    await local.addToQueue({
      'id': _uuid.v4(),
      'entity': 'task',
      'entity_id': id,
      'op': 'DELETE',
      'payload': '',
      'created_at': DateTime.now().millisecondsSinceEpoch,
      'attempt_count': 0,
      'last_error': ''
    });
  }
}

