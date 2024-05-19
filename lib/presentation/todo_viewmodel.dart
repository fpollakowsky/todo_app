import 'package:core/models/todo.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/data/repositories/api_service.dart';

class TodoViewModel extends ChangeNotifier {
  TodoViewModel() {
    textEditingController.addListener(() {
      inputFieldHasValue.value = textEditingController.text.isNotEmpty;
    });
    fetchTodos();
  }

  final TodoRepository _todoRepository = TodoRepository();
  final ValueNotifier<bool> _inputFieldHasValue = ValueNotifier<bool>(false);

  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  List<Todo> _todos = [];
  bool _isLoading = false;
  bool _isCreatingTodo = false;

  List<Todo> get todos => _todos;
  bool get isLoading => _isLoading;
  bool get isCreatingTodo => _isCreatingTodo;
  ValueNotifier<bool> get inputFieldHasValue => _inputFieldHasValue;

  TextEditingController get textEditingController => _textEditingController;
  FocusNode get focusNode => _focusNode;

  void toggleTodoStatus(int index) {
    _todos[index] = _todos[index].toggleCompleted();
    notifyListeners();
  }

  void onReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    final Todo todo = _todos.removeAt(oldIndex);
    _todos.insert(newIndex, todo);

    notifyListeners();
  }

  Future<void> fetchTodos() async {
    _isLoading = true;
    notifyListeners();

    try {
      _todos = await _todoRepository.fetchTodos();
    } catch (e) {
      // todo Handle error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createTodo(Todo todo) async {
    _isCreatingTodo = true;
    notifyListeners();

    try {
      await _todoRepository.createTodo(todo);
      _todos.insert(0, todo);

      textEditingController.clear();
      focusNode.unfocus();
    } catch (e) {
      // Handle error
    }

    _isCreatingTodo = false;
    notifyListeners();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    focusNode.dispose();
    super.dispose();
  }
}
