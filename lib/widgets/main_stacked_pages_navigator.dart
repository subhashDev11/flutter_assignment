import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../pages/main/main_page.dart';
import '../pages/not_found/not_found_page.dart';
import '../route/bottom_tabs.dart';
import '../route/router.dart';

class MainStackedPagesNavigator extends HookConsumerWidget {
  const MainStackedPagesNavigator({
    super.key,
    required this.bottomTab,
  });

  final BottomTab bottomTab;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Navigator(
      key: bottomTab.key,
      initialRoute: MainPage.path,
      observers: [
        HeroController(),
      ],
      onGenerateRoute: (routeSettings) => ref
          .watch(routerProvider)
          .onGenerateRoute(routeSettings, bottomNavigationPath: bottomTab.path),
      onUnknownRoute: (settings) {
        final route = MaterialPageRoute<void>(
          settings: settings,
          builder: (context) => const NotFoundPage(),
        );
        return route;
      },
    );
  }
}
