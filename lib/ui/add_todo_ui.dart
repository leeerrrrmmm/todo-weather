import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../TODO/blocs/todo_bloc.dart';
import '../TODO/blocs/todo_event.dart';
import '../TODO/model/todo.dart';


class AddTodoUi extends StatelessWidget {
  AddTodoUi({super.key});
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: Colors.black
                  )
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      controller: _taskController,
                      decoration: InputDecoration(
                          labelText: 'Task',
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none
                          )
                      ),
                    ),
                  ),
                  const Divider(color: Colors.black, height: 0.1,),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                          labelText: 'Description',
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none
                          )
                      ),
                    ),
                  ),
                  const Divider(color: Colors.black, height: 0.1,),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      controller: _categoryController,
                      decoration: InputDecoration(
                          labelText: 'Category',
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none
                          )
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final task = _taskController.text.trim();
          final description = _descriptionController.text.trim();
          final category = _categoryController.text.trim();


          if (task.isNotEmpty && description.isNotEmpty) {
            final newTask = Todo(
              id: DateTime.now().millisecondsSinceEpoch,
              task: task,
              description: description,
              category: category,
            );

            context.read<TodoBloc>().add(AddTodoEvent(newTask.id, task, description, category));


            _taskController.clear();
            _descriptionController.clear();
            _categoryController.clear();


            Navigator.pop(context);
          }
        },
        label: Icon(Icons.add),
      ),
    );
  }
}
