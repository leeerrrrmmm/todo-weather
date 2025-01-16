import '../model/todo.dart';

abstract class TodoState {}

class TodoInitial extends TodoState {}

class TodoLoaded extends TodoState {
  final List<Todo> todos;

  TodoLoaded(this.todos);
}

class TodoFiltered extends TodoState {
  final List<Todo> filteredTodos;

  TodoFiltered(this.filteredTodos);
}

class TodoError extends TodoState {
  final String error;

  TodoError(this.error);
}
