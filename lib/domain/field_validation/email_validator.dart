import 'package:connect_app/domain/error_handler/exception.dart';
import 'package:connect_app/domain/field_validation/field_type.dart';
import 'package:connect_app/domain/field_validation/validation_error_code.dart';
import 'package:connect_app/domain/field_validation/validator.dart';

class EmailFieldValidator extends FieldValidator {
  static const maxSymbols = 16;
  static const minSymbols = 6;

  @override
  void validate(FieldType fieldType, String? value) {
    final email = value?.trim();

    if (fieldType != FieldType.EMAIL) {
      throw ValidationError(
        fieldType: FieldType.EMAIL,
        errorCode: ValidationErrorCode.WRONG_FIELD_TYPE,
        errorMessage: 'Wrong field type: $fieldType',
      );
    }

    if (email == null || email.isEmpty) {
      throw ValidationError(
        fieldType: FieldType.EMAIL,
        errorCode: ValidationErrorCode.INVALID_DATA,
        errorMessage: '$fieldType should not be empty or null',
      );
    }

    if (!email.contains('@') || !email.contains('.')) {
      throw ValidationError(
        fieldType: FieldType.EMAIL,
        errorCode: ValidationErrorCode.INVALID_DATA,
        errorMessage: 'Invalid data: $email, should contain @ and .(dot)',
      );
    }

    if (email.length > maxSymbols || email.length < minSymbols) {
      throw ValidationError(
        fieldType: FieldType.EMAIL,
        errorCode: ValidationErrorCode.LENGTH,
        errorMessage:
            'Length error: $email, maxSymbols =  $maxSymbols && minSymbols = $minSymbols',
      );
    }
  }
}
