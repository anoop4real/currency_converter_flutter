
import 'exception_types.dart';

class ApplicationException implements Exception {
  ExceptionType _type = ExceptionType.unknownError;

  ApplicationException([this._type]);

  String toString() => _type.message();
}