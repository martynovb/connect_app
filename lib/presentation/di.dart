import 'package:connect_app/data/api/connect_api.dart';
import 'package:connect_app/data/api/connect_network_manager.dart';
import 'package:connect_app/data/api/connect_http_client.dart';
import 'package:connect_app/data/api/token_provider.dart';
import 'package:connect_app/data/error_handler.dart';
import 'package:connect_app/data/repo/auth_repo.dart';
import 'package:connect_app/data/repo/business_repo.dart';
import 'package:connect_app/domain/field_validation/email_validator.dart';
import 'package:connect_app/domain/usecase/get_all_business_usecase.dart';
import 'package:connect_app/domain/usecase/get_current_user_usecase.dart';
import 'package:connect_app/domain/usecase/login_user_usecase.dart';
import 'package:connect_app/domain/usecase/logout_usecase.dart';
import 'package:connect_app/presentation/page/auth/auth_bloc.dart';
import 'package:connect_app/presentation/page/home/home_bloc.dart';
import 'package:connect_app/presentation/page/me/me_block.dart';
import 'package:get_it/get_it.dart';

class Injector {
  static final _getIt = GetIt.instance;
  static const String _baseUrl =
      'http://10.0.2.2:8000/api/'; //10.0.2.2 // 127.0.0.1
  static const Map<String, String> _headers = {
    'Content-Type': 'application/json'
  };

  static inject() {
    _injectDataLayer();
    _injectDomainLayer();
    _injectBloC();
  }

  static _injectDataLayer() {
    _getIt.registerSingleton<TokenProvider>(TokenProvider());
    _getIt.registerSingleton<ErrorHandler>(ErrorHandler(tokenProvider: _getIt<TokenProvider>()));
    _getIt.registerSingleton<ConnectHttpClient>(ConnectHttpClient(
      baseUrl: _baseUrl,
      defaultHeaders: _headers,
      tokenProvider: _getIt<TokenProvider>(),
    ));
    _getIt.registerSingleton<ConnectNetworkManager>(ConnectNetworkManager(
      httpClient: _getIt<ConnectHttpClient>(),
      errorHandler: _getIt<ErrorHandler>(),
    ));

    _getIt.registerSingleton<ConnectApi>(
        ConnectApi(_getIt<ConnectNetworkManager>()));

    _getIt.registerSingleton<BusinessRepository>(BusinessRepository(
      api: _getIt<ConnectApi>(),
    ));

    _getIt.registerSingleton<AuthRepository>(AuthRepository(
      api: _getIt<ConnectApi>(),
      tokenProvider: _getIt<TokenProvider>(),
    ));
  }

  static _injectDomainLayer() {
    _getIt.registerSingleton<EmailFieldValidator>(EmailFieldValidator());

    _getIt.registerSingleton<LogoutUseCase>(
      LogoutUseCase(authRepository: _getIt<AuthRepository>()),
    );

    _getIt.registerSingleton<GetCurrentUserUseCase>(
      GetCurrentUserUseCase(authRepository: _getIt<AuthRepository>()),
    );

    _getIt.registerSingleton<GetAllBusinessUseCase>(
      GetAllBusinessUseCase(businessRepository: _getIt<BusinessRepository>()),
    );

    _getIt.registerSingleton<LoginUserUseCase>(LoginUserUseCase(
      authRepository: _getIt<AuthRepository>(),
      emailFieldValidator: _getIt<EmailFieldValidator>(),
    ));
  }

  static _injectBloC() {
    _getIt.registerSingleton<AuthBloc>(AuthBloc(
      loginUserUseCase: _getIt<LoginUserUseCase>(),
      logoutUseCase: _getIt<LogoutUseCase>(),
    ));

    _getIt.registerSingleton<MeBloc>(MeBloc(
      getCurrentUserUseCase: _getIt<GetCurrentUserUseCase>(),
    ));
    _getIt.registerSingleton<HomeBloc>(HomeBloc(
      getAllBusinessUseCase: _getIt<GetAllBusinessUseCase>(),
    ));
  }
}
