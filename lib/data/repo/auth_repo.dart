import 'package:connect_app/data/api/connect_api.dart';
import 'package:connect_app/data/api/model/user_api_model.dart';

import '../api/token_provider.dart';

class AuthRepository {
  static const String tag = 'AuthRepository';

  final ConnectApi api;
  final TokenProvider tokenProvider;

  AuthRepository({required this.api, required this.tokenProvider});

  Future<bool> isAuthorized() async => tokenProvider.hasToken;

  Future<UserApiModel?> loginUser({
    required String email,
    required String password,
  }) async {
    final result = await api.loginUser(email: email, password: password);
    tokenProvider.setToken(result.token);
    return result.data?.userApiModel;
  }

  Future<UserApiModel?> me() async {
    final result = await api.currentUser();
    return result.data?.userApiModel;
  }


}
