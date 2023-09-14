import 'package:connect_app/data/api/connect_network_manager.dart';
import 'package:connect_app/data/api/model/auth_business_api_model.dart';
import 'package:connect_app/data/api/model/business_api_model.dart';
import 'package:connect_app/data/api/model/auth_user_api_model.dart';

class ConnectApi {
  final ConnectNetworkManager _networkManager;

  static const _businessApiPath = 'businesses';
  static const _authPath = 'auth/';

  ConnectApi(this._networkManager);

  /// *************************************************************
  /// AUTH API

  Future<dynamic> logout() => _networkManager.post('${_authPath}logout');

  Future<AuthUserApiModel> loginUser({
    required String email,
    required String password,
  }) =>
      _networkManager.post(
        '${_authPath}login/user',
        body: {
          'email': email,
          'password': password,
        },
      ).then(
        (result) => AuthUserApiModel.fromJson(result),
      );

  Future<AuthUserApiModel> currentUser() => _networkManager
      .get(
        'auth/profile/user',
      )
      .then(
        (result) => AuthUserApiModel.fromJson(result),
      );

  Future<AuthBusinessApiModel> loginBusiness({
    required String email,
    required String password,
  }) =>
      _networkManager.post(
        '${_authPath}login/businesses',
        body: {
          'email': email,
          'password': password,
        },
      ).then(
        (result) => AuthBusinessApiModel.fromJson(result),
      );

  /// *************************************************************
  /// BUSINESS API

  Future<List<BusinessApiModel>> getAllBusinesses() async {
    List<dynamic> result = await _networkManager.get(_businessApiPath);
    return result.map((object) => BusinessApiModel.fromJson(object)).toList();
  }
}
