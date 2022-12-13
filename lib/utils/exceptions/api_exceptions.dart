import 'base.dart';

class ApiException extends AppException implements Exception {
  const ApiException({
    super.code,
    super.message,
    super.defaultMessage = 'Failed to communicate with the server.',
  });
}

class UnauthorizedException extends ApiException {
  const UnauthorizedException({super.message})
      : super(
          code: '401',
          defaultMessage: 'Not authenticated.',
        );
}

class ForbiddenException extends ApiException {
  const ForbiddenException({super.message})
      : super(
          code: '403',
          defaultMessage: 'You do not have permission to perform the specified operation.',
        );
}

class ApiNotFoundException extends ApiException {
  const ApiNotFoundException({super.message})
      : super(
          code: '404',
          defaultMessage: 'The requested API was not found.',
        );
}


class ApiTimeoutException extends ApiException {
  const ApiTimeoutException({super.message})
      : super(
          defaultMessage: 'API Communication timed out. '
               'Please check the communication environment and try again.',
        );
}

class NetworkNotConnectedException extends ApiException {
  const NetworkNotConnectedException({super.message})
      : super(
          defaultMessage: 'No network connection.',
        );
}
