import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../TODO/blocs/todo_bloc.dart';
import '../TODO/blocs/todo_event.dart';
import '../TODO/blocs/todo_state.dart';
import '../TODO/widgets/category_dropdown.dart';
import '../TODO/widgets/todo_list.dart';
import 'add_todo_ui.dart';


class TodoView extends StatefulWidget {
  const TodoView({super.key});

  @override
  State<TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    context.read<TodoBloc>().add(FilterTodosByCategoryEvent(null));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
        actions: [
          CategoryDropdown(
            selectedCategory: selectedCategory,
            onCategorySelected: (category) {
              setState(() {
                selectedCategory = category;
              });
              context.read<TodoBloc>().add(FilterTodosByCategoryEvent(selectedCategory));
            },
          ),
        ],
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoFiltered) {
            final filterTodos = state.filteredTodos;
            return TodoList(todos: filterTodos);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTodoUi(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
