import 'package:connect_app/data/repo/auth_repo.dart';
import 'package:connect_app/domain/field_validation/email_validator.dart';
import 'package:connect_app/domain/field_validation/field_type.dart';
import 'package:connect_app/domain/model/user_model.dart';
import 'package:connect_app/domain/usecase/base_usecase.dart';

class LoginUserUseCase extends BaseUseCase<Future<UserModel>, LoginUserParams> {
  final AuthRepository authRepository;
  final EmailFieldValidator emailFieldValidator;

  LoginUserUseCase({
    required this.authRepository,
    required this.emailFieldValidator,
  });

  @override
  Future<UserModel> execute({LoginUserParams? params}) async {
    emailFieldValidator.validate(FieldType.EMAIL, params?.email);
    return authRepository
        .loginUser(email: params!.email, password: params.password)
        .then(
          (user) => UserModel.fromApiModel(user),
        );
  }
}

class LoginUserParams {
  final String email;
  final String password;
  final String repeatPassword;

  LoginUserParams({
    required this.email,
    required this.password,
    required this.repeatPassword,
  });
}
