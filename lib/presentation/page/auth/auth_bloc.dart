import 'package:connect_app/common/logger.dart';
import 'package:connect_app/domain/model/user_model.dart';
import 'package:connect_app/domain/usecase/login_user_usecase.dart';
import 'package:connect_app/presentation/page/base/base_bloc.dart';
import 'package:connect_app/presentation/page/router/router.dart';

class AuthBloc extends BaseBloc {
  static const _tag = 'AuthBloc';
  final LoginUserUseCase loginUserUseCase;

  AuthBloc({required this.loginUserUseCase}) : super(DefaultState()) {
    on<LoginUserEvent>(runEvent(_loginUserEventHandler));
  }

  Future<void> _loginUserEventHandler(LoginUserEvent event, emit) async {
    emit(LoadingState());
    UserModel result = await loginUserUseCase.execute(
      params: LoginUserParams(
        email: event.email,
        password: event.password,
        repeatPassword: event.repeatPassword,
      ),
    );
    ConnectLogger.d(_tag, result);
    emit(PopCurrentRoute(routeName: AppRouter.mePage));
  }
}

abstract class AuthEvent extends BaseEvent {}

abstract class AuthState extends BaseState {}

class LoginUserEvent extends AuthEvent {
  final String email;
  final String password;
  final String repeatPassword;

  LoginUserEvent({
    required this.email,
    required this.password,
    required this.repeatPassword,
  });
}

class ShowUserDataState extends AuthState {
  final UserModel userModel;

  ShowUserDataState(this.userModel);
}

class AuthorizedState extends AuthState {}
