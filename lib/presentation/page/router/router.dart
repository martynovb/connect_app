import 'package:connect_app/presentation/page/home/home_page.dart';
import 'package:connect_app/presentation/page/me/me_page.dart';
import 'package:connect_app/presentation/page/settings/settings_page.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static const homePage = '/home';
  static const mePage = '/me';
  static const settingsPage = '/settings';

  static final Map<String, WidgetBuilder> routes = {
    homePage: (context) => HomePage(),
    mePage: (context) => MePage(),
    settingsPage: (context) => SettingsPage(),
  };
}
