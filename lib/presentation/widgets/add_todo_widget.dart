import 'package:core/models/todo.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/presentation/todo_viewmodel.dart';

class AddTodoWidget extends StatelessWidget {
  final TodoViewModel viewModel;
  const AddTodoWidget({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const ValueKey('add_todo_widget'),
      padding: const EdgeInsets.only(bottom: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 56,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.fromLTRB(16, 16, 0, 0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xffF2F3F7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextFormField(
                  minLines: 1,
                  maxLines: 2,
                  focusNode: viewModel.focusNode,
                  controller: viewModel.textEditingController,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    hintText: 'Add a new task',
                    hintStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: const Color(0xffA1A4B2),
                        ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
          ValueListenableBuilder<bool>(
            valueListenable: viewModel.inputFieldHasValue,
            builder: (BuildContext context, bool hasInput, _) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 128),
                height: 56,
                margin: const EdgeInsets.only(left: 16),
                width: hasInput ? 56 : 0,
                child: Stack(
                  children: [
                    AnimatedPositioned(
                      right: hasInput ? 0 : -40,
                      duration: const Duration(milliseconds: 128),
                      child: Container(
                        height: 40,
                        width: 40,
                        margin: const EdgeInsets.only(right: 16, top: 16),
                        decoration: const BoxDecoration(
                          color: Color(0xff32B187),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: viewModel.isCreatingTodo
                            ? Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(8),
                                child: const CircularProgressIndicator(
                                  strokeWidth: 1,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            : IconButton(
                                onPressed: hasInput
                                    ? () => viewModel.createTodo(Todo(
                                          userId: 1,
                                          id: viewModel.todos.length + 1,
                                          title: viewModel.textEditingController.text.trim(),
                                          completed: false,
                                        ))
                                    : null,
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
