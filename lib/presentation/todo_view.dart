import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/presentation/todo_viewmodel.dart';
import 'package:todo_app/presentation/widgets/add_todo_widget.dart';
import 'package:todo_app/presentation/widgets/todo_app_bar.dart';
import 'package:todo_app/presentation/widgets/todo_list_widget.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => TodoViewModel(),
      builder: (context, child) => _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    final viewModel = context.select((TodoViewModel model) => model);

    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (_) => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: TodoAppBar(
          context: context,
          titleLabel: 'Hi Max!',
        ),
        body: context.watch<TodoViewModel>().isLoading
            ? const Center(child: CircularProgressIndicator())
            : SafeArea(
                child: SingleChildScrollView(
                  reverse: true,
                  physics: const NeverScrollableScrollPhysics(),
                  child: SizedBox(
                    height:
                        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - kToolbarHeight - 32,
                    child: Column(
                      children: [
                        TodoListWidget(viewModel: viewModel),
                        AddTodoWidget(viewModel: viewModel),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
