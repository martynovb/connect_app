import 'package:connect_app/presentation/connect_app.dart';
import 'package:connect_app/presentation/page/auth/auth_bloc.dart';
import 'package:connect_app/presentation/page/base/base_bloc_builder.dart';
import 'package:connect_app/presentation/page/me/me_block.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late AuthBloc authBloc;

  @override
  void initState() {
    super.initState();
    authBloc = GetIt.instance<AuthBloc>();
  }

  @override
  void dispose() {
    authBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
      ),
      body: BaseBlocBuilder(
        bloc: authBloc,
        builder: (context, state) {
          return Center(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      authBloc.add(LogoutEvent());
                    },
                    child: const Text(
                      'Logout',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
                Spacer()
              ],
            ),
          );
        },
      ),
    );
  }
}
