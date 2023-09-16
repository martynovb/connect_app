import 'package:connect_app/domain/error_handler/exception.dart';
import 'package:connect_app/domain/field_validation/field_type.dart';
import 'package:connect_app/domain/field_validation/validation_error_code.dart';
import 'package:connect_app/domain/field_validation/validator.dart';

class BusinessDescriptionFieldValidator extends FieldValidator {
  static const maxSymbols = 16;
  static const minSymbols = 6;

  @override
  void validate(String? value) {
    final fieldText = value?.trim();

    if (fieldText == null || fieldText.isEmpty) {
      throw ValidationError(
        fieldType: this.fieldType,
        errorCode: ValidationErrorCode.INVALID_DATA,
        errorMessage: 'Title should not be empty',
      );
    }
    if (fieldText.length > maxSymbols || fieldText.length < minSymbols) {
      throw ValidationError(
        fieldType: this.fieldType,
        errorCode: ValidationErrorCode.LENGTH,
        errorMessage:
            'Title must be between $minSymbols and $maxSymbols characters.',
      );
    }
  }

  @override
  FieldType get fieldType => FieldType.businessDescription;
}
