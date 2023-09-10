import 'package:connect_app/data/api/model/business_api_model.dart';

class AuthBusinessApiModel {
  final String? token;
  final DataBusinessApiModel? data;

  AuthBusinessApiModel({required this.token, required this.data});

  static AuthBusinessApiModel fromJson(Map<dynamic, dynamic> json) {
    return AuthBusinessApiModel(
      token: json['token'] as String?,
      data: DataBusinessApiModel.fromJson(json['data']),
    );
  }
}

class DataBusinessApiModel {
  final BusinessApiModel? businessApiModel;

  DataBusinessApiModel({required this.businessApiModel});

  static DataBusinessApiModel fromJson(Map<dynamic, dynamic> json) {
    return DataBusinessApiModel(
        businessApiModel: BusinessApiModel.fromJson(json));
  }
}
