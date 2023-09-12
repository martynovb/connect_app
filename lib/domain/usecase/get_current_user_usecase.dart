import 'package:connect_app/data/repo/auth_repo.dart';
import 'package:connect_app/data/repo/business_repo.dart';
import 'package:connect_app/domain/model/user_model.dart';
import 'package:connect_app/domain/usecase/base_usecase.dart';

class GetCurrentUserUseCase extends BaseUseCase<Future<UserModel?>, void> {
  final AuthRepository authRepository;

  GetCurrentUserUseCase({
    required this.authRepository,
  });

  @override
  Future<UserModel?> execute({void params}) async {
    final data = await authRepository.me();
    if (data == null) {
      return null;
    }
    return UserModel.fromApiModel(data);
  }
}
