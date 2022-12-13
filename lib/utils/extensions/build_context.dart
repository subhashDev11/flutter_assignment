import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {

  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  Size get displaySize => MediaQuery.of(this).size;
}
