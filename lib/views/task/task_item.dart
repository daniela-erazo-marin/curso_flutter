import 'package:curso_flutter/views/task/task_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/task_provider.dart';
import '../../../models/task.dart';

class TaskItem extends StatelessWidget {
  final TaskModel task;

  const TaskItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context, listen: false);

    return Card(
      child: ListTile(
        title: Text(task.title),
        subtitle: Text(task.completed ? "Completada" : "Pendiente"),

        /// 🔵 Tap para editar
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => TaskEditScreen(task: task),
            ),
          );
        },

        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// 🔵 Cambiar estado (toggle)
            IconButton(
              icon: Icon(
                task.completed
                    ? Icons.check_box
                    : Icons.check_box_outline_blank,
              ),
              onPressed: () async {
                await provider.toggleTask(task);
              },
            ),

            /// 🔴 Eliminar tarea
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () async {
                await provider.deleteTask(task);
              },
            ),
          ],
        ),
      ),
    );
  }
}
