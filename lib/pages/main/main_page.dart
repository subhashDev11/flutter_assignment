import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/bottom_tab/bottom_tab.dart';
import '../../route/bottom_tabs.dart';
import '../../widgets/main_stacked_pages_navigator.dart';

class MainPage extends StatefulHookConsumerWidget {
  const MainPage({super.key});

  static const path = '/';
  static const name = 'MainPage';

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    Future.wait([
      // _initializePushNotification(),
      // _initializeDynamicLinks(),
    ]);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    debugPrint('***');
    debugPrint('AppLifecycleState: ${state.name}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Scaffold(
            body: Stack(
              children: [for (final tab in bottomTabs) _buildStackedPages(tab)],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStackedPages(BottomTab bottomTab) {
    final currentBottomTab = ref.watch(bottomTabStateProvider);
    return Offstage(
      offstage: bottomTab != currentBottomTab,
      child: TickerMode(
        enabled: bottomTab == currentBottomTab,
        child: MainStackedPagesNavigator(bottomTab: bottomTab),
      ),
    );
  }
}
