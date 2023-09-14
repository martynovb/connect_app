import 'package:connect_app/data/repo/auth_repo.dart';
import 'package:connect_app/domain/usecase/base_usecase.dart';

class LogoutUseCase extends BaseUseCase<Future<void>, void> {
  final AuthRepository authRepository;

  LogoutUseCase({required this.authRepository});

  @override
  Future<void> execute({void params}) async {
    await authRepository.logout();
  }
}
