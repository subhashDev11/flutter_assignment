import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app.dart';
import 'utils/provider_scope.dart';
import 'widgets/root.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  final overrides = await providerScopeOverrides;
  runApp(
    RootWidget(
      overrides: overrides,
      widget: const App(),
    ),
  );
}
