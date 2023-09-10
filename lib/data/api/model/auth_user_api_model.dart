import 'package:connect_app/data/api/model/user_api_model.dart';

class AuthUserApiModel {
  final String? token;
  final DataUserApiModel? data;

  AuthUserApiModel({required this.token, required this.data});

  static AuthUserApiModel fromJson(Map<dynamic, dynamic> json) {
    return AuthUserApiModel(
      token: json['token'] as String?,
      data: DataUserApiModel.fromJson(json['data']),
    );
  }
}

class DataUserApiModel {
  final UserApiModel? userApiModel;

  DataUserApiModel({required this.userApiModel});

  static DataUserApiModel fromJson(Map<dynamic, dynamic> json) {
    return DataUserApiModel(userApiModel: UserApiModel.fromJson(json['user']));
  }
}
