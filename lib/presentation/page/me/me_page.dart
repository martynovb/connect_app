import 'package:connect_app/presentation/connect_app.dart';
import 'package:connect_app/presentation/page/auth/login_user_page.dart';
import 'package:connect_app/presentation/page/base/base_bloc.dart';
import 'package:connect_app/presentation/page/base/base_bloc_builder.dart';
import 'package:connect_app/presentation/page/me/me_block.dart';
import 'package:connect_app/presentation/page/router/router.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class MePage extends StatefulWidget {
  const MePage({Key? key}) : super(key: key);

  @override
  State<MePage> createState() => _MePageState();
}

class _MePageState extends State<MePage> with RouteAware {
  late MeBloc meBloc;

  @override
  void didPopNext() {
    super.didPopNext();
    meBloc.add(IsAuthorizedEvent());
  }

  @override
  void didPush() {
    super.didPush();
    meBloc.add(IsAuthorizedEvent());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void initState() {
    super.initState();
    meBloc = GetIt.instance<MeBloc>();
  }

  @override
  void dispose() {
    meBloc.dispose();
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Me'),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRouter.settingsPage);
                },
                icon: Icon(Icons.settings))
          ],
        ),
        body: BaseBlocBuilder<MeBloc>(
          bloc: meBloc,
          builder: (BuildContext context, BaseState state) {
            return state.runtimeType == AuthorizedState
                ? _meForm(state as AuthorizedState)
                : _unauthorizedForm();
          },
        ));
  }

  Widget _meForm(AuthorizedState state) {
    return Center(
      child: Text(state.userModel.email),
    );
  }

  Widget _unauthorizedForm() {
    return Center(
        child: Column(
      children: [
        Text('unauthorized'),
        TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const LoginUserPage();
                  },
                  fullscreenDialog: true));
            },
            child: Text('Login as user'))
      ],
    ));
  }
}
