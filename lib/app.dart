import 'package:flutter/material.dart';

import 'constants/localization.dart';
import 'widgets/scaffold_messenger_navigator.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: UniqueKey(),
      debugShowCheckedModeBanner: false,
      locale: locale,
      localizationsDelegates: localizationsDelegates,
      supportedLocales: const [locale],
      title: 'Flutter assignment',
      theme: ThemeData(primarySwatch: Colors.blue).copyWith(),
      home: const ScaffoldMessengerNavigator(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
          child: child!,
        );
      },
    );
  }
}
