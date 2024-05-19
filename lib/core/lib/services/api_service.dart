import 'dart:convert';

import 'package:core/models/todo.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String url = 'https://jsonplaceholder.typicode.com/todos';
  final http.Client httpClient;

  ApiService({http.Client? httpClient}) : httpClient = httpClient ?? http.Client();

  Future<List<Todo>> fetchTodos() async {
    final response = await httpClient.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<Todo> todos = body.map((dynamic item) => Todo.fromJson(item)).toList();
      return todos;
    } else {
      throw Exception('Failed to load todos');
    }
  }
}
