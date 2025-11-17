// ui/screens/tasks_screen.dart
import 'package:curso_flutter/views/task/task_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/task_provider.dart';
import 'task_create_screen.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});
  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  String filter = 'all';
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<TaskProvider>(context, listen: false));
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context);
    var tasks = provider.tasks;
    if (filter == 'completed') tasks = tasks.where((t) => t.completed).toList();
    if (filter == 'pending') tasks = tasks.where((t) => !t.completed).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do Offline'),
        actions: [
          IconButton(onPressed: () => provider.syncNow(), icon: const Icon(Icons.sync)),
          PopupMenuButton<String>(
            onSelected: (v) => setState(() => filter = v),
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'all', child: Text('Todas')),
              PopupMenuItem(value: 'pending', child: Text('Pendientes')),
              PopupMenuItem(value: 'completed', child: Text('Completadas')),
            ],
          )
        ],
      ),
      body: tasks.isEmpty ? const Center(child: Text('No hay tareas')) : ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (_, i) => TaskItem(task: tasks[i]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TaskCreateScreen())),
        child: const Icon(Icons.add),
      ),
    );
  }
}
