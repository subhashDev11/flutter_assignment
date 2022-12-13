import 'package:dio/dio.dart';

extension DioErrorTypeExt on DioErrorType {

  bool get isTimeout => [
        DioErrorType.connectTimeout,
        DioErrorType.receiveTimeout,
        DioErrorType.sendTimeout,
      ].contains(this);
}
