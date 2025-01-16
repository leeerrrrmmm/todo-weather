import 'package:hive/hive.dart';
import '../model/todo.dart';

abstract class TodoRepository {
  List<Todo> loadTodos();
  void addTodo(Todo todo);
  void updateTodoById(int id, Todo todo);
  void removeTodoById(int id);
  Todo? getTodoById(int id);
}

class HiveTodoRepository implements TodoRepository {
  final Box _todoBox = Hive.box('todos');

  @override
  List<Todo> loadTodos() {
    return _todoBox.values.cast<Todo>().toList();
  }

  @override
  void addTodo(Todo todo) {
    _todoBox.add(todo);
  }

  @override
  void updateTodoById(int id, Todo todo) {
    final index = _todoBox.values.toList().indexWhere((item) => item.id == id);
    if (index != -1) {
      _todoBox.putAt(index, todo);
    }
  }

  @override
  void removeTodoById(int id) {
    final index = _todoBox.values.toList().indexWhere((item) => item.id == id);
    if (index != -1) {
      _todoBox.deleteAt(index);
    }
  }


  @override
  Todo? getTodoById(int id) {
    try {
      return _todoBox.values.cast<Todo>().firstWhere((item) => item.id == id);
    } catch (e) {
      return null;
    }
  }
}
