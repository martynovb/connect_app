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

class _MePageState extends State<MePage> {
  MeBloc? meBloc;

  @override
  void initState() {
    super.initState();
    meBloc = GetIt.instance<MeBloc>();
    meBloc?.add(IsAuthorizedEvent());
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
            return Center(
              child: Text('Me page: ${state.runtimeType}'),
            );
          },
        ));
  }
}
