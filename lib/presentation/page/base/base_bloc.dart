import 'package:bloc/bloc.dart';
import 'package:connect_app/common/logger.dart';
import 'package:connect_app/domain/error_handler/exception.dart';

typedef EventFunction = Future<void> Function(
    dynamic event, Emitter<BaseState> emit);
typedef ErrorHandlerFunction = void Function(Emitter<BaseState> emit, dynamic error);

abstract class BaseBloc extends Bloc<BaseEvent, BaseState> {
  BaseBloc(super.initialState);

  EventFunction runEvent<E extends BaseEvent>(
    Future<void> Function(E event, Emitter<BaseState> emit) eventFunction, {
    ErrorHandlerFunction? errorHandler,
  }) {
    return (dynamic event, Emitter<BaseState> emit) async {
      try {
        await eventFunction(event, emit);
      } catch (error) {
        if (errorHandler != null) {
          errorHandler(emit, error);
        } else {
          handleError(emit, error);
        }
      }
    };
  }

  void handleError(Emitter<BaseState> emit, error) {
    ConnectLogger.e('BaseBloc', error.toString());
    if (error is BaseException) {
      emit(ErrorState(error.errorMessage));
    } else {
      emit(ErrorState(error.toString()));
    }
  }

  void dispose() {
    emit(DefaultState());
  }
}

abstract class BaseEvent {}

abstract class BaseState {}

class DefaultState extends BaseState {}

class LoadingState extends BaseState {
  final bool isCancelable;

  LoadingState({this.isCancelable = false});
}

class ErrorState extends BaseState {
  final String errorMessage;

  ErrorState(this.errorMessage);
}

class NavigateToRoute extends BaseState {
  final String routeName;

  NavigateToRoute(this.routeName);
}

class PopCurrentRoute extends BaseState {
  final String? routeName;

  PopCurrentRoute({this.routeName});
}
