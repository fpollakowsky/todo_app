import 'package:core/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/presentation/providers/todo_provider.dart';
import 'package:todo_app/presentation/todo_view.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

void setupLocator() {
  GetIt.instance.registerLazySingleton(() => ApiService());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: 'To-Do App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const TodoPage(),
      ),
    );
  }
}
