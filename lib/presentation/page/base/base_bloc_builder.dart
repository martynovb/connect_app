import 'package:connect_app/presentation/page/base/base_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class BaseBlocBuilder<BlocType extends BaseBloc> extends StatelessWidget {
  final BlocType? bloc;
  final Widget Function(BuildContext context, BaseState state) builder;
  final Widget? loadingWidget;
  final Widget? errorWidget;

  const BaseBlocBuilder({
    Key? key,
    this.bloc,
    required this.builder,
    this.loadingWidget,
    this.errorWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocType, BaseState>(
      bloc: bloc ?? GetIt.instance<BlocType>(),
      builder: (context, state) {
        if (state is LoadingState) {
          return loadingWidget ?? const Center(child: CircularProgressIndicator());
        }
        if (state is ErrorState) {
          return errorWidget ?? Center(child: Text('An error occurred: ${state.errorMessage}'));
        }
        return builder(context, state);
      },
    );
  }
}