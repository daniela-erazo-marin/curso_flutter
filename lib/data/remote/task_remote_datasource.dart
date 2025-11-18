// data/remote/task_remote_datasource.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/task.dart';
import '../../core/config.dart';

class TaskRemoteDataSource {
  final String baseUrl;
  TaskRemoteDataSource({String? base}) : baseUrl = base ?? apiUrl;

  Future<List<TaskModel>> fetchTasks() async {
    final uri = Uri.parse('$baseUrl/tasks');
    final res = await http.get(uri).timeout(const Duration(seconds: 10));
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body) as List;
      return data.map((e) => TaskModel.fromJson(e as Map<String, dynamic>)).toList();
    }
    throw Exception('Remote fetch failed ${res.statusCode}');
  }

  Future<TaskModel> createTask(TaskModel t, {String? idempotencyKey}) async {
    final uri = Uri.parse('$baseUrl/tasks');
    final headers = {'Content-Type': 'application/json'};
    if (idempotencyKey != null) headers['Idempotency-Key'] = idempotencyKey;
    final res = await http.post(uri, headers: headers, body: jsonEncode(t.toJsonForApi())).timeout(const Duration(seconds: 10));
    if (res.statusCode == 200 || res.statusCode == 201) {
      return TaskModel.fromJson(jsonDecode(res.body));
    }
    throw Exception('Remote create failed ${res.statusCode}: ${res.body}');
  }

  Future<void> updateTask(TaskModel t) async {
    final uri = Uri.parse('$baseUrl/tasks/${t.id}');
    final res = await http.put(uri, headers: {'Content-Type': 'application/json'}, body: jsonEncode(t.toJsonForApi())).timeout(const Duration(seconds: 10));
    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw Exception('Remote update failed ${res.statusCode}');
    }
  }

  Future<void> deleteTask(String id) async {
    final uri = Uri.parse('$baseUrl/tasks/$id');
    final res = await http.delete(uri).timeout(const Duration(seconds: 10));
    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw Exception('Remote delete failed ${res.statusCode}');
    }
  }
}
