import 'package:connect_app/data/repo/auth_repo.dart';
import 'package:connect_app/domain/error_handler/exception.dart';
import 'package:connect_app/domain/field_validation/business_description_field_validator.dart';
import 'package:connect_app/domain/field_validation/business_title_field_validator.dart';
import 'package:connect_app/domain/field_validation/email_validator.dart';
import 'package:connect_app/domain/field_validation/field_type.dart';
import 'package:connect_app/domain/field_validation/password_validator.dart';
import 'package:connect_app/domain/field_validation/repeat_password_validator.dart';
import 'package:connect_app/domain/model/user_model.dart';
import 'package:connect_app/domain/usecase/base_usecase.dart';

class SignUpBusinessUseCase
    extends BaseUseCase<Future<UserModel>, SignUpBusinessParams> {
  final AuthRepository authRepository;
  final EmailFieldValidator emailFieldValidator;
  final BusinessTitleFieldValidator businessTitleFieldValidator;
  final BusinessDescriptionFieldValidator businessDescriptionFieldValidator;
  final PasswordFieldValidator passwordFieldValidator;
  final RepeatPasswordFieldValidator repeatPasswordFieldValidator;

  SignUpBusinessUseCase({
    required this.authRepository,
    required this.emailFieldValidator,
    required this.businessTitleFieldValidator,
    required this.businessDescriptionFieldValidator,
    required this.passwordFieldValidator,
    required this.repeatPasswordFieldValidator,
  });

  @override
  Future<UserModel> execute({SignUpBusinessParams? params}) async {
    Map<FieldType, ValidationError> errorMap = {};

    try {
      emailFieldValidator.validate(params?.email);
    } catch (e) {
      if (e is ValidationError) {
        errorMap[emailFieldValidator.fieldType] = e;
      }
    }

    try {
      businessTitleFieldValidator.validate(params?.title);
    } catch (e) {
      if (e is ValidationError) {
        errorMap[businessTitleFieldValidator.fieldType] = e;
      }
    }

    try {
      businessDescriptionFieldValidator.validate(params?.description);
    } catch (e) {
      if (e is ValidationError) {
        errorMap[businessDescriptionFieldValidator.fieldType] = e;
      }
    }

    try {
      passwordFieldValidator.validate(
        params?.password,
      );
    } catch (e) {
      if (e is ValidationError) {
        errorMap[passwordFieldValidator.fieldType] = e;
      }
    }

    try {
      repeatPasswordFieldValidator.validate(
        params?.repeatPassword,
      );
      repeatPasswordFieldValidator.validateRepeatPassword(
        params?.password,
        params?.repeatPassword,
      );
    } catch (e) {
      if (e is ValidationError) {
        errorMap[repeatPasswordFieldValidator.fieldType] = e;
      }
    }

    if (errorMap.isNotEmpty) {
      throw ValidationErrorsMap(errorMap: errorMap);
    }

    return UserModel.empty();
  }
}

class SignUpBusinessParams {
  final String? email;
  final String? title;
  final String? description;
  final String? password;
  final String? repeatPassword;

  SignUpBusinessParams({
    required this.email,
    required this.title,
    required this.description,
    required this.password,
    required this.repeatPassword,
  });
}
