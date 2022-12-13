import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RequestInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    debugPrint('*** Request ***');
    _printCurlCommand(options);
    super.onRequest(options, handler);
  }

  void _printCurlCommand(RequestOptions options) {
    final stringBuffer = StringBuffer();
    var query = '';
    if (options.method == 'GET' && options.queryParameters.isNotEmpty) {
      query =
          '?${options.queryParameters.entries.map((e) => '${e.key}=${e.value}').toList().join('&')}';
    }
    final requestUrl = '${options.baseUrl}${options.path}$query';
    stringBuffer.write('curl --request ${options.method} \'$requestUrl\'');
    for (final key in options.headers.keys) {
      stringBuffer.write(' -H \'$key: ${options.headers[key]}\'');
    }
    if (options.data != null && options.data is Map) {
      stringBuffer.write(' --data-binary \'${jsonEncode(options.data)}\'');
    }

    stringBuffer.write(' --insecure');
    debugPrint(stringBuffer.toString());
  }
}
