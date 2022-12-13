import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

class MockInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {

      final jsonFilePath = _getJsonFilePathFromRequestOptions(options);
      final byteData = await rootBundle.load(jsonFilePath);

      final dynamic data = json.decode(
        utf8.decode(
          byteData.buffer.asUint8List(
            byteData.offsetInBytes,
            byteData.lengthInBytes,
          ),
        ),
      );

      return handler.resolve(
        Response<dynamic>(
          data: data,
          statusCode: 200,
          requestOptions: options,
        ),
      );
    } on Exception {
      return handler.resolve(
        Response<dynamic>(
          // data: null,
          statusCode: 404,
          requestOptions: options,
        ),
      );
    }
  }

  String _getJsonFilePathFromRequestOptions(RequestOptions options) {
    var path = options.path;

    path = path.replaceFirst(RegExp(r'/$'), '');

    if (listRepoIssuesRegExp.hasMatch(path)) {
      path = '/repos/issues';
    }

    return baseDir + path + extension;
  }

  static const baseDir = 'assets/json/mock';
  static const extension = '.json';

  /// https://docs.github.com/en/rest/issues/issues#list-repository-issues
  static final listRepoIssuesRegExp = RegExp(r'/repos/[0-9a-zA-Z\-]+/[0-9a-zA-Z\-]+/issues');
}
