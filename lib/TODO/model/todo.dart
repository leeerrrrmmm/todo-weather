import 'package:hive/hive.dart';

part 'todo.g.dart';

@HiveType(typeId: 0)
class Todo {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String task;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String category;

  @HiveField(4)
  bool isDone;

  Todo({
    required this.id,
    required this.task,
    required this.description,
    required this.category,
    this.isDone = false,
  });

  Todo toggle () {
    return Todo(
        id: id,
        task: task,
        description: description,
        category: category,
        isDone: !isDone,
    );
  }
}
