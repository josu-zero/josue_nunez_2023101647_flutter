import 'package:flutter/material.dart';
import '../services/todo_service.dart';
import '../models/todo.dart';

enum TodoStateStatus { loading, error, loaded }

class TodoProvider with ChangeNotifier {
  final TodoService _service = TodoService();

  List<Todo> todos = [];
  TodoStateStatus status = TodoStateStatus.loading;
  String errorMessage = '';

  TodoProvider() {
    fetchTodos();
  }

  Future<void> fetchTodos() async {
    status = TodoStateStatus.loading;
    notifyListeners();
    try {
      todos = await _service.fetchTodos();
      status = TodoStateStatus.loaded;
    } catch (e) {
      errorMessage = e.toString();
      status = TodoStateStatus.error;
    }
    notifyListeners();
  }

  Future<void> addTodo(String title) async {
    try {
      final newTodo = await _service.createTodo(title);
      todos.add(newTodo);
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> updateTodoStatus(int id, bool completed) async {
    try {
      final updated = await _service.updateTodo(id, completed);
      todos = todos.map((t) => t.id == id ? updated : t).toList();
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
    }
  }
}
