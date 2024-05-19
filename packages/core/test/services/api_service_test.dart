import 'dart:convert';

import 'package:core/models/todo.dart';
import 'package:core/services/api_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  group('ApiService', () {
    test('fetchTodos returns a list of Todos if the http call completes successfully', () async {
      final mockTodos = [
        {
          'userId': 1,
          'id': 1,
          'title': 'ToDo 1',
          'completed': false,
        },
        {
          'userId': 1,
          'id': 2,
          'title': 'ToDo 2',
          'completed': true,
        },
      ];

      final mockHttpClient = MockClient((request) async {
        final Uri uri = Uri.https(ApiService.baseUrl, ApiService.todosPath, {'userId': '1'});
        if (request.url.toString() == uri.toString()) {
          return http.Response(json.encode(mockTodos), 200);
        }
        return http.Response('Not Found', 404);
      });

      final apiService = ApiService(httpClient: mockHttpClient);
      final fetchedTodos = await apiService.fetchTodos(userId: 1);

      expect(fetchedTodos, isA<List<Todo>>());
      expect(fetchedTodos.length, mockTodos.length);
      for (var i = 0; i < fetchedTodos.length; i++) {
        expect(fetchedTodos[i].userId, mockTodos[i]['userId']);
        expect(fetchedTodos[i].id, mockTodos[i]['id']);
        expect(fetchedTodos[i].title, mockTodos[i]['title']);
        expect(fetchedTodos[i].completed, mockTodos[i]['completed']);
      }
    });

    test('createTodo returns a Todo if the http call completes successfully', () async {
      final mockTodo = {
        'userId': 1,
        'id': 1,
        'title': 'ToDo 1',
        'completed': false,
      };

      final mockHttpClient = MockClient((request) async {
        final Uri uri = Uri.https(ApiService.baseUrl, ApiService.todosPath);
        if (request.url.toString() == uri.toString()) {
          return http.Response(json.encode(mockTodo), 201);
        }
        return http.Response('Not Found', 404);
      });

      final apiService = ApiService(httpClient: mockHttpClient);
      final createdTodo = await apiService.createTodo(Todo.fromJson(mockTodo));

      expect(createdTodo, isA<Todo>());
      expect(createdTodo.userId, mockTodo['userId']);
      expect(createdTodo.id, mockTodo['id']);
      expect(createdTodo.title, mockTodo['title']);
      expect(createdTodo.completed, mockTodo['completed']);
    });
  });
}
