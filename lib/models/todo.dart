class Todo {
  final int id;
  final String todo;
  final int userId;
  bool completed;

  Todo({
    required this.id,
    required this.todo,
    required this.completed,
    required this.userId,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
    id: json['id'],
    todo: json['todo'],
    completed: json['completed'],
    userId: json['userId'],
  );

  Map<String, dynamic> toJson() => {
    'todo': todo,
    'completed': completed,
    'userId': userId,
  };
}
