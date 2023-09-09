import 'package:connect_app/data/api/model/category_api_model.dart';

class CategoryModel {
  final String title;

  CategoryModel.fromApiModel(CategoryApiModel apiModel)
      : title = apiModel.title ?? '';

  CategoryModel.empty() : title = '';
}
