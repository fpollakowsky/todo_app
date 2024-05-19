import 'dart:convert';

import 'package:core/models/todo.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'jsonplaceholder.typicode.com';
  static const String todosPath = '/todos';

  final http.Client httpClient;

  ApiService({http.Client? httpClient}) : httpClient = httpClient ?? http.Client();

  Future<List<Todo>> fetchTodos({int? userId}) async {
    final Uri uri = Uri.https(baseUrl, todosPath, {
      if (userId != null) 'userId': userId.toString(),
    });

    final response = await httpClient.get(uri);

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<Todo> todos = body.map((dynamic item) => Todo.fromJson(item)).toList();
      return todos;
    } else {
      throw Exception('Failed to load todos');
    }
  }

  Future<Todo> createTodo(Todo todo) async {
    final Uri uri = Uri.https(baseUrl, todosPath);
    final response = await httpClient.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(todo.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create todo');
    }

    return Todo.fromJson(json.decode(response.body));
  }
}
