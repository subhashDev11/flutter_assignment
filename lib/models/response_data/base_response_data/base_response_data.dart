import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../constants/map.dart';
import '../../../utils/api.dart';
import '../../json_converter.dart';

part 'base_response_data.freezed.dart';
part 'base_response_data.g.dart';

@freezed
class BaseResponseData with _$BaseResponseData {
  const factory BaseResponseData({
    @Default(true) bool success,
    @Default('') String message,
    @Default(emptyMap) @BaseResponseDataConverter() Map<String, dynamic> data,
  }) = _BaseResponseData;

  factory BaseResponseData.fromJson(Map<String, dynamic> json) => _$BaseResponseDataFromJson(json);

  factory BaseResponseData.fromDynamic(dynamic responseData) {
    final data = toResponseJson(responseData);
    final baseData = <String, dynamic>{
      'success': data['success'] ?? true,
      'message': data['message'] ?? '',
    };
    data.removeWhere((key, dynamic value) => baseData.containsKey(key));
    final keys = data.keys;
    if (keys.isEmpty) {
      return BaseResponseData.fromJson(baseData);
    }
    if (keys.length == 1) {
      return BaseResponseData.fromJson(<String, dynamic>{
        ...baseData,
        'data': data[data.keys.first],
      });
    }
    return BaseResponseData.fromJson(<String, dynamic>{
      ...baseData,
      'data': <String, dynamic>{
        for (final k in data.keys) ...<String, dynamic>{k: data[k]},
      },
    });
  }
}
