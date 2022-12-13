import '../utils/types.dart';

class RouteArguments {
  RouteArguments(this.data);

  final Map<String, dynamic> data;

  dynamic operator [](String key) => data[key];
}

class AppRoute {
  AppRoute(this.path, this.pageBuilder);

  final String path;
  final PageBuilder pageBuilder;
}

class RouteNotFoundException implements Exception {
  RouteNotFoundException(this.path);
  final String path;

  @override
  String toString() => '$path：The specified page was not found.';
}
