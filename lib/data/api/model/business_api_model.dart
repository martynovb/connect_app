import 'package:connect_app/data/api/model/category_api_model.dart';
import 'package:connect_app/data/api/model/user_api_model.dart';

class BusinessApiModel {
  final UserApiModel? userApiModel;
  final CategoryApiModel? categoryApiModel;
  final String? title;
  final String? description;

  BusinessApiModel({
    required this.userApiModel,
    required this.categoryApiModel,
    required this.title,
    required this.description,
  });

  static BusinessApiModel fromJson(Map<dynamic, dynamic> json) {
    return BusinessApiModel(
      userApiModel: UserApiModel.fromJson(json['user'] as Map<dynamic, dynamic>),
      categoryApiModel:
          CategoryApiModel.fromJson(json['category'] as Map<dynamic, dynamic>),
      title: json['title'] as String?,
      description: json['description'] as String?,
    );
  }
}
