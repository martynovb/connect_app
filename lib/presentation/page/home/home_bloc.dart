import 'package:connect_app/domain/model/business_model.dart';
import 'package:connect_app/domain/usecase/get_all_business_usecase.dart';
import 'package:connect_app/presentation/page/base/base_bloc.dart';

class HomeBloc extends BaseBloc {
  final GetAllBusinessUseCase getAllBusinessUseCase;

  HomeBloc({required this.getAllBusinessUseCase}) : super(LoadingState()) {
    on<ShowHomeDataEvent>(runEvent(_showBusinessesListHandler));
  }

  Future<void> _showBusinessesListHandler(event, emit) async {
    emit(LoadingState());
    var result = await getAllBusinessUseCase.execute();
    emit(ShowBusinessesListState(result));
  }
}

abstract class HomeEvent extends BaseEvent {}

abstract class HomeState extends BaseState {}

class ShowHomeDataEvent extends HomeEvent {}

class ShowBusinessesListState extends HomeState {
  final List<BusinessModel> businesses;

  ShowBusinessesListState(this.businesses);
}

class AuthorizedState extends HomeState {}
