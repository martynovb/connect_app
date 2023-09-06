import 'package:connect_app/data/api/model/model_converter.dart';

class UserApiModel extends ModelConverter<UserApiModel> {
  final int id;
  final String email;
  final String fullName;

  UserApiModel({
    required this.id,
    required this.email,
    required this.fullName,
  });

  static UserApiModel fromJsonStatic(Map<String, dynamic> json) {
    return UserApiModel(
      id: json['id'] as int,
      email: json['email'] as String,
      fullName: json['fullName'] as String,
    );
  }

  @override
  UserApiModel fromJson(Map<String, dynamic> json) {
    return fromJsonStatic(json);
  }
}
