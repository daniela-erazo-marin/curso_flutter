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
    await repo.updateTask(updated);
    await loadTasks();
  }

  Future<void> deleteTask(TaskModel t) async {
    await repo.deleteTask(t.id);
    await loadTasks();
  }

  // manual sync trigger
  Future<void> syncNow() async {
    await sync.syncQueue();
    await loadTasks();
  }
}
