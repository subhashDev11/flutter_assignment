import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../pages/main/main_page.dart';
import '../pages/not_found/not_found_page.dart';
import '../pages/repo/repo_page.dart';
import '../pages/second/second_page.dart';
import '../pages/todo/todo_page.dart';
import '../utils/route.dart';

final appRoutesProvider = Provider((_) => appRoutes);

final appRoutes = <AppRoute>[
  AppRoute(
    MainPage.path,
    (_, args) => const MainPage(
      key: ValueKey(MainPage.name),
    ),
  ),
  AppRoute(
    SecondPage.path,
    (_, args) => const SecondPage(
      key: ValueKey(SecondPage.name),
    ),
  ),
  AppRoute(
    TodoPage.path,
    (_, args) => TodoPage.withArguments(
      key: const ValueKey(TodoPage.name),
      args: args,
    ),
  ),
  AppRoute(
    RepoPage.path,
    (_, args) => const RepoPage(
      key: ValueKey(RepoPage.name),
    ),
  ),
  AppRoute(
    NotFoundPage.path,
    (_, __) => const NotFoundPage(
      key: ValueKey(NotFoundPage.name),
    ),
  ),
];
