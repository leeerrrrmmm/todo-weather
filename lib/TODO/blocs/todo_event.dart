abstract class TodoEvent {}

class LoadTodosEvent extends TodoEvent {}

class AddTodoEvent extends TodoEvent {
  final int id;
  final String task;
  final String description;
  final String category;

  AddTodoEvent(this.id, this.task, this.description, this.category);
}

class ToggleTodoEvent extends TodoEvent {
  final int id;

  ToggleTodoEvent(this.id);
}

class RemoveTodoEvent extends TodoEvent {
  final int id;

  RemoveTodoEvent(this.id);
}

class FilterTodosByCategoryEvent extends TodoEvent {
  final String? category;

  FilterTodosByCategoryEvent(this.category);
}
