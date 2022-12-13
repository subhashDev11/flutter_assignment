import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../utils/provider_scope.dart';

class RootWidget extends StatefulWidget {
  const RootWidget({
    super.key,
    required this.widget,
    required this.overrides,
  });

  final Widget widget;
  final List<Override> overrides;

  static Future<void> restart(BuildContext context) async {
    final overrides = await providerScopeOverrides;
    // ignore: use_build_context_synchronously
    context.findAncestorStateOfType<_RootWidgetState>()!.restart(overrides);
  }

  @override
  State<StatefulWidget> createState() => _RootWidgetState();
}

class _RootWidgetState extends State<RootWidget> {
  Key _key = UniqueKey();
  List<Override> _overrides = [];

  void restart(List<Override> overrides) {
    setState(() {
      _key = UniqueKey();
      _overrides = overrides;
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: _key,
      child: ProviderScope(
        overrides: _overrides.isEmpty ? widget.overrides : _overrides,
        child: widget.widget,
      ),
    );
  }
}
