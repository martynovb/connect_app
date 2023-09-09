
import 'package:connect_app/data/api/model/business_api_model.dart';
import 'package:connect_app/domain/model/category_model.dart';
import 'package:connect_app/domain/model/user_model.dart';

class BusinessModel {
  final UserModel userModel;
  final CategoryModel categoryModel;
  final String title;
  final String description;

  BusinessModel.fromApiModel(BusinessApiModel apiModel)
      : userModel = apiModel.userApiModel != null ? UserModel.fromApiModel(apiModel.userApiModel!) : UserModel.empty(),
        categoryModel = apiModel.categoryApiModel != null ? CategoryModel.fromApiModel(apiModel.categoryApiModel!) : CategoryModel.empty(),
        title = apiModel.title ?? '',
        description = apiModel.description ?? '';
}
