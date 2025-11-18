// ui/screens/task_edit_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/task.dart';
import '../../provider/task_provider.dart';

class TaskEditScreen extends StatefulWidget {
  final TaskModel task;
  const TaskEditScreen({super.key, required this.task});
  @override
  State<TaskEditScreen> createState() => _TaskEditScreenState();
}

class _TaskEditScreenState extends State<TaskEditScreen> {
  late final TextEditingController _ctrl;
  final _form = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(text: widget.task.title);
  }

  Future<void> _save() async {
    if (!_form.currentState!.validate()) return;
    final provider = Provider.of<TaskProvider>(context, listen: false);
    await provider.updateTask(widget.task.copyWith(title: _ctrl.text, updatedAt: DateTime.now()));
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar tarea')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: Column(
            children: [
              TextFormField(controller: _ctrl, decoration: const InputDecoration(labelText: 'Título'), validator: (v) => v==null||v.isEmpty? 'Obligatorio': null),
              const SizedBox(height: 16),
              ElevatedButton(onPressed: _save, child: const Text('Actualizar'))
            ],
          ),
        ),
      ),
    );
  }
}
