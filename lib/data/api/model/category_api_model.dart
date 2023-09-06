import 'package:connect_app/data/api/model/model_converter.dart';

class CategoryApiModel extends ModelConverter<CategoryApiModel>{
 final String title;

  CategoryApiModel({required this.title});

 static CategoryApiModel fromJsonStatic(Map<String, dynamic> json) {
  return CategoryApiModel(title: json['title'] as String);
 }

  @override
  CategoryApiModel fromJson(Map<String, dynamic> json) {
    return fromJsonStatic(json);
  }
}