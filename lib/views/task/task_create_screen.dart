// ui/screens/task_create_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/task_provider.dart';

class TaskCreateScreen extends StatefulWidget {
  const TaskCreateScreen({super.key});
  @override
  State<TaskCreateScreen> createState() => _TaskCreateScreenState();
}

class _TaskCreateScreenState extends State<TaskCreateScreen> {
  final _controller = TextEditingController();
  final _form = GlobalKey<FormState>();

  Future<void> _save() async {
    if (!_form.currentState!.validate()) return;
    await Provider.of<TaskProvider>(context, listen: false).addTask(_controller.text);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear tarea')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: Column(
            children: [
              TextFormField(controller: _controller, decoration: const InputDecoration(labelText: 'Título'), validator: (v) => v==null||v.isEmpty? 'Obligatorio': null),
              const SizedBox(height: 16),
              ElevatedButton(onPressed: _save, child: const Text('Guardar'))
            ],
          ),
        ),
      ),
    );
  }
}
