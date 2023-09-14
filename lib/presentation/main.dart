import 'package:connect_app/data/api/token_provider.dart';
import 'package:connect_app/presentation/connect_app.dart';
import 'package:connect_app/presentation/di.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await TokenProvider().openBox();
  Injector.inject();
  runApp(const ConnectApp());
}
