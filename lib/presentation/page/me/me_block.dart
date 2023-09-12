import 'package:connect_app/domain/model/user_model.dart';
import 'package:connect_app/domain/usecase/get_current_user_usecase.dart';
import 'package:connect_app/presentation/page/base/base_bloc.dart';

class MeBloc extends BaseBloc {
  final GetCurrentUserUseCase getCurrentUserUseCase;

  MeBloc({required this.getCurrentUserUseCase}) : super(LoadingState()) {
    on<IsAuthorizedEvent>(runEvent(
      _isAuthorizedEventHandler,
      errorHandler: (emit, error) {
        emit(UnauthorizedState());
      },
    ));
  }

  Future<void> _isAuthorizedEventHandler(event, emit) async {
    emit(LoadingState());
    UserModel? result = await getCurrentUserUseCase.execute();
    emit(result != null ? AuthorizedState(result) : UnauthorizedState());
  }
}

abstract class MeEvent extends BaseEvent {}

abstract class MeState extends BaseState {}

class IsAuthorizedEvent extends MeEvent {}

class UnauthorizedState extends MeState {}

class AuthorizedState extends MeState {
  final UserModel userModel;

  AuthorizedState(this.userModel);
}
