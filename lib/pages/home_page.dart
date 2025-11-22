import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todo_provider.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Center(
          child: const Text(
            'Lista de Tareas',
            style: TextStyle(color: Color.fromARGB(255, 118, 55, 228)),
          ),
        ),
      ),
      body: Consumer<TodoProvider>(
        builder: (context, provider, _) {
          if (provider.status == TodoStateStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.status == TodoStateStatus.error) {
            return Center(child: Text('Error: ${provider.errorMessage}'));
          }

          return ListView.builder(
            itemCount: provider.todos.length,
            itemBuilder: (context, index) {
              final todo = provider.todos[index];
              return ListTile(
                title: Text(
                  todo.todo,
                  style: TextStyle(color: Colors.deepPurple),
                ),
                subtitle: Text(todo.completed ? "Completada" : "Pendiente"),
                onTap: () => context.push('/detail/${todo.id}'),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/create'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
