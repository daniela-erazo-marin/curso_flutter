// provider/task_provider.dart
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/task.dart';
import '../data/local/task_local_datasource.dart';
import '../data/remote/task_remote_datasource.dart';
import '../repositories/task_repository.dart';
import '../services/sync_service.dart';

class TaskProvider extends ChangeNotifier {
  final TaskRepository repo;
  final SyncService sync;

  List<TaskModel> tasks = [];

  TaskProvider({required this.repo, required this.sync});

  Future<void> init() async {
    await loadTasks();
    sync.startAutoSync();
  }

  Future<void> loadTasks() async {
    tasks = await repo.getTasks();
    notifyListeners();
  }

  Future<void> addTask(String title) async {
    final id = const Uuid().v4();
    final t = TaskModel(id: id, title: title, completed: false, updatedAt: DateTime.now());
    await repo.createTask(t);
    await loadTasks();
  }

  Future<void> updateTask(TaskModel t) async {
    final updated = t.copyWith(updatedAt: DateTime.now());
    await repo.updateTask(updated);
    await loadTasks();
  }

  Future<void> toggleTask(TaskModel t) async {
  final updated = t.copyWith(completed: !t.completed, updatedAt: DateTime.now());

  // Actualiza en background (no bloquea la UI)
  repo.updateTask(updated);

  // Actualiza la lista en RAM sin recargar SQLite
  final index = tasks.indexWhere((x) => x.id == t.id);
  tasks[index] = updated;

  notifyListeners();
}


  Future<void> deleteTask(TaskModel t) async {
  await repo.deleteTask(t.id);

  // ⭐ Recargar desde SQLite (que ya tiene deleted = 1)
  tasks = await repo.getTasks();

  notifyListeners();
}

  // manual sync trigger
  Future<void> syncNow() async {
    await sync.syncQueue();
    await loadTasks();
  }
}
