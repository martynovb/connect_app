import 'package:connect_app/data/repo/auth_repo.dart';
import 'package:connect_app/domain/error_handler/exception.dart';
import 'package:connect_app/domain/field_validation/email_validator.dart';
import 'package:connect_app/domain/field_validation/field_type.dart';
import 'package:connect_app/domain/field_validation/fullname_field_validator.dart';
import 'package:connect_app/domain/field_validation/password_validator.dart';
import 'package:connect_app/domain/field_validation/repeat_password_validator.dart';
import 'package:connect_app/domain/model/user_model.dart';
import 'package:connect_app/domain/usecase/base_usecase.dart';

class SignUpUserUseCase
    extends BaseUseCase<Future<UserModel>, SignUpUserParams> {
  final AuthRepository authRepository;
  final EmailFieldValidator emailFieldValidator;
  final FullNameFieldValidator fullNameFieldValidator;
  final PasswordFieldValidator passwordFieldValidator;
  final RepeatPasswordFieldValidator repeatPasswordFieldValidator;

  SignUpUserUseCase({
    required this.authRepository,
    required this.emailFieldValidator,
    required this.fullNameFieldValidator,
    required this.passwordFieldValidator,
    required this.repeatPasswordFieldValidator,
  });

  @override
  Future<UserModel> execute({SignUpUserParams? params}) async {
    Map<FieldType, ValidationError> errorMap = {};

    try {
      emailFieldValidator.validate(params?.email);
    } catch (e) {
      if (e is ValidationError) {
        errorMap[emailFieldValidator.fieldType] = e;
      }
    }

    try {
      fullNameFieldValidator.validate(params?.fullName);
    } catch (e) {
      if (e is ValidationError) {
        errorMap[fullNameFieldValidator.fieldType] = e;
      }
    }

    try {
      passwordFieldValidator.validate(params?.password);
    } catch (e) {
      if (e is ValidationError) {
        errorMap[passwordFieldValidator.fieldType] = e;
      }
    }

    try {
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
      throw errorMap;
    }

    return UserModel.empty();
  }
}

class SignUpUserParams {
  final String? email;
  final String? fullName;
  final String? password;
  final String? repeatPassword;

  SignUpUserParams({
    required this.email,
    required this.fullName,
    required this.password,
    required this.repeatPassword,
  });
}
