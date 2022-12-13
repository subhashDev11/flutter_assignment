import '../constants/map.dart';
import '../constants/string.dart';

Map<String, dynamic> toResponseJson(dynamic data) {
  if (data == null) {
    return emptyMap;
  }
  if (data is List) {
    return <String, dynamic>{'items': data};
  }
  if (data is Map) {
    return data as Map<String, dynamic>;
  }
  return emptyMap;
}

enum ErrorCode {
  networkNotConnected,
}

enum FetchResponseError {
  none(message: ''),
  emptyQ(message: emptyQMessage),
  pageNotValid(message: 'Incorrect page number.'),
  perPageNotValid(message: 'Incorrect count per page.'),
  apiError(message: 'Failed to search repository.'),

  other(message: 'An error has occurred Please revise your search conditions.');

  const FetchResponseError({required this.message});

  final String message;
}
