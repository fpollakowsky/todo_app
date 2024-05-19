import 'package:core/models/todo.dart';
import 'package:core/services/api_service.dart';
import 'package:get_it/get_it.dart';

class TodoRepository {
  final ApiService _apiService = GetIt.instance<ApiService>();

  Future<List<Todo>> fetchTodos() async {
    // Hardcoded userId for now, no login functionality -> no user id
    return await _apiService.fetchTodos(userId: 1);
  }

  Future<void> createTodo(Todo todo) async {
    await _apiService.createTodo(todo);
  }
}
