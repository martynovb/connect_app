import 'package:connect_app/presentation/page/base/base_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaseBlocBuilder<BlocType extends BaseBloc> extends StatefulWidget {
  final BlocType? bloc;
  final Widget Function(BuildContext context, BaseState state) builder;
  final Widget? loadingWidget;
  final Widget? errorWidget;

  const BaseBlocBuilder({
    Key? key,
    required this.bloc,
    required this.builder,
    this.loadingWidget,
    this.errorWidget,
  }) : super(key: key);

  @override
  BaseBlocBuilderState createState() => BaseBlocBuilderState<BlocType>();
}

class BaseBlocBuilderState<BlocType extends BaseBloc> extends State<BaseBlocBuilder<BlocType>> {
  Route? _dialogRoute;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BlocType, BaseState>(
      bloc: widget.bloc,
      listener: _listener,
      builder: _builder,
    );
  }

  void _listener(BuildContext context, BaseState state) {
    if (state is LoadingState && _dialogRoute == null) {
      _showLoadingDialog(context, state.isCancelable);
    } else {
      _removeLoadingDialog(context);
    }

    if (state is NavigateToRoute) {
      Navigator.of(context).pushNamed(state.routeName);
    } else if (state is PopCurrentRoute) {
      state.routeName != null
          ? Navigator.of(context)
              .popUntil(ModalRoute.withName(state.routeName!))
          : Navigator.of(context).pop();
    }
  }

  Widget _builder(BuildContext context, BaseState state) {
    if (state is ErrorState) {
      return widget.errorWidget ??
          Center(child: Text('An error occurred: ${state.errorMessage}'));
    }
    return widget.builder(context, state);
  }

  void _showLoadingDialog(BuildContext context, bool isCancelable,
      [Duration? timeout = const Duration(seconds: 15)]) {
    _dialogRoute = PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return const ProgressDialog();
      },
      opaque: false,
    );

    Navigator.of(context).push(_dialogRoute!);
    if (timeout != null) {
      Future.delayed(timeout, () {
        _removeLoadingDialog(context);
      });
    }
  }

  void _removeLoadingDialog(BuildContext context) {
    if (_dialogRoute != null) {
      Navigator.of(context).removeRoute(_dialogRoute!);
      _dialogRoute = null;
    }
  }
}

class ProgressDialog extends StatelessWidget {
  const ProgressDialog({Key? key}) : super(key: key);

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
                child: const Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
