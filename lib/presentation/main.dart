import 'package:connect_app/data/repo/auth_repo.dart';
import 'package:connect_app/presentation/connect_app.dart';
import 'package:connect_app/presentation/page/me/me_block.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';

void main() {
  _setupServices();
  runApp(const ConnectApp());
}

void _setupServices() {
  GetIt.instance.registerSingleton<AuthRepository>(AuthRepository());
  GetIt.instance.registerSingleton<MeBloc>(MeBloc(authRepository: GetIt.instance<AuthRepository>()));
}
