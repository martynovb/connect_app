import 'package:connect_app/data/api/connect_api.dart';
import 'package:connect_app/data/api/connect_http_client.dart';
import 'package:connect_app/data/api/token_provider.dart';
import 'package:connect_app/data/error_handler.dart';
import 'package:connect_app/data/repo/auth_repo.dart';
import 'package:connect_app/presentation/page/me/me_block.dart';
import 'package:get_it/get_it.dart';

class Injector {
    static const String _baseUrl = 'http://127.0.0.1:8000/api/';
    static const Map<String, String> _headers = {'Content-Type': 'application/json'};

  static inject(){
    final getIt = GetIt.instance;
    getIt.registerSingleton<AuthRepository>(AuthRepository());

    getIt.registerSingleton<MeBloc>(MeBloc(
      authRepository: GetIt.instance<AuthRepository>(),
    ));

    getIt.registerSingleton<ConnectApi>(ConnectApi(
      httpClient: getIt<ConnectHttpClient>(),
      errorHandler: getIt<ErrorHandler>(),
    ));

    getIt.registerSingleton<ConnectHttpClient>(ConnectHttpClient(
      baseUrl: _baseUrl,
      defaultHeaders: _headers,
      tokenProvider: getIt<TokenProvider>(),
    ));

    getIt.registerSingleton<TokenProvider>(TokenProvider());
  }
}

