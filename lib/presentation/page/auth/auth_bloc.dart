import 'package:connect_app/common/logger.dart';
import 'package:connect_app/domain/model/user_model.dart';
import 'package:connect_app/domain/usecase/login_user_usecase.dart';
import 'package:connect_app/domain/usecase/logout_usecase.dart';
import 'package:connect_app/domain/usecase/signup_business_usecase.dart';
import 'package:connect_app/domain/usecase/signup_user_usecase.dart';
import 'package:connect_app/presentation/page/base/base_bloc.dart';

class AuthBloc extends BaseBloc {
  static const _tag = 'AuthBloc';
  final LoginUserUseCase loginUserUseCase;
  final LogoutUseCase logoutUseCase;
  final SignUpUserUseCase signUpUserUseCase;
  final SignUpBusinessUseCase signUpBusinessUseCase;

  AuthBloc({
    required this.loginUserUseCase,
    required this.logoutUseCase,
    required this.signUpUserUseCase,
    required this.signUpBusinessUseCase,
  }) : super(DefaultState()) {
    on<LoginUserEvent>(runEvent(_loginUserEventHandler));
    on<LogoutEvent>(runEvent(_logoutEventHandler));
    on<SignUpUserEvent>(runEvent(
      _signUpUserEventHandler,
      errorHandler: validationErrorHandler,
    ));
    on<SignUpBusinessEvent>(runEvent(
      _signUpBusinessEventHandler,
      errorHandler: validationErrorHandler,
    ));
  }

  Future<void> _loginUserEventHandler(
    LoginUserEvent event,
    emit,
  ) async {
    emit(LoadingState());
    UserModel result = await loginUserUseCase.execute(
      params: LoginUserParams(
        email: event.email,
        password: event.password,
        repeatPassword: event.repeatPassword,
      ),
    );
    ConnectLogger.d(_tag, result);
    emit(PopCurrentRoute());
  }

  Future<void> _logoutEventHandler(LogoutEvent event, emit) async {
    emit(LoadingState());
    await logoutUseCase.execute();
    ConnectLogger.d(_tag, 'logout: success');
    emit(PopCurrentRoute());
  }

  Future<void> _signUpUserEventHandler(SignUpUserEvent event, emit) async {
    //emit(LoadingState());
    final result = signUpUserUseCase.execute(
      params: SignUpUserParams(
          email: event.email,
          fullName: event.fullName,
          password: event.password,
          repeatPassword: event.repeatPassword),
    );
    ConnectLogger.d(_tag, 'signUp user: success');
    //emit(PopCurrentRoute());
  }

  Future<void> _signUpBusinessEventHandler(
      SignUpBusinessEvent event, emit) async {
    //emit(LoadingState());
    final result = signUpBusinessUseCase.execute(
      params: SignUpBusinessParams(
          email: event.email,
          title: event.title,
          description: event.description,
          password: event.password,
          repeatPassword: event.repeatPassword),
    );
    ConnectLogger.d(_tag, 'signUp user: success');
    //emit(PopCurrentRoute());
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

class LogoutEvent extends AuthEvent {}

class SignUpUserEvent extends AuthEvent {
  final String? email;
  final String? fullName;
  final String? password;
  final String? repeatPassword;

  SignUpUserEvent({
    required this.email,
    required this.fullName,
    required this.password,
    required this.repeatPassword,
  });
}

class SignUpBusinessEvent extends AuthEvent {
  final String? email;
  final String? title;
  final String? description;
  final String? password;
  final String? repeatPassword;

  SignUpBusinessEvent({
    required this.email,
    required this.title,
    required this.description,
    required this.password,
    required this.repeatPassword,
  });
}

class ShowUserDataState extends AuthState {
  final UserModel userModel;

  ShowUserDataState(this.userModel);
}

class AuthorizedState extends AuthState {}
