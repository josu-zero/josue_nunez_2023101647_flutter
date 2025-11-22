import 'package:dio/dio.dart';
import '../models/todo.dart';

class TodoService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://dummyjson.com'));

  Future<List<Todo>> fetchTodos() async {
    final response = await _dio.get('/todos');
    return (response.data['todos'] as List)
        .map((e) => Todo.fromJson(e))
        .toList();
  }

  Future<Todo> createTodo(String title) async {
    final response = await _dio.post(
      '/todos/add',
      data: {'todo': title, 'completed': false, 'userId': 1},
    );
    return Todo.fromJson(response.data);
  }

  Future<Todo> updateTodo(int id, bool completed) async {
    final response = await _dio.put(
      '/todos/$id',
      data: {'completed': completed},
    );
    return Todo.fromJson(response.data);
  }
}
