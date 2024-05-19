import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:todo_app/presentation/todo_viewmodel.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<TodoViewModel>(
    create: (_) => TodoViewModel(),
  ),
];
