// models/task.dart
class TaskModel {
  final String id;
  final String title;
  final bool completed;
  final DateTime updatedAt;

  TaskModel({
    required this.id,
    required this.title,
    this.completed = false,
    required this.updatedAt,
  });

  static bool _parseCompleted(dynamic v) {
    if (v is bool) return v;
    if (v is int) return v == 1;
    if (v is String) return v.toLowerCase() == 'true';
    return false;
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      completed: _parseCompleted(json['completed']),
      updatedAt: DateTime.parse(json['updated_at'] ?? json['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJsonForApi() => {
        'id': id,
        'title': title,
        'completed': completed,
        'updated_at': updatedAt.toIso8601String(),
      };

  Map<String, dynamic> toJsonForDb() => {
        'id': id,
        'title': title,
        'completed': completed ? 1 : 0,
        'updated_at': updatedAt.toIso8601String(),
        'deleted': 0,
      };

  TaskModel copyWith({String? title, bool? completed, DateTime? updatedAt}) {
    return TaskModel(
      id: id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
