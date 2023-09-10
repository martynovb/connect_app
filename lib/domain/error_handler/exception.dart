import 'package:connect_app/domain/field_validation/field_type.dart';
import 'package:connect_app/domain/field_validation/validation_error_code.dart';

class BaseException implements Exception {
  final String errorMessage;

  BaseException(this.errorMessage);
}

class ValidationError extends BaseException {
  final FieldType fieldType;
  final ValidationErrorCode errorCode;

  ValidationError({
    required this.fieldType,
    required this.errorCode,
    required String errorMessage,
  }) : super(errorMessage);
}
