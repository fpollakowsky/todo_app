import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.freezed.dart';
part 'todo.g.dart';

@freezed
class Todo with _$Todo {
  const Todo._();
  const factory Todo({
    required int userId,
    int? id,
    required String title,
    required bool completed,
  }) = _Todo;

  Todo toggleCompleted() {
    return copyWith(completed: !completed);
  }

  factory Todo.fromJson(Map<String, Object?> json) => _$TodoFromJson(json);
}
