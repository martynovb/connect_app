import 'package:connect_app/presentation/page/home/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ConnectApp());
}

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
    return MaterialApp(
      home: Scaffold(
        body: HomePage(),
        bottomNavigationBar: _bottomNavigationBar(),
      ),
    );
  }

  BottomNavigationBar _bottomNavigationBar() {
    return BottomNavigationBar(items: [
      BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
      BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Collections'),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Me'),
    ]);
  }
}
