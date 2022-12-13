import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ResponseInterceptor extends Interceptor {
  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    final stringBuffer = StringBuffer();
    debugPrint('*** Response ***');
    final requestOptions = response.requestOptions;
    stringBuffer
        .writeln('${requestOptions.method} ${requestOptions.baseUrl}${requestOptions.path}');
    stringBuffer.writeln('${response.statusCode} ${response.statusMessage}');

    debugPrint(stringBuffer.toString());
    super.onResponse(response, handler);
  }
}
