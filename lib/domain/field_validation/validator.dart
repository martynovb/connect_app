import 'package:connect_app/domain/field_validation/field_type.dart';

abstract class FieldValidator {
  void validate(FieldType fieldType, String? value);
}