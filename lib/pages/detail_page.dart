import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todo_provider.dart';

class DetailPage extends StatelessWidget {
  final int id;
  const DetailPage(this.id, {super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TodoProvider>();
    final index = provider.todos.indexWhere((t) => t.id == id);

    if (provider.status == TodoStateStatus.loading || index == -1) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final todo = provider.todos[index];

    return Scaffold(
      appBar: AppBar(title: const Text('Detalle de Tarea')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(todo.todo, style: const TextStyle(fontSize: 22)),
            const SizedBox(height: 20),
            SwitchListTile(
              title: const Text('Completada'),
              value: todo.completed,
              onChanged: (value) async {
                await provider.updateTodoStatus(todo.id, value);
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Tarea actualizada')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
