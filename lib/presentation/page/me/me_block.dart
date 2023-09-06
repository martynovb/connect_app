import 'package:connect_app/data/repo/auth_repo.dart';
import 'package:connect_app/presentation/page/base/base_bloc.dart';

class MeBloc extends BaseBloc {
  final AuthRepository authRepository;

  MeBloc({required this.authRepository}) : super(LoadingState()) {
    on<IsAuthorizedEvent>(runEvent(_isAuthorizedEventHandler));
  }

  Future<void> _isAuthorizedEventHandler(event, emit) async {
    emit(LoadingState());
    bool result = await authRepository.isAuthorized();
    emit(result ? AuthorizedState() : UnauthorizedState());
  }
}

abstract class MeEvent extends BaseEvent {}

abstract class MeState extends BaseState {}

class IsAuthorizedEvent extends MeEvent {}

class UnauthorizedState extends MeState {}

class AuthorizedState extends MeState {}
