import 'package:flutter/material.dart';

class TodoAppBar extends AppBar {
  final String titleLabel;
  final BuildContext context;

  TodoAppBar({super.key, required this.titleLabel, required this.context});

  @override
  Widget? get title => Container(
        margin: const EdgeInsets.all(16),
        alignment: Alignment.topLeft,
        child: Text(
          titleLabel,
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.start,
        ),
      );

  @override
  List<Widget>? get actions => [
        Container(
          margin: const EdgeInsets.only(right: 16),
          child: const CircleAvatar(
            backgroundImage: NetworkImage('https://picsum.photos/200'),
          ),
        ),
      ];

  @override
  bool get centerTitle => false;
}
