import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_todo/bottom/bottom_nav_bar.dart';
import 'TODO/blocs/todo_bloc.dart';
import 'TODO/blocs/todo_event.dart';
import 'TODO/model/todo.dart';
import 'TODO/repo/todo_repository.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TodoAdapter());
  await Hive.openBox('todos');

  final todoRepository = HiveTodoRepository();

  runApp(
    BlocProvider(
      create: (context) => TodoBloc(todoRepository)..add(LoadTodosEvent()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      home:  BottomNavBars(),
    );
  }
}
