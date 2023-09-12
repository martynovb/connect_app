import 'package:connect_app/presentation/page/base/base_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class BaseBlocBuilder<BlocType extends BaseBloc> extends StatelessWidget {
  final BlocType? bloc;
  final Widget Function(BuildContext context, BaseState state) builder;
  final Widget? loadingWidget;
  final Widget? errorWidget;
  Route? _dialogRoute;

  BaseBlocBuilder({
    Key? key,
    this.bloc,
    required this.builder,
    this.loadingWidget,
    this.errorWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BlocType, BaseState>(
      listener: (context, state) {
        if (state is LoadingState) {
          showMyDialog(context, state.isCancelable);
        } else {
          if (_dialogRoute != null && Navigator.of(context).canPop()) {
            Navigator.of(context).removeRoute(_dialogRoute!);
          }
        }

        if (state is NavigateToRoute) {
          Navigator.of(context).pushNamed(state.routeName);
        } else if (state is PopCurrentRoute) {
          state.routeName != null
              ? Navigator.of(context)
                  .popUntil(ModalRoute.withName(state.routeName!))
              : Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        if (state is ErrorState) {
          return errorWidget ??
              Center(child: Text('An error occurred: ${state.errorMessage}'));
        }
        return builder(context, state);
      },
    );
  }

  void showMyDialog(BuildContext context, bool isCancelable, [Duration? timeout = const Duration(seconds: 30)] ) {
    _dialogRoute = PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return const FullScreenProgressDialog();
      },
      opaque: false,
    );

    Navigator.of(context).push(_dialogRoute!);
    if (timeout != null) {
      Future.delayed(timeout, () {
        if (_dialogRoute != null && Navigator.of(context).canPop()) {
          Navigator.of(context).removeRoute(_dialogRoute!);
        }
      });
    }
  }
}

class FullScreenProgressDialog extends StatelessWidget {
  const FullScreenProgressDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: () {},
              behavior: HitTestBehavior.translucent,
            ),
          ),
          Center(
            child: WillPopScope(
              onWillPop: () async => false,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
