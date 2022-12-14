import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../constants/map.dart';
import '../pages/not_found/not_found_page.dart';
import '../utils/bool.dart';
import '../utils/route.dart';
import 'routes.dart';

final routerProvider = Provider<Router>((ref) => Router(ref.read));

class Router {
  Router(this._read);

  final Reader _read;
  final initialRoute = '/';

  Route<dynamic> onGenerateRoute(RouteSettings routeSettings, {String? bottomNavigationPath}) {
    var path = _path(routeSettings, bottomNavigationPath: bottomNavigationPath);
    debugPrint('***');
    debugPrint('path: $path');

    var queryParams = emptyMap;
    if (path.contains('?')) {
      queryParams = Uri.parse(path).queryParameters;
      path = path.split('?').first;
    }

    final data = (routeSettings.arguments as RouteArguments?)?.data ?? emptyMap;

    try {
      final appRoute = _read(appRoutesProvider).firstWhere(
        (appRoute) => appRoute.path == path,
        orElse: () => throw RouteNotFoundException(path),
      );
      final route = MaterialPageRoute<dynamic>(
        settings: routeSettings,
        builder: (context) => appRoute.pageBuilder(context, RouteArguments(data)),
        fullscreenDialog: toBool(queryParams['fullScreenDialog'] ?? false),
      );
      return route;
    } on RouteNotFoundException catch (e) {
      final route = MaterialPageRoute<void>(
        settings: routeSettings,
        builder: (context) => NotFoundPage(exception: e),
      );
      return route;
    }
  }

  String _path(RouteSettings routeSettings, {String? bottomNavigationPath}) {
    final path = routeSettings.name;
    if (path == null) {
      return '';
    }
    if (bottomNavigationPath?.isEmpty ?? true) {
      return path;
    }
    if (path == initialRoute) {
      return bottomNavigationPath!;
    }
    return path;
  }
}
