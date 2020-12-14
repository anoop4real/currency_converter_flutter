enum ExceptionType {
  requestCancelled,
  requestTimeout,
  noInternetConnection,
  timeout,
  unauthorisedRequest,
  badRequest,
  notFound,
  internalServerError,
  serviceUnavailable,
  unknownError,
  formatException
}

extension ExceptionTypeExtension on ExceptionType {
 // TODO: Add messages
  String message() {
    switch (this) {

      case ExceptionType.requestCancelled:
        // TODO: Handle this case.
        break;
      case ExceptionType.requestTimeout:
        // TODO: Handle this case.
        break;
      case ExceptionType.noInternetConnection:
        // TODO: Handle this case.
        break;
      case ExceptionType.timeout:
        // TODO: Handle this case.
        break;
      case ExceptionType.unauthorisedRequest:
        // TODO: Handle this case.
        break;
      case ExceptionType.notFound:
        // TODO: Handle this case.
        break;
      case ExceptionType.internalServerError:
        // TODO: Handle this case.
        break;
      case ExceptionType.serviceUnavailable:
        // TODO: Handle this case.
        break;
      case ExceptionType.unknownError:
        return ("UnknownError");
        break;
      case ExceptionType.formatException:
        // TODO: Handle this case.
        break;
      case ExceptionType.badRequest:
        break;
    }
  }
}