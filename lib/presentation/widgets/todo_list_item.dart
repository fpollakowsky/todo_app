import 'package:core/models/todo.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/presentation/todo_viewmodel.dart';

class TodoListItem extends StatelessWidget {
  final Todo todo;
  final int index;
  final TodoViewModel viewModel;
  const TodoListItem({
    super.key,
    required this.todo,
    required this.index,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        key: ValueKey(todo.id),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        title: Text(
          todo.title,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                decoration: todo.completed ? TextDecoration.lineThrough : null,
              ),
        ),
        leading: Checkbox(
          value: todo.completed,
          activeColor: Theme.of(context).colorScheme.secondary,
          onChanged: (value) => viewModel.toggleTodoStatus(index),
        ),
        onTap: () => viewModel.toggleTodoStatus(index),
      ),
    );
  }
}
