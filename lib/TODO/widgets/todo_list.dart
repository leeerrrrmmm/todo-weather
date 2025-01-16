import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/todo_bloc.dart';
import '../blocs/todo_event.dart';
import '../model/todo.dart';

class TodoList extends StatelessWidget {
  final List<Todo> todos;

  const TodoList({
    Key? key,
    required this.todos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (todos.isEmpty) {
      return const Center(
        child: Text('Нет задач в этой категории'),
      );
    }
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return TodoCard(todo: todo, index: index);
      },
    );
  }
}

class TodoCard extends StatelessWidget {
  final Todo todo;
  final int index;

  const TodoCard({
    Key? key,
    required this.todo,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDone = todo.isDone;

    return Card(
      color: isDone ? Colors.blue : Colors.white,
      child: ListTile(
        leading: Checkbox(
          value: isDone,
          onChanged: (_) {
            context.read<TodoBloc>().add(ToggleTodoEvent(todo.id));
          },
        ),
        title: Text(
          todo.task,
          style: TextStyle(
            color: isDone ? Colors.white : Colors.black,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              todo.description,
              style: TextStyle(
                color: isDone ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Категория: ${todo.category}',
              style: TextStyle(
                color: isDone ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
        trailing: IconButton(onPressed: () {
          context.read<TodoBloc>().add(RemoveTodoEvent(todo.id));
        }, icon: Icon(Icons.delete,color:Colors.red)),
      ),
    );
  }
}
