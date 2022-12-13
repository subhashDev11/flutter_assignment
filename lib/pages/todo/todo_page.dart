import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/route_arg/todo_page/todo_page.dart';
import '../../models/todo/todo.dart';
import '../../providers/todo/todo.dart';
import '../../utils/route.dart';
import '../../widgets/loading.dart';

class TodoPage extends HookConsumerWidget {
  const TodoPage._({
    required this.arg,
    super.key,
  });

  TodoPage.withArguments({
    Key? key,
    required RouteArguments args,
  }) : this._(
          key: key,
          arg: args['arg'] as TodoPageRouteArgument,
        );

  static const path = '/third/';
  static const name = 'TodoPage';

  final TodoPageRouteArgument arg;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: arg.when(
          instance: (todo) => TodoWidget(todo: todo),
          id: (id) => ref.watch(todoFutureProvider(id)).when(
                loading: () => const PrimarySpinkitCircle(),
                error: (_, __) => const SizedBox(),
                data: (todo) => TodoWidget(todo: todo),
              ),
        ),
      ),
    );
  }
}

class TodoWidget extends StatelessWidget {
  const TodoWidget({super.key, required this.todo});

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(todo.isDone ? Icons.check_box : Icons.check_box_outline_blank),
      title: Text(todo.title),
    );
  }
}
