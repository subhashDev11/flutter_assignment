import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../pages/main/main_page.dart';
import '../pages/not_found/not_found_page.dart';
import '../pages/repo/repo_page.dart';
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
