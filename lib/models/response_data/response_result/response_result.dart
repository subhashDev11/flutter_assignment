import 'package:freezed_annotation/freezed_annotation.dart';

import '../base_response_data/base_response_data.dart';

part 'response_result.freezed.dart';

@freezed
class ResponseResult with _$ResponseResult {
  const factory ResponseResult.success({
    required BaseResponseData data,
  }) = Success;

  const factory ResponseResult.failure({
    @Default('Communication with the server failed.') String message,
  }) = Failure;
}
