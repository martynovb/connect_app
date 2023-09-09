import 'package:connect_app/presentation/page/home/home_bloc.dart';
import 'package:connect_app/presentation/page/home/home_page.dart';
import 'package:connect_app/presentation/page/me/me_block.dart';
import 'package:connect_app/presentation/page/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ConnectApp extends StatefulWidget {
  const ConnectApp({super.key});

  @override
  State<StatefulWidget> createState() => _ConnectAppState();
}

class _ConnectAppState extends State<ConnectApp> {
  ThemeMode themeMode = ThemeMode.dark;

  bool get useLightMode {
    switch (themeMode) {
      case ThemeMode.system:
        return View.of(context).platformDispatcher.platformBrightness ==
            Brightness.light;
      case ThemeMode.light:
        return true;
      case ThemeMode.dark:
        return false;
    }
  }

  void handleBrightnessChange(bool useLightMode) {
    setState(() {
      themeMode = useLightMode ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => GetIt.instance<MeBloc>(),
          ),
          BlocProvider(
            create: (context) => GetIt.instance<HomeBloc>(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomePage(),
          routes: AppRouter.routes,
        ));
  }
}
