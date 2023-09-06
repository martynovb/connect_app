import 'package:connect_app/data/api/model/category_api_model.dart';
import 'package:connect_app/data/api/model/model_converter.dart';
import 'package:connect_app/data/api/model/user_api_model.dart';

class BusinessApiModel extends ModelConverter<BusinessApiModel> {
  final UserApiModel userApiModel;
  final CategoryApiModel categoryApiModel;
  final String title;
  final String description;

  BusinessApiModel({
    required this.userApiModel,
    required this.categoryApiModel,
    required this.title,
    required this.description,
  });

  @override
  BusinessApiModel fromJson(Map<String, dynamic> json) {
    return BusinessApiModel(
      userApiModel: UserApiModel.fromJsonStatic(json['user'] as Map<String, dynamic>),
      categoryApiModel:
          CategoryApiModel.fromJsonStatic(json['category'] as Map<String, dynamic>),
      title: json['title'] as String,
      description: json['description'] as String,
    );
  }
}
