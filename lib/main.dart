import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'providers/todo_provider.dart';
import 'pages/home_page.dart';
import 'pages/detail_page.dart';
import 'pages/create_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => TodoProvider(), child: const MyApp()),
  );
}

final _router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomePage()),
    GoRoute(
      path: '/detail/:id',
      builder: (context, state) =>
          DetailPage(int.parse(state.pathParameters['id']!)),
    ),
    GoRoute(path: '/create', builder: (context, state) => const CreatePage()),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      title: 'TaskMaster Provider',
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
