import 'package:connect_app/domain/error_handler/exception.dart';
import 'package:connect_app/domain/field_validation/field_type.dart';
import 'package:connect_app/domain/field_validation/validation_error_code.dart';
import 'package:connect_app/domain/field_validation/validator.dart';

class EmailFieldValidator extends FieldValidator {
  static const maxSymbols = 16;
  static const minSymbols = 6;
  final _emailPattern = RegExp(r'^[^@]+@[^@]+\.[^@]+$');

  @override
  FieldType get fieldType => FieldType.email;

  @override
  void validate(String? value) {
    final email = value?.trim();

    if (email == null || email.isEmpty) {
      throw ValidationError(
        fieldType: fieldType,
        errorCode: ValidationErrorCode.INVALID_DATA,
        errorMessage: 'Email field cannot be empty.',
      );
    }
    if (!email.contains('@')) {
      throw ValidationError(
        fieldType: fieldType,
        errorCode: ValidationErrorCode.INVALID_DATA,
        errorMessage: 'Email must contain an "@" symbol.',
      );
    }
    if (!email.contains('.')) {
      throw ValidationError(
        fieldType: fieldType,
        errorCode: ValidationErrorCode.INVALID_DATA,
        errorMessage: 'Email must contain a "." symbol.',
      );
    }
    if (email.startsWith('@') || email.endsWith('@')) {
      throw ValidationError(
        fieldType: fieldType,
        errorCode: ValidationErrorCode.INVALID_DATA,
        errorMessage: 'Invalid position for "@" symbol.',
      );
    }
    if (email.startsWith('.') || email.endsWith('.')) {
      throw ValidationError(
        fieldType: fieldType,
        errorCode: ValidationErrorCode.INVALID_DATA,
        errorMessage: 'Invalid position for "." symbol.',
      );
    }

    if (!_emailPattern.hasMatch(email)) {
      throw ValidationError(
        fieldType: fieldType,
        errorCode: ValidationErrorCode.INVALID_DATA,
        errorMessage:
            'Invalid email format. Ensure correct arrangement of "@" and "." symbols.',
      );
    }

    if (email.length > maxSymbols || email.length < minSymbols) {
      throw ValidationError(
        fieldType: fieldType,
        errorCode: ValidationErrorCode.LENGTH,
        errorMessage:
            'Length error: $email, maxSymbols =  $maxSymbols && minSymbols = $minSymbols',
      );
    }
  }
}
