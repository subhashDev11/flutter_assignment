class AppException implements Exception {
  const AppException({
    this.code,
    this.message,
    this.defaultMessage = 'An error occurred.',
  });

  final String? code;

  final String? message;

  final String defaultMessage;

  @override
  String toString() {
    if (code == null) {
      return message ?? defaultMessage;
    }
    return '[$code] ${message ?? defaultMessage}';
  }
}
