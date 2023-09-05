import 'package:bloc/bloc.dart';
import 'package:connect_app/domain/error_handler/exception.dart';

abstract class BaseBloc extends Bloc<BaseEvent, BaseState> {
  BaseBloc(super.initialState);

  Function(dynamic event, Emitter<BaseState> emit) runEvent(Future<void> Function(dynamic event, Emitter<BaseState> emit) eventFunction) {
    return (dynamic event, Emitter<BaseState> emit) async {
      try {
        await eventFunction(event, emit);
      } on BaseException catch (ex) {
        emit(ErrorState(ex.errorMessage));
      } catch (e) {
        // Handle other exceptions and possibly emit another state or log them
      }
    };
  }
}

abstract class BaseEvent {}

abstract class BaseState {}

class LoadingState extends BaseState {}

class ErrorState extends BaseState {
  final String errorMessage;

  ErrorState(this.errorMessage);
}
