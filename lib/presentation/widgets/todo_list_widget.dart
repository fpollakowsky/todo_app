import 'package:core/models/todo.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/presentation/todo_viewmodel.dart';
import 'package:todo_app/presentation/widgets/todo_list_item.dart';

class TodoListWidget extends StatelessWidget {
  final TodoViewModel viewModel;
  const TodoListWidget({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      key: const ValueKey('todo_list_widget'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ReorderableListView(
          onReorder: viewModel.onReorder,
          proxyDecorator: (Widget child, int index, Animation<double> animation) {
            return Material(
              child: SizeTransition(
                sizeFactor: animation,
                child: child,
              ),
            );
          },
          children: viewModel.todos.map<Widget>((Todo todo) {
            return TodoListItem(
              key: ValueKey(todo.id),
              todo: todo,
              viewModel: viewModel,
              index: viewModel.todos.indexOf(todo),
            );
          }).toList(), // Convert Iterable<Widget> to List<Widget>
        ),
      ),
    );
  }
}
