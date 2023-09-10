import 'package:bloc/bloc.dart';
import 'package:connect_app/domain/error_handler/exception.dart';

abstract class BaseBloc extends Bloc<BaseEvent, BaseState> {
  BaseBloc(super.initialState);

  Function(dynamic event, Emitter<BaseState> emit) runEvent<E extends BaseEvent>(Future<void> Function(E event, Emitter<BaseState> emit) eventFunction) {
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

  void dispose(){
    emit(DefaultState());
  }
}

abstract class BaseEvent {}

abstract class BaseState {}

class DefaultState extends BaseState {

}

class LoadingState extends BaseState {

}

class ErrorState extends BaseState {
  final String errorMessage;

  ErrorState(this.errorMessage);
}

