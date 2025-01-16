import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/todo_event.dart';
import '../blocs/todo_state.dart';
import '../model/todo.dart';
import '../repo/todo_repository.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository repository;
  List<Todo> todos = [];
  String? currentCategory;

  TodoBloc(this.repository) : super(TodoInitial()) {
    on<LoadTodosEvent>((event, emit) {
      try {
        todos = repository.loadTodos();
        emit(TodoLoaded(todos));
      } catch (e) {
        emit(TodoError('Ошибка загрузки задач'));
      }
    });

    on<AddTodoEvent>((event, emit) {
      final newTodo = Todo(
        id: event.id,
        task: event.task,
        description: event.description,
        category: event.category,
      );
      repository.addTodo(newTodo);
      todos.add(newTodo);
      _emitFilteredTodos(emit);
    });

    on<ToggleTodoEvent>((event, emit) {
      try {

        final todoIndex = todos.indexWhere((todo) => todo.id == event.id);
        if (todoIndex == -1) {
          emit(TodoError('Задача не найдена'));
          return;
        }
        final updatedTodo = todos[todoIndex].toggle();
        todos[todoIndex] = updatedTodo;
        repository.updateTodoById(event.id, updatedTodo);
        _emitFilteredTodos(emit);
      } catch (e) {
        emit(TodoError('Ошибка обновления задачи'));
      }
    });

    on<RemoveTodoEvent>((event, emit) {
      try {
        repository.removeTodoById(event.id);
        todos.removeWhere((todo) => todo.id == event.id);
        _emitFilteredTodos(emit);
      } catch (e) {
        emit(TodoError('Ошибка удаления задачи'));
      }
    });

    on<FilterTodosByCategoryEvent>((event, emit) {
      currentCategory = event.category;
      _emitFilteredTodos(emit);
    });
  }

  void _emitFilteredTodos(Emitter<TodoState> emit) {

    if (currentCategory == null || currentCategory == 'Все задачи') {
      emit(TodoFiltered(todos));
    } else {
      final filteredTodos = todos.where((todo) => todo.category == currentCategory).toList();
      emit(TodoFiltered(filteredTodos));
    }
  }
}