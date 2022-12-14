import 'dart:io';

import 'base.dart';

class UnsupportedPlatformException extends AppException {
  const UnsupportedPlatformException() : super();

  @override
  String get message => '${Platform.operatingSystem} Not supported。';
}
