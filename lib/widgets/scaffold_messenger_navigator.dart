import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../pages/not_found/not_found_page.dart';
import '../providers/overlay_loading/overlay_loading.dart';
import '../route/router.dart';
import '../services/scaffold_messenger.dart';
import 'loading.dart';

class ScaffoldMessengerNavigator extends HookConsumerWidget {
  const ScaffoldMessengerNavigator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScaffoldMessenger(
      key: ref.watch(scaffoldMessengerServiceProvider.select((c) => c.scaffoldMessengerKey)),
      child: Scaffold(
        body: Stack(
          children: [
            Navigator(
              key: ref.watch(scaffoldMessengerServiceProvider.select((c) => c.navigatorKey)),
              initialRoute: ref.watch(routerProvider).initialRoute,
              onGenerateRoute: ref.watch(routerProvider).onGenerateRoute,
              observers: const <NavigatorObserver>[],
              onUnknownRoute: (settings) {
                final route = MaterialPageRoute<void>(
                  settings: settings,
                  builder: (context) => const NotFoundPage(),
                );
                return route;
              },
            ),
            if (ref.watch(overlayLoadingProvider)) const OverlayLoadingWidget(),
          ],
        ),
      ),
    );
  }
}
