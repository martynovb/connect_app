import 'package:connect_app/data/api/model/user_api_model.dart';

class UserModel {
  final int id;
  final String email;
  final String fullName;

  UserModel.fromApiModel(UserApiModel? apiModel)
      : id = apiModel?.id ?? -1,
        email = apiModel?.email ?? '',
        fullName = apiModel?.fullName ?? '';

  UserModel.empty()
      : id = -1,
        email = '',
        fullName = '';
}
