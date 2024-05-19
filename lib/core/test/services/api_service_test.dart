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
        if (request.url.toString() == ApiService.url) {
          return http.Response(json.encode(mockTodos), 200);
        }
        return http.Response('Not Found', 404);
      });

      final apiService = ApiService(httpClient: mockHttpClient);
      final fetchedTodos = await apiService.fetchTodos();

      expect(fetchedTodos, isA<List<Todo>>());
      expect(fetchedTodos.length, mockTodos.length);
      expect(fetchedTodos.first.userId, mockTodos.first['userId']);
      expect(fetchedTodos.first.id, mockTodos.first['id']);
      expect(fetchedTodos.first.title, mockTodos.first['title']);
      expect(fetchedTodos.first.completed, mockTodos.first['completed']);
    });
  });
}
