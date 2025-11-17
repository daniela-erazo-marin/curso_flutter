// ui/widgets/task_item.dart
import 'package:curso_flutter/views/task/task_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/task.dart';
import '../../provider/task_provider.dart';

class TaskItem extends StatelessWidget {
  final TaskModel task;
  const TaskItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context, listen: false);

    return ListTile(
      leading: Checkbox(value: task.completed, onChanged: (_) => provider.toggleTask(task)),
      title: Text(task.title, style: TextStyle(decoration: task.completed ? TextDecoration.lineThrough : null)),
      subtitle: Text(task.updatedAt.toLocal().toString()),
      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
        IconButton(icon: const Icon(Icons.edit), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TaskEditScreen(task: task)))),
        IconButton(icon: const Icon(Icons.delete), onPressed: () => provider.deleteTask(task)),
      ]),
    );
  }
}
